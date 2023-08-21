import 'package:chat_app/common/widget/w_alert_message.dart';
import 'package:chat_app/common/widget/w_photo_item.dart';
import 'package:chat_app/common/widget/w_size.dart';
import 'package:chat_app/screen/auth/s_add_user_info.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PickImageScreen extends StatefulWidget {
  const PickImageScreen({super.key});

  @override
  State<PickImageScreen> createState() => _PickImageScreenState();
}

class _PickImageScreenState extends State<PickImageScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? _pickedImage;

  void _pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    setState(() {
      _pickedImage = image;
    });
  }

  void _cancelImage() {
    setState(() {
      _pickedImage = null;
    });
  }

  void _handleGoBack(BuildContext context) => Navigator.pop(context);

  void _handleSelect(BuildContext context) {
    if (_pickedImage is! XFile) {
      showAlertDialog(context: context, message: '프로필 이미지를 선택해주세요');
      return;
    }
    // TODO : 데이터 전달
    Navigator.pop(context, _pickedImage);
  }

  @override
  Widget build(BuildContext context) {
    const double imageSize = 300;
    const double iconSize = 30;
    return Scaffold(
      appBar: AppBar(
        /// 뒤로가기 버튼
        leading: InkWell(
            onTap: () {
              _handleGoBack(context);
            },
            child: const Icon(Icons.arrow_back_ios)),
        centerTitle: true,
        title: const Text("이미지 선택하기"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Height(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                /// 사진찍기 버튼
                InkWell(
                  onTap: () {
                    _pickImage(ImageSource.camera);
                  },
                  child: const Column(
                    children: [
                      Icon(Icons.add_a_photo_outlined, size: 30),
                      Height(
                        height: 10,
                      ),
                      Text("사진찍기")
                    ],
                  ),
                ),

                /// 갤러리 버튼
                InkWell(
                  onTap: () {
                    _pickImage(ImageSource.gallery);
                  },
                  child: const Column(
                    children: [
                      Icon(Icons.photo_album, size: 30),
                      Height(
                        height: 10,
                      ),
                      Text("갤러리")
                    ],
                  ),
                ),
              ],
            ),
            const Height(height: 80),
            SizedBox(
              height: imageSize,
              width: imageSize,
              child: (_pickedImage is XFile)

                  /// 선택한 이미지
                  ? Stack(children: [
                      //이미지
                      Positioned.fill(
                        child: PhotoItemWidget(xFile: _pickedImage!),
                      ),
                      // 취소버튼
                      Positioned(
                          top: 5,
                          right: 5,
                          child: GestureDetector(
                            onTap: _cancelImage,
                            child: const Icon(
                              Icons.cancel_rounded,
                              color: Colors.black87,
                              size: iconSize,
                            ),
                          ))
                    ])
                  : const Center(
                      child: Text(
                        "선택한 이미지가 없습니다",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.grey,
                        ),
                      ),
                    ),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      /// 선택하기 버튼
      floatingActionButton: ElevatedButton(
        onPressed: () {
          _handleSelect(context);
        },
        child: const Text(
          "선택완료",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
