part of '../index.page.dart';

class EditorHeaderFragment extends StatelessWidget {
  const EditorHeaderFragment({super.key});

  static const double _selectRadius = 28;
  static const double _unSelectRadius = 35;

  static const int _maxPageNum = 8;  // 최대 페이지 개수

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditDiaryBloc, EditDiaryState>(
        builder: (context, state) {
      return SizedBox(
          height: 100,
          child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                // 이미지 목록
                ...List.generate(state.totalPage, (index) {
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
                            backgroundColor: Theme.of(context)
                                .colorScheme
                                .secondaryContainer,
                            backgroundImage: state.pages[index].image == null
                                ? null
                                : FileImage(state.pages[index].image!),
                            child: state.pages[index].image == null
                                ? Text('${index + 1}p')
                                : null),
                      ),
                    ),
                  );
                }),

                /// 페이지 추가 버튼
                if (state.totalPage < _maxPageNum)
                  GestureDetector(
                      onTap: () {
                        context.read<EditDiaryBloc>().add(AddPageEvent());
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: CircleAvatar(
                            radius: _unSelectRadius,
                            backgroundColor:
                                Theme.of(context).colorScheme.tertiaryContainer,
                            child: Icon(Icons.plus_one,
                                color: Theme.of(context).colorScheme.tertiary)),
                      ))
              ])));
    });
  }
}
