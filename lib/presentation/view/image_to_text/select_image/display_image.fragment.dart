part of '../image_to_text.page.dart';

class DisplayImageFragment extends StatelessWidget {
  const DisplayImageFragment(this.imageSize, {super.key});

  final double imageSize;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImageToTextBloc, ImageToTextState>(
        builder: (context, state) {
      if (!state.status.ok) {
        /// 로딩중이거나 오류인 경우
        return const Center(child: CircularProgressIndicator());
      } else if (state.selectedImage == null) {
        /// 아직 이미지를 선택하지 않은 경우
        return InkWell(
            onTap: () {
              context.read<ImageToTextBloc>().add(SelectImageEvent());
            },
            child: Center(
                child: Icon(Icons.add_a_photo_outlined, size: imageSize / 3)));
      } else {
        /// 이미 이미지를 선택한 경우
        return SelectedImageWidget(
            imageWidth: imageSize,
            imageHeight: imageSize,
            selectedImage: state.selectedImage!,
            selectedIndex: state.selectedIndex!,
            blocks: state.blocks);
      }
    });
  }
}
