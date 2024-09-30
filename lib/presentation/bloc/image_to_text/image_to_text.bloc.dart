import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:injectable/injectable.dart';
import 'package:travel/core/util/util.dart';

import '../../../core/constant/constant.dart';

part 'image_to_text.state.dart';

part 'image_to_text.event.dart';

@lazySingleton
class ImageToTextBloc extends Bloc<ImageToTextEvent, ImageToTextState> {
  late TextRecognizer _textRecognizer;
  late OnDeviceTranslatorModelManager _modelManager;

  OnDeviceTranslator? _onDeviceTranslator;

  ImageToTextBloc() : super(ImageToTextState()) {
    _textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    _modelManager = OnDeviceTranslatorModelManager();
    on<SettingLanguageEvent>(_onSettingLang);
    on<CheckModelDownloadedEvent>(_onCheckModelDownloaded);
    on<DownloadModelEvent>(_onDownloadModel);
    on<SelectImageEvent>(_onSelectImage);
    on<UnSelectImageEvent>(_onUnSelect);
    on<ChangeSelectedBoxEvent>(_onChangeSelectedBox);
    on<TranslateEvent>(_onTranslate);
  }

  @override
  Future<void> close() async {
    await _textRecognizer.close();
    await _onDeviceTranslator?.close();
    return super.close();
  }

  Future<void> _onSettingLang(
      SettingLanguageEvent event, Emitter<ImageToTextState> emit) async {
    try {
      assert(state.step == ImageToTextStep.setting);
      emit(state.copyWith(status: Status.loading));
      _onDeviceTranslator = OnDeviceTranslator(
          sourceLanguage: event.sourceLang.lang,
          targetLanguage: event.targetLang.lang);
      final sourceLangModelLoaded =
          await _modelManager.isModelDownloaded(state.sourceLang.lang.bcpCode);
      final targetLangModelLoaded =
          await _modelManager.isModelDownloaded(state.targetLang.lang.bcpCode);
      emit(state.copyWith(
          step: sourceLangModelLoaded && targetLangModelLoaded
              ? ImageToTextStep.selectImage
              : ImageToTextStep.download,
          status: Status.success,
          sourceLang: event.sourceLang,
          targetLang: event.targetLang,
          sourceLangModelLoaded: sourceLangModelLoaded,
          targetLangModelLoaded: targetLangModelLoaded));
    } on Exception catch (error) {
      emit(state.copyWith(
          status: Status.error, errorMessage: '언어 설정 중 오류가 발생했습니다'));
      customUtil.logger.e(error);
    }
  }

  Future<void> _onCheckModelDownloaded(
      CheckModelDownloadedEvent event, Emitter<ImageToTextState> emit) async {
    try {
      assert(state.step == ImageToTextStep.download);
      emit(state.copyWith(status: Status.loading));
      if (state.sourceLangModelLoaded && state.targetLangModelLoaded) {
        emit(state.copyWith(
            step: ImageToTextStep.selectImage, status: Status.success));
      }
    } on Exception catch (error) {
      emit(state.copyWith(
          status: Status.error, errorMessage: '언어 모델 다운로드 체크 중 오류가 발생했습니다'));
      customUtil.logger.e(error);
    }
  }

  Future<void> _onDownloadModel(
      DownloadModelEvent event, Emitter<ImageToTextState> emit) async {
    try {
      assert(state.step == ImageToTextStep.download);
      emit(state.copyWith(status: Status.loading));
      if (state.sourceLangModelLoaded) {
        await _modelManager.downloadModel(state.targetLang.lang.bcpCode);
      }
      if (state.targetLangModelLoaded) {
        await _modelManager.downloadModel(state.targetLang.lang.bcpCode);
      }
      emit(state.copyWith(
        step: ImageToTextStep.selectImage,
        status: Status.success,
        sourceLangModelLoaded: true,
        targetLangModelLoaded: true,
      ));
    } on Exception catch (error) {
      emit(state.copyWith(
          status: Status.error, errorMessage: '언어 모델 다운로드 중 오류가 발생했습니다'));
      customUtil.logger.e(error);
    }
  }

  Future<void> _onSelectImage(
      SelectImageEvent event, Emitter<ImageToTextState> emit) async {
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
      final blocks =
          recognizedText.blocks.map((item) => Block.from(item)).toList();
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
      emit(state.copyWith(
          status: Status.error, errorMessage: '이미지 선택 중 오류가 발생했습니다'));
      customUtil.logger.e(error);
    }
  }

  Future<void> _onUnSelect(
      UnSelectImageEvent event, Emitter<ImageToTextState> emit) async {
    try {
      emit(state
          .copyWith(
            step: ImageToTextStep.selectImage,
            status: Status.success,
            selectedImage: null,
            blocks: [],
            originalText: '',
            translatedText: '',
          )
          .copyWithSelectedIndex(null));
    } on Exception catch (error) {
      emit(state.copyWith(
          status: Status.error, errorMessage: '이미지 선택 취소 중 오류가 발생했습니다'));
      customUtil.logger.e(error);
    }
  }

  Future<void> _onChangeSelectedBox(
      ChangeSelectedBoxEvent event, Emitter<ImageToTextState> emit) async {
    try {
      emit(state.copyWithSelectedIndex(event.index));
    } on Exception catch (error) {
      emit(state.copyWith(
          status: Status.error, errorMessage: '이미지 변경 중 발생했습니다'));
      customUtil.logger.e(error);
    }
  }

  Future<void> _onTranslate(
      TranslateEvent event, Emitter<ImageToTextState> emit) async {
    try {
      emit(state.copyWith(status: Status.loading));
      final translatedText =
          await _onDeviceTranslator!.translateText(state.originalText);
      final blocks = await Future.wait(state.blocks.map((item) async =>
          item.copyWith(
              translatedText: await _onDeviceTranslator!
                  .translateText(item.originalText))));
      emit(state.copyWith(
          step: ImageToTextStep.translate,
          translatedText: translatedText,
          blocks: blocks,
          status: Status.success));
    } on Exception catch (error) {
      customUtil.logger.e(error);
      emit(state.copyWith(
          status: Status.error, errorMessage: '번역 중 오류가 발생했습니다'));
    }
  }
}
