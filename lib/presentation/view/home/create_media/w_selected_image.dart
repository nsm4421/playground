part of 'index.dart';

class SelectedImageWidget extends StatelessWidget {
  const SelectedImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateFeedBloc, CreateFeedState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () async {
            await showModalBottomSheet<String?>(
                context: context,
                builder: (context) {
                  return EditCaptionFragment(state.currentImage!);
                }).then((res) {
              if (res == null) return;
              // TODO : 캡션 업데이트
            });
          },
          child: Stack(
            children: [
              SizedBox(
                width: context.width,
                height: context.width,
                child: AssetEntityImage(state.currentImage!, fit: BoxFit.cover),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      margin: EdgeInsets.only(right: 12, bottom: 12),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: CustomPalette.darkGrey),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.add,
                          size: 30,
                          color: CustomPalette.white,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(6),
                      margin: EdgeInsets.only(right: 12, bottom: 12),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: CustomPalette.darkGrey),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.edit,
                          size: 30,
                          color: CustomPalette.white,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
