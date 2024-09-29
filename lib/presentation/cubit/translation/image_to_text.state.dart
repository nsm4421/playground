part of 'image_to_text.cubit.dart';

// 이미지 -> 텍스트 상태
class ImageToTextState {
  final Status status;
  final SelectedImage? selectedImage;
  late final List<Block> blocks;
  final String originalText; // 이미지에서 추출한 텍스트 원문
  final String translatedText; // TODO : 이미지에서 추출한 텍스트을 번역한 언어
  final String errorMessage; // 오류 메세지
  final int? selectedIndex; // 현재 선택한 박스의 index

  ImageToTextState(
      {this.status = Status.initial,
      this.selectedImage,
      List<Block>? blocks,
      this.originalText = '',
      this.translatedText = '',
      this.errorMessage = '',
      this.selectedIndex}) {
    this.blocks = blocks ?? [];
  }

  ImageToTextState _copyWith(
      {Status? status,
      SelectedImage? selectedImage,
      List<Block>? blocks,
      String? originalText,
      String? translatedText,
      String? errorMessage,
      int? selectedIndex}) {
    return ImageToTextState(
        status: status ?? this.status,
        selectedImage: selectedImage ?? this.selectedImage,
        blocks: blocks ?? this.blocks,
        originalText: originalText ?? this.originalText,
        translatedText: translatedText ?? this.translatedText,
        errorMessage: errorMessage ?? this.errorMessage,
        selectedIndex: selectedIndex ?? this.selectedIndex);
  }

  ImageToTextState copyWith(
      {Status? status,
      SelectedImage? selectedImage,
      bool? isLoading,
      List<Block>? blocks,
      String? originalText,
      String? translatedText,
      String? errorMessage}) {
    return _copyWith(
        status: status,
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
  final String text;

  Block(
      {required this.left,
      required this.top,
      required this.width,
      required this.height,
      required this.text});
}
