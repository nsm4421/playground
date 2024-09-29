part of 'index.page.dart';

class SelectedImageFragment extends StatelessWidget {
  const SelectedImageFragment(this.imageSize, {super.key});

  final double imageSize;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImageToTextCubit, ImageToTextState>(
        builder: (context, state) {
      if (!state.status.ok) {
        /// 로딩중이거나 오류인 경우
        return const Center(child: CircularProgressIndicator());
      } else if (state.selectedImage == null) {
        /// 아직 이미지를 선택하지 않은 경우
        return InkWell(
            onTap: context.read<ImageToTextCubit>().handleSelectImage,
            child: Center(
                child: Icon(Icons.add_a_photo_outlined, size: imageSize / 3)));
      } else {
        /// 이미 이미지를 선택한 경우
        final adjustedBoxes = context
            .read<ImageToTextCubit>()
            .getAdjustedBox(screenWidth: imageSize, screenHeight: imageSize);
        return Stack(
          children: [
            Container(
                width: imageSize,
                height: imageSize,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: FileImage(state.selectedImage!.image)))),
            ...List.generate(adjustedBoxes.length, (index) {
              final block = adjustedBoxes[index];
              return Positioned(
                left: block.left,
                top: block.top,
                child: CustomPaint(
                  size: Size(block.width, block.height), // Rectangle size
                  painter: OutlineHighlight(
                      isSelected: state.selectedIndex == index),
                ),
              );
            })
          ],
        );
      }
    });
  }
}
