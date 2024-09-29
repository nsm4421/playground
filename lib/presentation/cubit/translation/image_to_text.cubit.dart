import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:injectable/injectable.dart';
import 'package:travel/core/constant/constant.dart';

import '../../../core/util/util.dart';

part 'image_to_text.state.dart';

@lazySingleton
class ImageToTextCubit extends Cubit<ImageToTextState> {
  late TextRecognizer _textRecognizer;

  ImageToTextCubit() : super(ImageToTextState()) {
    _textRecognizer = TextRecognizer(script: TextRecognitionScript.korean);
  }

  @override
  Future<void> close() {
    _textRecognizer.close();
    return super.close();
  }

  void reset() {
    emit(state.copyWith(isLoading: true));
    // 0.5초간 throttle울 줌
    Timer(const Duration(milliseconds: 500), () {
      emit(ImageToTextState());
    });
  }

  // bonding box를 그릴 때 화면에 표현하는 크기에 맞게 조절해야 함
  List<Block> getAdjustedBox(
      {required double screenWidth, required double screenHeight}) {
    if (state.selectedImage == null) throw Exception('이미지가 선택되지 않았습니다');
    double widthRatio = screenWidth / state.selectedImage!.width;
    double heightRatio = screenHeight / state.selectedImage!.height;
    return state.blocks
        .map((item) => Block(
            left: item.left * widthRatio,
            top: item.top * heightRatio,
            width: item.width * widthRatio,
            height: item.height * heightRatio,
            text: item.text))
        .toList();
  }

  void handleSetSelectedImageIndex(int? selectedIndex) {
    if (state.selectedImage == null || state.blocks.isEmpty) {
      throw Exception('이미지가 선택되지 않았습니다');
    }
    emit(state.copyWithSelectedIndex(selectedIndex));
  }

  Future<void> handleSelectImage() async {
    // status가 로딩중이거나 오류인 경우 실행하지 않음
    if (!state.status.ok) return;
    try {
      emit(state.copyWith(status: Status.loading));
      // 이미지 선택 및 압축
      final compressed = await customUtil.pickImageAndReturnCompressedImage(
          filename: 'select-image-to-translate.jpg');
      if (compressed == null) return;
      // 원본 이미지 크기 추출
      final decodedImage =
          await decodeImageFromList(await compressed.readAsBytes());
      final originalImageWidth = decodedImage.width.toDouble();
      final originalImageHeight = decodedImage.height.toDouble();
      // 텍스트 및 bounding box 추출
      final RecognizedText recognizedText =
          await _textRecognizer.processImage(InputImage.fromFile(compressed));
      final blocks = recognizedText.blocks
          .map((item) => Block(
              left: item.boundingBox.left,
              top: item.boundingBox.top,
              width: item.boundingBox.width,
              height: item.boundingBox.height,
              text: item.text))
          .toList();
      // 상태 업데이트
      emit(state
          .copyWith(
              status: Status.success,
              selectedImage: SelectedImage(
                  image: compressed,
                  width: originalImageWidth,
                  height: originalImageHeight),
              blocks: blocks,
              originalText: recognizedText.text)
          .copyWithSelectedIndex(blocks.isEmpty ? null : 0));
    } on Exception catch (error) {
      customUtil.logger.e(error);
      emit(state.copyWith(
          status: Status.error, errorMessage: '이미지 선택 중 오류가 발생했습니다'));
    }
  }
}
