import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_app/core/util/toast.util.dart';
import 'package:my_app/presentation/bloc/user/user.bloc.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  static const int _maxLengthNickname = 20;
  static const int _maxLengthDescription = 300;

  late ImagePicker _imagePicker;
  late TextEditingController _nicknameTec;
  late TextEditingController _descriptionTec;

  XFile? _xFile;

  @override
  void initState() {
    super.initState();
    _imagePicker = ImagePicker();
    _nicknameTec = TextEditingController();
    _descriptionTec = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _nicknameTec.dispose();
    _descriptionTec.dispose();
  }

  _handleSelectImage() async {
    try {
      _xFile = await _imagePicker.pickImage(source: ImageSource.gallery);
      setState(() {});
    } catch (error) {
      log('이미지 선택 오류 ${error.toString()}');
    }
  }

  _handleCancelImage() {
    setState(() {
      _xFile = null;
    });
  }

  _handleSubmit() {
    if (_nicknameTec.text.trim().isEmpty) {
      ToastUtil.toast('닉네임을 입력해주세요');
      return;
    } else if (_descriptionTec.text.trim().isEmpty) {
      ToastUtil.toast('자기소개를 입력해주세요');
      return;
    } else if (_xFile?.path == null) {
      ToastUtil.toast('프로필 사진을 등록해주세요');
      return;
    }
    context.read<UserBloc>().add(OnBoardingEvent(
        image: File(_xFile!.path),
        nickname: _nicknameTec.text.trim(),
        description: _descriptionTec.text.trim()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ONBOARDING"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 이미지
            Padding(
                padding: const EdgeInsets.only(top: 15, left: 8, right: 8),
                child: _xFile?.path == null
                    // 이미지 선택 버튼
                    ? GestureDetector(
                        onTap: _handleSelectImage,
                        child: CircleAvatar(
                          radius: MediaQuery.of(context).size.width / 3,
                          child: Icon(
                            Icons.add_a_photo_outlined,
                            size: MediaQuery.of(context).size.width / 6,
                          ),
                        ),
                      )
                    // 이미지 미리보기
                    : Stack(
                        children: [
                          Positioned(
                              top: 0,
                              right: 0,
                              child: IconButton(
                                  onPressed: _handleCancelImage,
                                  icon: const Icon(Icons.clear, size: 35))),
                          CircleAvatar(
                              radius: MediaQuery.of(context).size.width / 3,
                              backgroundImage: FileImage(File(_xFile!.path))),
                        ],
                      )),

            // 닉네임
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 8, right: 8),
              child: TextFormField(
                maxLength: _maxLengthNickname,
                controller: _nicknameTec,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    decorationThickness: 0, fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.account_circle_outlined),
                    helperText: '$_maxLengthNickname자 내외로 닉네임을 작명해주세요',
                    counterStyle: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(
                            color: Theme.of(context).colorScheme.tertiary)),
              ),
            ),

            // 자기소개
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 8, right: 8),
              child: TextFormField(
                maxLength: _maxLengthDescription,
                controller: _descriptionTec,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    decorationThickness: 0, fontWeight: FontWeight.bold),
                minLines: 3,
                maxLines: 8,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    helperText: '$_maxLengthDescription자 내외로 자기소개를 해주세요',
                    counterStyle: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(
                            color: Theme.of(context).colorScheme.tertiary)),
              ),
            ),

            // 제출버튼
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 8, right: 8),
              child: ElevatedButton(
                  onPressed: _handleSubmit,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "SUBMIT",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                      )
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
