package com.karma.chat.controller

import com.karma.chat.controller.dto.BodyDto
import com.karma.chat.controller.dto.auth.AuthRequestDto
import com.karma.chat.controller.dto.auth.SignInResponseDto
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
        @RequestBody req: AuthRequestDto
    ): ResponseEntity<BodyDto<String>> {
        try {
            val username = accountService.signUpWithEmailAndPassword(
                email = req.email, rawPassword = req.password
            )
            return ResponseEntity.ok(BodyDto(message = "success", data = username))
        } catch (e: Exception) {
            e.printStackTrace();
            return ResponseEntity.status(500).body(BodyDto(message = "sign up fail"))
        }
    }

    @PostMapping("/signin/email")
    fun signInWithEmailAndPassword(
        @RequestBody req: AuthRequestDto, response: HttpServletResponse
    ): ResponseEntity<BodyDto<SignInResponseDto>> {
        try {
            val account = accountService.signInWithEmailAndPassword(req.email, req.password)
            val jwt = accountService.generateJwt(account)
            return ResponseEntity.ok(
                BodyDto(message = "success", data = SignInResponseDto(jwt = jwt, account = account))
            )
        } catch (e: Exception) {
            e.printStackTrace();
            return ResponseEntity.status(500).body(BodyDto(message = "sign in fail"))
        }
    }
}