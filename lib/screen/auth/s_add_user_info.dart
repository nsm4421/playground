import 'package:chat_app/common/widget/w_size.dart';
import 'package:chat_app/common/widget/w_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddUserInfoScreen extends StatefulWidget {
  const AddUserInfoScreen({super.key});

  @override
  State<AddUserInfoScreen> createState() => _AddUserInfoScreenState();
}

class _AddUserInfoScreenState extends State<AddUserInfoScreen> {
  late TextEditingController _nicknameController;

  @override
  initState() {
    super.initState();
    _nicknameController = TextEditingController();
  }

  // TODO : 썸네일 버튼 클릭 시
  _handleClickAddThumbnail() {}

  // TODO : 썸네일 버튼 클릭 시
  _handleClickNextButton() {}

  @override
  Widget build(BuildContext context) {
    const double fontSizeLg = 25;
    const double fontSizeMd = 18;
    const double marginSizeLg = 30;
    const double marginSizeSm = 10;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Profile",
            style: GoogleFonts.lobster(
                fontSize: fontSizeLg, color: Colors.white70),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              /// header
              const Height(height: marginSizeLg),
              const Center(
                child: Text(
                  "회원가입이 완료되었습니다",
                  style: TextStyle(fontSize: fontSizeLg),
                ),
              ),
              const Height(height: marginSizeSm),
              const Center(
                child: Text(
                  "프로필 정보를 등록해주세요",
                  style: TextStyle(fontSize: fontSizeMd),
                ),
              ),
              const Height(height: 2 * marginSizeLg),

              /// 프로필 이미지
              InkWell(
                onTap: _handleClickAddThumbnail,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.blueGrey),
                  child: const Icon(
                    Icons.add_a_photo_outlined,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ),
              const Height(height: marginSizeLg),

              /// 닉네임 입력
              Container(
                padding: const EdgeInsets.symmetric(horizontal: marginSizeLg),
                child: CustomTextFieldWidget(
                  hintText: "닉네임",
                  controller: _nicknameController,
                  fontSize: fontSizeMd,
                ),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

        /// next 버튼
        floatingActionButton: ElevatedButton(
          onPressed: _handleClickNextButton,
          child: const Text(
            "NEXT",
            style: TextStyle(fontSize: fontSizeMd),
          ),
        ),
      ),
    );
  }
}
