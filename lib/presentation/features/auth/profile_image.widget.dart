import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/controller/register.controller.dart';

class ProfileImageWidget extends GetView<RegisterController> {
  const ProfileImageWidget({super.key});

  _handlePickImageFileFromGallery() async =>
      await controller.pickImageFileFromGallery(fromGallery: true);

  _handlePickImageFileFromCamera() async =>
      await controller.pickImageFileFromGallery(fromGallery: false);

  _handleCancelProfileImage() => controller.cancelProfileImage();

  @override
  Widget build(BuildContext context) => Obx(
        () => controller.profileImage.value == null

            /// 프로필 이미지를 선택하지 않은 경우
            ? Stack(
                children: [
                  const Positioned(
                    child: Column(
                      children: [
                        CircleAvatar(
                            radius: 80,
                            backgroundColor: Colors.blueGrey,
                            child: Icon(Icons.person_outline, size: 80)),
                        SizedBox(height: 10)
                      ],
                    ),
                  ),
                  Positioned(
                      bottom: 0,
                      left: 20,
                      child: IconButton(
                        icon: const Icon(Icons.add_a_photo_outlined, size: 30),
                        onPressed: _handlePickImageFileFromCamera,
                      )),
                  Positioned(
                    bottom: 0,
                    right: 20,
                    child: IconButton(
                      icon: const Icon(Icons.image_search_outlined, size: 30),
                      onPressed: _handlePickImageFileFromGallery,
                    ),
                  ),
                ],
              )

            /// 프로필 이미지를 선택한 경우
            : Stack(
                children: [
                  Positioned(
                    child: Column(
                      children: [
                        Container(
                            height: 180,
                            width: 180,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(90),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: FileImage(File(controller
                                        .profileImage.value!.path))))),
                        const SizedBox(height: 10)
                      ],
                    ),
                  ),
                  Positioned(
                      top: 0,
                      right: 20,
                      child: IconButton(
                        icon: const Icon(Icons.cancel, size: 30),
                        onPressed: _handleCancelProfileImage,
                      )),
                ],
              ),
      );
}
