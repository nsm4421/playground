import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class IndexPage extends StatelessWidget {
  const IndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("INDEX PAGE"),
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () async {
                await (Dio(BaseOptions(baseUrl: 'https://10.0.2.2:8080'))).post(
                    '/api/auth/signup/email',
                    data: {
                      'email': 'test5@naver.com',
                      'password': '1221'
                    });
              },
              child: Text("Sign Up"))
        ],
      ),
    );
  }
}
