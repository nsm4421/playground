part of 'index.dart';

class DisplayAssetWidget extends StatelessWidget {
  const DisplayAssetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateFeedBloc, CreateFeedState>(
      builder: (context, state) {
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3),
          itemCount: state.assets.length,
          itemBuilder: (context, index) {
            final asset = state.assets[index];
            return GestureDetector(
                onTap: () {
                  context.read<CreateFeedBloc>().add(OnTapImageEvent(asset));
                },
                child: AnimatedOpacity(
                    opacity: state.currentImage == asset ? 0.4 : 1,
                    duration: 200.ms,
                    child: AssetEntityImage(asset, fit: BoxFit.cover)));
          },
        );
      },
    );
  }
}
