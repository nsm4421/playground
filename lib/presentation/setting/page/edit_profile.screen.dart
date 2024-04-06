import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hot_place/core/util/image.util.dart';
import 'package:hot_place/core/util/toast.util.dart';
import 'package:hot_place/data/entity/user/user.entity.dart';
import 'package:hot_place/presentation/auth/widget/loading.widget.dart';
import 'package:hot_place/presentation/setting/bloc/user.bloc.dart';
import 'package:hot_place/presentation/setting/bloc/user.state.dart';
import 'package:hot_place/presentation/setting/widget/edit_profile_error.widget.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/constant/response.constant.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocListener<UserBloc, UserState>(
        listener: (_, state) {
          if (state.status == Status.success && context.mounted) {
            context.pop();
          }
        },
        child: BlocBuilder<UserBloc, UserState>(
          builder: (_, state) {
            switch (state.status) {
              case Status.initial:
              case Status.success:
                return const _View();
              case Status.loading:
                return const LoadingWidget('Loadings...');
              case Status.error:
                return EditProfileErrorWidget(state.error);
            }
          },
        ),
      );
}

class _View extends StatefulWidget {
  const _View({super.key});

  @override
  State<_View> createState() => _ViewState();
}

class _ViewState extends State<_View> {
  late UserEntity _currentUser;
  late TextEditingController _textEditingController;
  final ImagePicker _imagePicker = ImagePicker();
  File? _initialImage; // 유저의 기존 프로필 이미지
  File? _profileImage; // 유저가 선택한 프로필 이미지

  @override
  void initState() {
    super.initState();
    _currentUser = context.read<UserBloc>().state.user;
    _textEditingController = TextEditingController();
    _textEditingController.text = _currentUser.nickname ?? '';
    // 현재 유저의 기존 프로필 사진 가져오기
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (_currentUser.profileImage != null) {
        _initialImage =
            await ImageUtil.downloadImage(_currentUser.profileImage!);
        setState(() {});
      }
    });
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
        _profileImage = File(res.path);
      });
    }
  }

  _handleClearImage() => setState(() {
        _initialImage = null;
        _profileImage = null;
      });

  _handleSubmit() {
    final nickname = _textEditingController.text.trim();
    if (nickname.isEmpty) {
      ToastUtil.toast('닉네임을 입력해주세요');
      return;
    }
    context.read<UserBloc>().add(ModifyProfileEvent(
        currentUser: _currentUser, nickname: nickname, image: _profileImage));
  }

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
                if (_initialImage != null || _profileImage != null)
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width * 1 / 2,
                    height: MediaQuery.of(context).size.width * 1 / 2,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(_profileImage ?? _initialImage!)),
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.primaryContainer),
                  ),

                // 이미지 취소 버튼
                if (_initialImage != null || _profileImage != null)
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
                  onPressed:
                      // 로딩중인 경우, 버튼을 누를 수 없음
                      (context.read<UserBloc>().state.status != Status.loading)
                          ? _handleSubmit
                          : null,
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
