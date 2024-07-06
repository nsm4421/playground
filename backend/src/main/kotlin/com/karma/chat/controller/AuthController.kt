package com.karma.chat.controller

import com.karma.chat.controller.dto.BodyDto
import com.karma.chat.controller.dto.SignInWithEmailAndPasswordDto
import com.karma.chat.controller.dto.SignUpWithEmailAndPasswordDto
import com.karma.chat.domain.Account
import com.karma.chat.service.AccountService
import io.jsonwebtoken.Jwts
import jakarta.servlet.http.Cookie
import jakarta.servlet.http.HttpServletResponse
import org.springframework.beans.factory.annotation.Value
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.CookieValue
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping("/api/auth")
class AuthController(
    private val accountService: AccountService
) {
    @Value("\${jwt.secret}")
    lateinit var jwtSecret: String

    @PostMapping("/signup/email")
    fun signUpWithEmailAndPassword(
        @RequestBody req: SignUpWithEmailAndPasswordDto
    ): ResponseEntity<BodyDto<Long>> {
        val account = Account()
        account.username = req.username
        account.email = req.email
        account.password = req.password
        return ResponseEntity.ok(BodyDto(message = "success", data = accountService.save(account).id))
    }

    @PostMapping("/signin/email")
    fun signInWithEmailAndPassword(
        @RequestBody req: SignInWithEmailAndPasswordDto,
        response: HttpServletResponse
    ): ResponseEntity<BodyDto<Void>> {
        val account = this.accountService.findByEmail(req.email)
        if (account == null) {
            return ResponseEntity.status(404).body(BodyDto(message = "email not found"))
        } else if (!account.comparePassword(req.password)) {
            return ResponseEntity.status(401).body(BodyDto(message = "password not matched"))
        }
        val cookie = Cookie("jwt", account.generateJwt(jwtSecret))
        cookie.isHttpOnly = true
        response.addCookie(cookie)
        return ResponseEntity.ok(BodyDto(message = "success"));
    }

    @GetMapping
    fun account(@CookieValue("jwt") jwt: String?): ResponseEntity<BodyDto<Account>> {
        try {
            if (jwt == null) {
                return ResponseEntity.status(401).body(BodyDto(message = "not authenticated"))
            }
            val uid = Jwts.parser().setSigningKey(jwtSecret).parseClaimsJws(jwt).body.issuer.toLong()
            val account = accountService.findById(uid)
            return ResponseEntity.ok(BodyDto(message = "success", data = account))
        } catch (e: Exception) {
            return ResponseEntity.status(401).body(BodyDto(message = "jwt is invalid"))
        }
    }

    @GetMapping("/signout")
    fun signOut(response: HttpServletResponse): ResponseEntity<BodyDto<Void>> {
        try {
            val cookie = Cookie("jwt", "")
            cookie.maxAge = 0
            response.addCookie(cookie)
            return ResponseEntity.status(401).body(BodyDto(message = "success"))
        } catch (e: Exception) {
            return ResponseEntity.status(401).body(BodyDto(message = "sign out fails"))
        }
    }
}