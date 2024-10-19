part of 'page.dart';

class HeaderFragment extends StatelessWidget {
  const HeaderFragment(this._entity, {super.key});

  final MeetingEntity _entity;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery
            .of(context)
            .size
            .height / 4,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fitWidth,
                image: CachedNetworkImageProvider(
                    _entity.thumbnail!))));
  }
}
