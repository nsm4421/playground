part of 'index.page.dart';

class ExtractedTextFragment extends StatelessWidget {
  const ExtractedTextFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImageToTextCubit, ImageToTextState>(
        builder: (context, state) {
      return ListView.builder(
          shrinkWrap: true,
          itemCount: state.blocks.length,
          itemBuilder: (_, index) {
            final item = state.blocks[index];
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2), // Shadow color
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3), // Shadow position
                  ),
                ],
              ),
              child: ListTile(
                onTap: () {
                  context
                      .read<ImageToTextCubit>()
                      .handleSetSelectedImageIndex(index);
                },
                title: Text(
                  item.text,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
                // TODO : subtitle로 해석된 언어 보여주기
              ),
            );
          });
    });
  }
}
