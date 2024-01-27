import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_app/domain/model/auth/user.model.dart';
import 'package:my_app/presentation/bloc/auth/auth.bloc.dart';
import 'package:my_app/presentation/bloc/user/user.bloc.dart';
import 'package:my_app/presentation/bloc/user/user.event.dart';

import '../../../../core/enums/status.enum.dart';
import '../../../bloc/auth/auth.state.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<AuthBloc, AuthState>(
      builder: (_, state) => state.status == Status.loading
          ? const _Loading()
          : const EditProfileView());
}

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  late UserModel? _user;
  late TextEditingController _nicknameTec;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late ImagePicker _picker;
  late XFile? _selectedImage;

  static const int _quality = 100;

  @override
  void initState() {
    super.initState();
    _user = context.read<UserBloc>().state.user;
    _nicknameTec = TextEditingController();
    _picker = ImagePicker();
    _nicknameTec.text = _user?.nickname ?? '';
    _selectedImage = null;
  }

  @override
  void dispose() {
    super.dispose();
    _nicknameTec.dispose();
  }

  _selectProfileImage(ImageSource source) => () async {
        final temp = await _picker.pickImage(
          source: source,
          imageQuality: _quality,
        );
        setState(() {
          _selectedImage = temp;
        });
      };

  _uploadProfile() {
    // check input
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    try {
      context.read<UserBloc>().add(EditProfile(
        nickname: _nicknameTec.text,
        profileImageData: _selectedImage
      ));
      // context.read<AuthBloc>().add(EditUserMetaData(
      //     nickname: _nicknameTec.text, profileImageData: _selectedImage));
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //     content: Text('프로필이 변경되었습니다'),
      //     duration: Duration(seconds: 2) // Adjust the duration as needed
      //     ));
    } catch (err) {
      debugPrint(err.toString());
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('프로필이 변경중 오류가 발생하였습니다'),
            duration: Duration(seconds: 2) // Adjust the duration as needed
            ));
      }
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("프로필 수정"),
          actions: [
            IconButton(
                tooltip: '제출하기',
                onPressed: _uploadProfile,
                icon: Icon(Icons.mode_edit,
                    color: Theme.of(context).colorScheme.primary, size: 30))
          ],
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 50),

              // 프로필 이미지
              GestureDetector(
                onTap: _selectProfileImage(ImageSource.gallery),
                child: _ProfileImage(
                    profileImage: _user?.profileImage,
                    selectedImage: _selectedImage),
              ),
              const SizedBox(height: 30),

              // 닉네임 텍스트 필드
              Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      children: [_NicknameTextField(_nicknameTec)],
                    ),
                  )),
            ],
          ),
        ),
      );
}

class _ProfileImage extends StatelessWidget {
  const _ProfileImage({super.key, this.profileImage, this.selectedImage});

  static const double _size = 200;

  final String? profileImage;
  final XFile? selectedImage;

  Widget _image() {
    if (selectedImage != null) {
      return Image.file(File(selectedImage!.path), fit: BoxFit.cover);
    } else if (profileImage != null) {
      return Image.network(profileImage!, fit: BoxFit.cover);
    } else {
      return const Center(
          child: Text(
        "프로필 사진이 없습니다",
        textAlign: TextAlign.center,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: CircleAvatar(
            radius: _size / 2,
            child: ClipOval(
              child: SizedBox(width: _size, height: _size, child: _image()),
            )));
  }
}

class _NicknameTextField extends StatelessWidget {
  const _NicknameTextField(this.tec, {super.key});

  static const int _maxLength = 20;

  final TextEditingController tec;

  _clear() => tec.clear();

  @override
  Widget build(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("닉네임",
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold)),
          const SizedBox(width: 20),
          Expanded(
            child: TextFormField(
              validator: (nickname) {
                if (nickname == null) return "error";
                if (nickname.isEmpty) return "닉네임을 입력해주세요";
                if (nickname.length < 3) return "최소 3글자로 작명해주세요";
                return null;
              },
              minLines: 1,
              maxLines: 1,
              maxLength: _maxLength,
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(decorationThickness: 0, letterSpacing: 1),
              decoration: InputDecoration(
                  hintText: '3~20자 아내로 작성해주세요',
                  counterText: '',
                  suffixIcon: IconButton(
                    onPressed: _clear,
                    icon: const Icon(Icons.clear),
                  )),
              controller: tec,
            ),
          ),
        ],
      );
}

class _Loading extends StatelessWidget {
  const _Loading({super.key});

  @override
  Widget build(BuildContext context) => const Center(
        child: CircularProgressIndicator(),
      );
}
