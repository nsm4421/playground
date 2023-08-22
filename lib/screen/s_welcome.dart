import 'package:chat_app/common/routes/routes.dart';
import 'package:chat_app/common/widget/w_size.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  // 전화번호로 회원가입 페이지로
  void _handleRegister(BuildContext context) =>
      Navigator.pushNamed(context, CustomRoutes.addPhoneNumber);

  @override
  Widget build(BuildContext context) {
    const double marginSizeLg = 30;
    const double marginSizeSm = 10;
    const double marginSizeTn = 5;
    const double fontSizeXl = 45;
    const double fontSizeLg = 30;
    const double fontSizeMd = 18;
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              const Height(height: marginSizeLg),

              /// header
              Column(
                children: [
                  Text(
                    "Karma",
                    style: GoogleFonts.lobsterTwo(fontSize: fontSizeXl),
                  ),
                  const Height(height: marginSizeLg),
                  Text(
                    "Welcome to chat app",
                    style: GoogleFonts.lobsterTwo(fontSize: fontSizeLg),
                  ),
                ],
              ),
              // TODO : 앱 로고 이미지 넣기
              const Expanded(child: SizedBox()),

              /// 회원가입 버튼
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _handleRegister(context);
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: marginSizeSm),
                      child: SizedBox(
                        width: 200,
                        child: Center(
                          child: Text(
                            "전화번호로 회원가입",
                            style: TextStyle(
                              fontSize: fontSizeMd,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Height(height: marginSizeTn),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: marginSizeLg,
                  vertical: marginSizeSm,
                ),
                child: Divider(),
              ),

              /// footer
              const Text(
                "nsm4421@gmail.com",
                style: TextStyle(color: Colors.grey),
              ),
              const Height(height: marginSizeLg)
            ],
          ),
        ),
      ),
    );
  }
}
