package com.karma.chat.util

import org.springframework.security.access.prepost.PreAuthorize

@Target(AnnotationTarget.FUNCTION, AnnotationTarget.CLASS)
@Retention(AnnotationRetention.RUNTIME)
@PreAuthorize("hasAuthority('ADMIN')")
annotation class AdminAuthorize

@Target(AnnotationTarget.FUNCTION, AnnotationTarget.CLASS)
@Retention(AnnotationRetention.RUNTIME)
@PreAuthorize("hasAuthority('USER')")
annotation class UserAuthorize