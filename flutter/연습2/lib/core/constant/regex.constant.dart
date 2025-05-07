part of '../export.core.dart';

enum Regex {
  email,
  password,
  username,
  nickname;
}

extension RegexExtension on Regex {
  RegExp get regex => switch (this) {
        Regex.email =>
          RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'),

        // (?=.*[0-9]) : 최소한 하나의 숫자 포함
        // (?=.*[!@#$%^&*(),.?":{}|<>]) : 특수문자를 최소 하나 포함
        // (?=.*[a-zA-Z]) : 영어를 최소 하나 포함
        // .{8,}$ : 최소 8글자
        Regex.password => RegExp(
            r'^(?=.*[0-9])(?=.*[!@#$%^&*(),.?":{}|<>])(?=.*[a-zA-Z]).{8,}$'),

        // 최소 6글자 이상, 알파벳과 한글, 숫자를 이용해서 작명
        Regex.username => RegExp(r'[a-zA-Z0-9ㄱ-ㅎ가-힣]{6,}'),

        // 최소 3글자 이상, 알파벳과 한글, 숫자를 이용해서 작명
        Regex.nickname => RegExp(r'[a-zA-Z0-9ㄱ-ㅎ가-힣]{3,}'),
      };

  String? Function(String? text) get validate => switch (this) {
        Regex.email => (text) {
            if (text == null) {
              return 'Email is not given';
            } else if (!this.regex.hasMatch(text)) {
              return "Invalid Email";
            } else {
              return null;
            }
          },
        Regex.password => (text) {
            if (text == null || text.length < 8) {
              return 'Password must be at least 8 characters';
            } else if (!this.regex.hasMatch(text)) {
              return 'Password must contain special symbol';
            } else {
              return null;
            }
          },
        // 최소 6글자 이상, 알파벳과 한글, 숫자를 이용해서 작명
        Regex.username => (text) {
            if (text == null || text.length < 6) {
              return 'Username must be at least 6 characters';
            } else if (!this.regex.hasMatch(text)) {
              return 'Username should be composed solely of Hangul or alphabetic characters and digits';
            } else {
              return null;
            }
          },
        // 최소 3글자 이상, 알파벳과 한글, 숫자를 이용해서 작명
        Regex.nickname => (text) {
            if (text == null || text.length < 3) {
              return 'Nickname must be at least 3 characters';
            } else if (!this.regex.hasMatch(text)) {
              return 'Nickname should be composed solely of Hangul or alphabetic characters and digits';
            } else {
              return null;
            }
          },
      };
}
