import 'package:chat_app/common/widget/w_size.dart';
import 'package:chat_app/common/widget/w_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddUserInfo extends StatefulWidget {
  const AddUserInfo({super.key});

  @override
  State<AddUserInfo> createState() => _AddUserInfoState();
}

class _AddUserInfoState extends State<AddUserInfo> {

  late TextEditingController _nicknameController;

  @override
  initState(){
    super.initState();
    _nicknameController = TextEditingController();
  }

  // TODO : 썸네일 버튼 클릭 시
  _handleClickAddThumbnail(){}

  AppBar _appBar() {
    return AppBar(
      centerTitle: true,
      title: Text(
        "Profile",
        style: GoogleFonts.lobster(fontSize: 25),
      ),
    );
  }

  Widget _header() {
    return const Center(
      child: Text(
        "프로필 정보를 등록해주세요",
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  Widget _addThumbnailButton() {
    return InkWell(
      onTap: _handleClickAddThumbnail,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50), color: Colors.blueGrey),
        child: const Icon(
          Icons.add_a_photo_outlined,
          size: 30,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _nicknameTextInput(){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: CustomTextField(
        hintText: "닉네임",
        controller: _nicknameController,
        fontSize: 20,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _appBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Height(height: 30),
              _header(),
              const Height(height: 30),
              _addThumbnailButton(),
              const Height(height: 30),
              _nicknameTextInput(),
            ],
          ),
        ),
      ),
    );
  }
}
