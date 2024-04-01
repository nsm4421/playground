import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hot_place/data/entity/user/user.entity.dart';
import 'package:hot_place/presentation/auth/bloc/auth.bloc.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late UserEntity _currentUser;
  late TextEditingController _textEditingController;
  final ImagePicker _imagePicker = ImagePicker();
  File? _image;

  @override
  void initState() {
    super.initState();
    _currentUser = context.read<AuthBloc>().currentUser!;
    _textEditingController = TextEditingController();
    _textEditingController.text = _currentUser.nickname ?? '';
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
  }

  _handleSelectImage() async {
    final res = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (res != null) {
      setState(() {
        _image = File(res.path);
      });
    }
  }

  _handleClearImage() => setState(() {
        _image = null;
      });

  _handleSubmit() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("프로필 수정"),
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          // 프로필 이미지
          Padding(
            padding: const EdgeInsets.only(top: 30, right: 10, left: 10),
            child: Stack(
              children: [
                // 이미지를 선택하지 않은 경우
                GestureDetector(
                  onTap: _handleSelectImage,
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width * 1 / 2,
                    height: MediaQuery.of(context).size.width * 1 / 2,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.primaryContainer),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.add_a_photo_outlined, size: 40),
                        const SizedBox(height: 10),
                        Text("Photo",
                            style: Theme.of(context).textTheme.bodyLarge),
                      ],
                    ),
                  ),
                ),

                // 이미지
                if (_image != null)
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width * 1 / 2,
                    height: MediaQuery.of(context).size.width * 1 / 2,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover, image: FileImage(_image!)),
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.primaryContainer),
                  ),

                // 이미지 취소 버튼
                if (_image != null)
                  Positioned(
                      right: 5,
                      top: 0,
                      child: IconButton(
                          icon: const Icon(Icons.clear, size: 30),
                          onPressed: _handleClearImage)),
              ],
            ),
          ),

          // 닉네임
          Padding(
            padding: const EdgeInsets.only(top: 30, right: 10, left: 10),
            child: Column(
              children: [
                TextField(
                  controller: _textEditingController,
                  maxLength: 30,
                  decoration: InputDecoration(
                      hintText: "닉네임을 작명해주세요",
                      helperText: "30자 내외 닉네임을 작명해주세요",
                      helperStyle: Theme.of(context)
                          .textTheme
                          .labelMedium
                          ?.copyWith(
                              color: Theme.of(context).colorScheme.secondary),
                      border: const OutlineInputBorder()),
                ),
              ],
            ),
          ),

          // 제출하기 버튼
          Padding(
              padding: const EdgeInsets.only(top: 50, right: 15, left: 15),
              child: ElevatedButton(
                  onPressed: _handleSubmit,
                  child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: Text(
                        "제출하기",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ))))
        ])));
  }
}
