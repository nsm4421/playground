import 'package:chat_app/common/routes/routes.dart';
import 'package:chat_app/common/widget/w_alert_message.dart';
import 'package:chat_app/common/widget/w_photo_item.dart';
import 'package:chat_app/common/widget/w_size.dart';
import 'package:chat_app/common/widget/w_text_feild.dart';
import 'package:chat_app/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class AddUserInfoScreen extends ConsumerStatefulWidget {
  const AddUserInfoScreen({super.key});

  @override
  ConsumerState<AddUserInfoScreen> createState() => _AddUserInfoScreenState();
}

class _AddUserInfoScreenState extends ConsumerState<AddUserInfoScreen> {
  XFile? _profileImage;
  late TextEditingController _usernameController;

  @override
  initState() {
    super.initState();
    _usernameController = TextEditingController();
  }

  @override
  dispose() {
    super.dispose();
    _usernameController.dispose();
  }

  // TODO : 썸네일 버튼 클릭 시
  _handleClickAddThumbnail(BuildContext context) async {
    final image = await Navigator.pushNamed(
      context,
      CustomRoutes.pickProfileImage,
    );

    if (image is XFile) {
      setState(() {
        _profileImage = image;
      });
    }
  }

  /// 프로필 등록
  void _handleClickNextButton() {
    // 닉네임 체크
    String username = _usernameController.text;
    if (username.isEmpty) {
      showAlertDialog(context: context, message: '유저명을 입력해주세요');
      return;
    }
    if (username.length < 3 || username.length > 20) {
      showAlertDialog(context: context, message: '유저명은 3~20 이내로 작명해주세요');
      return;
    }
    // TODO : 닉네임 중복 여부 검사
    // 프로필 이미지 검사
    if (_profileImage is! XFile) {
      showAlertDialog(context: context, message: '프로필 이미지를 등록해주세요');
      return;
    }

    ref.read(authControllerProvider).saveUserInfoInFirestore(
        username: username,
        profileImage: _profileImage!,
        context: context,
        mounted: mounted);
  }

  void _handleGoBackButton(BuildContext context) => Navigator.pop(context);

  @override
  Widget build(BuildContext context) {
    const double fontSizeLg = 25;
    const double fontSizeMd = 18;
    const double marginSizeLg = 30;
    const double marginSizeSm = 10;
    const double imageSize = 100;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              _handleGoBackButton(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              size: fontSizeLg,
            ),
          ),
          centerTitle: true,
          title: Text(
            "Profile",
            style: GoogleFonts.lobster(
                fontSize: fontSizeLg, color: Colors.white70),
          ),
        ),
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
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
              const Height(height: marginSizeLg),

              /// 프로필 이미지
              _profileImage is XFile
                  ? SizedBox(
                      width: imageSize,
                      height: imageSize,
                      child: PhotoItemWidget(xFile: _profileImage!))
                  : InkWell(
                      onTap: () {
                        _handleClickAddThumbnail(context);
                      },
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
                  hintText: "유저명을 입력해주세요",
                  controller: _usernameController,
                  fontSize: fontSizeMd,
                ),
              ),

              const Height(height: marginSizeLg),

              /// next 버튼
              ElevatedButton(
                onPressed: _handleClickNextButton,
                child: const Text(
                  "NEXT",
                  style: TextStyle(fontSize: fontSizeMd),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
