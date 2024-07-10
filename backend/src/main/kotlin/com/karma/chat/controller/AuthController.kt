package com.karma.chat.controller

import com.karma.chat.controller.dto.BodyDto
import com.karma.chat.controller.dto.auth.SignInWithEmailAndPasswordDto
import com.karma.chat.controller.dto.auth.SignUpWithEmailAndPasswordDto
import com.karma.chat.service.AccountService
import jakarta.servlet.http.HttpServletResponse

import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping("/api/auth")
class AuthController(
    private val accountService: AccountService
) {

    @PostMapping("/signup/email")
    fun signUpWithEmailAndPassword(
        @RequestBody req: SignUpWithEmailAndPasswordDto
    ): ResponseEntity<BodyDto<String>> {
        try {
            val username = accountService.signUpWithEmailAndPassword(
                email = req.email,
                rawPassword = req.password
            )
            return ResponseEntity.ok(BodyDto(message = "success", data = username))
        } catch (e: Exception) {
            e.printStackTrace();
            return ResponseEntity.status(500).body(BodyDto(message = "sign up fail"))
        }
    }

    @PostMapping("/signin/email")
    fun signInWithEmailAndPassword(
        @RequestBody req: SignInWithEmailAndPasswordDto,
        response: HttpServletResponse
    ): ResponseEntity<BodyDto<String>> {
        try {
            val jwt = this.accountService.signInWithEmailAndPassword(req.email, req.password)
            return ResponseEntity.ok(BodyDto(message = "success", data = jwt));
        } catch (e: Exception) {
            e.printStackTrace();
            return ResponseEntity.status(500).body(BodyDto(message = "sign in fail"))
        }
    }
}