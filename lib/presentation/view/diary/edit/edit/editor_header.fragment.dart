part of '../edit_diary.page.dart';

class EditorHeaderFragment extends StatelessWidget {
  const EditorHeaderFragment({super.key});

  static const double _selectRadius = 40;
  static const double _unSelectRadius = 35;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditDiaryBloc, EditDiaryState>(
        builder: (context, state) {
      return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(state.pages.length, (index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: GestureDetector(
                    onTap: () {
                      // 선택 시 다른 페이지로 이동
                      context.read<EditDiaryBloc>().add(MovePageEvent(index));
                    },
                    child: CircleAvatar(
                      radius: index == state.currentIndex
                          ? _selectRadius + 10
                          : _unSelectRadius,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      child: CircleAvatar(
                          radius: index == state.currentIndex
                              ? _selectRadius
                              : _unSelectRadius,
                          backgroundColor:
                              Theme.of(context).colorScheme.secondaryContainer,
                          backgroundImage: state.pages[index].image == null
                              ? null
                              : FileImage(state.pages[index].image!),
                          child: state.pages[index].image == null
                              ? Text('${index + 1}th')
                              : null),
                    ),
                  ),
                );
              })));
    });
  }
}
