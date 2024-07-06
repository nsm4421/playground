package com.karma.chat.controller

import com.karma.chat.controller.dto.SignUpWithEmailAndPasswordDto
import com.karma.chat.model.Account
import com.karma.chat.service.AccountService
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RequestParam
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping("/api")
class AuthController (
    private val authService: AccountService
){
    @PostMapping("/signup")
    fun signUpWithEmailAndPassword(
        @RequestParam req:SignUpWithEmailAndPasswordDto
    ):ResponseEntity<Long>{
        val account = Account()
        account.username = req.username
        account.email = req.email
        account.password = req.password
        val id = authService.save(account).id;
        return ResponseEntity.ok(id);
    }
}