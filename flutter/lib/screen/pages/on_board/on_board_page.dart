import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_prj/states_management/on_board/on_boarding_cubit.dart';
import 'package:flutter_prj/states_management/on_board/on_boarding_state.dart';
import 'package:flutter_prj/states_management/on_board/profile_image_cubit.dart';

import '../../widgets/elevated_button_widget.dart';
import '../../widgets/logo_widget.dart';
import '../../widgets/text_field_widget.dart';
import '../../widgets/upload_profile_widget.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  String _username;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              /// 로고
              logoWidget(context),
              const Spacer(),

              /// 프로필 사진
              const ProfileUploadWidget(),
              const Spacer(
                flex: 1,
              ),

              /// 닉네임 입력창
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomTextField(
                    hint: '유저명을 입력해주세요...',
                    height: 45.0,
                    onChanged: _handleUsername,
                    textInputAction: TextInputAction.done),
              ),
              const SizedBox(
                height: 20.0,
              ),

              /// 회원가입 버튼
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedBtn(
                    onPressed: _handleSubmit, btnText: "회원가입 하기", height: 45.0),
              ),
              const Spacer(),

              /// 로딩중
              BlocBuilder<OnBoardingCubit, OnBoardingState>(
                builder: (context, state) => state is OnBoardingLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container(),
              ),
              const Spacer()
            ],
          ),
        ));
  }

  String _checkUsername() {
    var err = "";
    if (_username.isEmpty) err = "유저명을 입력하지 않았습니다.";
    if (context.read<ProfileImageCubit>().state == null) {
      err = '$err\n프로필 사진을 업로드하지 않았습니다.';
    }
    return err;
  }

  _connectSession() async {
    final profileImage = context.read<ProfileImageCubit>().state;
    await context.read<OnBoardingCubit>().connect(_username, profileImage);
  }

  /// 제출 버튼 클릭
  /// 1) 유저명 검사 및 에러 메세징 처리
  /// 2) 이미지 업로드 서버(Node JS)와 연결
  _handleSubmit() async {
    final err = _checkUsername();
    if (err.isNotEmpty) {
      final sb = SnackBar(
          content: Text(
        err,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ));
      ScaffoldMessenger.of(context).showSnackBar(sb);
      return;
    }
    await _connectSession();
  }

  _handleUsername(text) {
    _username = text;
  }
}
