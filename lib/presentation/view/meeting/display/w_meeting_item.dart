part of 'page.dart';

class MeetingItemWidget extends StatelessWidget {
  const MeetingItemWidget(this._entity, {super.key});

  final MeetingEntity _entity;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
              // 썸네일
              leading: _entity.thumbnail == null
                  ? const SizedBox()  // 국가별 대표 이미지
                  : RoundedAvatarWidget(_entity.thumbnail!, fit: BoxFit.cover),
              // 제목
              // TODO : 국기 보여주기
              title: Text(_entity.title ?? '',
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold)),
              // 본문
              subtitle: Text(_entity.content ?? '',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.tertiary)),
              // 날짜
              trailing: Text(
                  '${_entity.startDate!.month}.${_entity.startDate!.day}~${_entity.endDate!.month}.${_entity.endDate!.day}',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(fontWeight: FontWeight.w500))),
          // 해시태그
          if (_entity.hashtags.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 12, left: 15),
              child: HashtagsWidget(_entity.hashtags),
            ),
          // 디바이더
          const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Divider(indent: 15, endIndent: 15))
        ]);
  }
}
