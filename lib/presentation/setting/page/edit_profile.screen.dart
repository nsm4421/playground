import 'package:flutter/material.dart';
import 'package:hot_place/presentation/component/content_text_field.widget.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _usernameTec;

  @override
  void initState() {
    super.initState();
    _usernameTec = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _usernameTec.dispose();
  }

  // TODO : 프로필 수정하기 기능
  _submit() {}

  // TODO : Bloc을 사용해 refactoreing
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("프로필 수정하기"),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: _submit,
              icon: Icon(
                Icons.upload,
                color: Theme.of(context).colorScheme.primary,
              ),
              tooltip: "프로필 수정",
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: ContentTextField(
                  tec: _usernameTec,
                  label: "USERNAME",
                  minLines: 1,
                  maxLines: 1,
                  maxLength: 30,
                ),
              ),

              // TODO : 사진 업로드
            ],
          ),
        ),
      );
}
