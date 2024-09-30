part of 'image_to_text.bloc.dart';

// 이미지 -> 텍스트 상태
class ImageToTextState {
  final ImageToTextStep step;
  final Status status;
  final Lang sourceLang;
  final Lang targetLang;
  final bool sourceLangModelLoaded;
  final bool targetLangModelLoaded;
  final SelectedImage? selectedImage;
  late final List<Block> blocks;
  final String originalText; // 이미지에서 추출한 텍스트 원문
  final String translatedText; // 번역도니 텍스트 원문
  final String errorMessage; // 오류 메세지
  final int? selectedIndex; // 현재 선택한 박스의 index

  ImageToTextState(
      {this.step = ImageToTextStep.setting,
      this.status = Status.initial,
      this.sourceLang = Lang.en,
      this.targetLang = Lang.kr,
      this.sourceLangModelLoaded = false,
      this.targetLangModelLoaded = false,
      this.selectedImage,
      List<Block>? blocks,
      this.originalText = '',
      this.translatedText = '',
      this.errorMessage = '',
      this.selectedIndex}) {
    this.blocks = blocks ?? [];
  }

  ImageToTextState _copyWith(
      {ImageToTextStep? step,
      Status? status,
      Lang? sourceLang,
      Lang? targetLang,
      bool? sourceLangModelLoaded,
      bool? targetLangModelLoaded,
      SelectedImage? selectedImage,
      List<Block>? blocks,
      String? originalText,
      String? translatedText,
      String? errorMessage,
      int? selectedIndex}) {
    return ImageToTextState(
        step: step ?? this.step,
        status: status ?? this.status,
        sourceLang: sourceLang ?? this.sourceLang,
        targetLang: targetLang ?? this.targetLang,
        sourceLangModelLoaded:
            sourceLangModelLoaded ?? this.sourceLangModelLoaded,
        targetLangModelLoaded:
            targetLangModelLoaded ?? this.targetLangModelLoaded,
        selectedImage: selectedImage ?? this.selectedImage,
        blocks: blocks ?? this.blocks,
        originalText: originalText ?? this.originalText,
        translatedText: translatedText ?? this.translatedText,
        errorMessage: errorMessage ?? this.errorMessage,
        selectedIndex: selectedIndex ?? this.selectedIndex);
  }

  ImageToTextState copyWith(
      {ImageToTextStep? step,
      Status? status,
      Lang? sourceLang,
      Lang? targetLang,
      bool? sourceLangModelLoaded,
      bool? targetLangModelLoaded,
      SelectedImage? selectedImage,
      List<Block>? blocks,
      String? originalText,
      String? translatedText,
      String? errorMessage}) {
    return _copyWith(
        step: step,
        status: status,
        sourceLang: sourceLang,
        targetLang: targetLang,
        sourceLangModelLoaded: sourceLangModelLoaded,
        targetLangModelLoaded: targetLangModelLoaded,
        selectedImage: selectedImage,
        blocks: blocks,
        originalText: originalText,
        translatedText: translatedText,
        errorMessage: errorMessage);
  }

  ImageToTextState copyWithSelectedIndex(int? selectedIndex) {
    return _copyWith(selectedIndex: selectedIndex);
  }
}

enum ImageToTextStep { setting, download, selectImage, translate }

enum Lang {
  kr(TranslateLanguage.korean),
  jp(TranslateLanguage.japanese),
  cn(TranslateLanguage.chinese),
  en(TranslateLanguage.english);

  final TranslateLanguage lang;

  const Lang(this.lang);
}

class SelectedImage {
  final File image;
  final double width;
  final double height;

  SelectedImage(
      {required this.image, required this.width, required this.height});
}

class Block {
  final double left;
  final double top;
  final double width;
  final double height;
  final String originalText;
  final String translatedText;

  Block({
    required this.left,
    required this.top,
    required this.width,
    required this.height,
    required this.originalText,
    this.translatedText = '',
  });

  static Block from(TextBlock textBlock) {
    return Block(
        left: textBlock.boundingBox.left,
        top: textBlock.boundingBox.top,
        width: textBlock.boundingBox.width,
        height: textBlock.boundingBox.height,
        originalText: textBlock.text);
  }

  Block copyWith(
      {double? left,
      double? top,
      double? width,
      double? height,
      String? originalText,
      String? translatedText}) {
    return Block(
      left: left ?? this.left,
      top: top ?? this.top,
      width: width ?? this.width,
      height: height ?? this.height,
      originalText: originalText ?? this.originalText,
      translatedText: translatedText ?? this.translatedText,
    );
  }
}
