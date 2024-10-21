part of 'page.dart';

class FabWidget extends StatelessWidget {
  const FabWidget(this._entity, {super.key});

  final MeetingEntity _entity;
  static const double _iconSize = 35;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// 동행자 목록 페이지로 이동
          RoundIconButtonWidget(
              iconData: Icons.search,
              iconSize: _iconSize,
              tooltip: 'Search',
              voidCallback: () async {
                await showModalBottomSheet(
                    showDragHandle: true,
                    isScrollControlled: true,
                    context: context,
                    builder: (context) {
                      return SizedBox();
                      // return MeetingAccompanyPage(_entity);
                    });
              }),

          if (context.read<AuthenticationBloc>().state.currentUser!.uid ==
              _entity.createdBy)

            /// 내가 작성한 경우, 수정 페이지로
            RoundIconButtonWidget(
                iconData: Icons.edit,
                iconSize: _iconSize,
                tooltip: 'Edit',
                voidCallback: () async {
                  // TODO : 수정 페이지로 라우팅
                })
        ],
      ),
    );
  }
}
