package com.karma.chat.controller

import com.karma.chat.controller.dto.BodyDto
import com.karma.chat.controller.dto.GetCurrentAccountResponseDto
import com.karma.chat.controller.dto.SignInWithEmailAndPasswordDto
import com.karma.chat.controller.dto.SignUpWithEmailAndPasswordDto
import com.karma.chat.service.AccountService
import jakarta.servlet.http.HttpServletResponse
import org.springframework.data.crossstore.ChangeSetPersister.NotFoundException

import org.springframework.http.ResponseEntity
import org.springframework.security.core.annotation.AuthenticationPrincipal
import org.springframework.security.core.userdetails.User
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

    @PostMapping("/signup/email")
    fun signUpWithEmailAndPassword(
        @RequestBody req: SignUpWithEmailAndPasswordDto
    ): ResponseEntity<BodyDto<Long>> {
        try {
            val uid = accountService.signUpWithEmailAndPassword(
                username = req.username,
                email = req.email,
                rawPassword = req.password
            )
            return ResponseEntity.ok(BodyDto(message = "success", data = uid))
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

    @GetMapping("/me")
    fun getCurrentAccount(@AuthenticationPrincipal user: User): ResponseEntity<BodyDto<GetCurrentAccountResponseDto>> {
        try {
            val account = accountService.findByUsername(user.username)
                ?: throw NotFoundException()
            return ResponseEntity.ok()
                .body(BodyDto(message = "success", data = GetCurrentAccountResponseDto.from(account)))
        } catch (e: Exception) {
            e.printStackTrace();
            return ResponseEntity.status(500).body(BodyDto(message = "getting current account fail"))
        }
    }
}