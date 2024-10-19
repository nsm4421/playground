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
              onTap: () {
                // 상세 페이지로 이동
                context.push(Routes.meetingDetail.path, extra: _entity);
              },
              // TODO : 수정,삭제,신고하기 메뉴 모달 창 띄우기
              onLongPress: () {},
              // 썸네일
              leading: _entity.thumbnail == null
                  ? const SizedBox() // 국가별 대표 이미지
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
              trailing: _entity.dateRangeRepr != null
                  ? Text(_entity.dateRangeRepr!,
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge
                          ?.copyWith(fontWeight: FontWeight.w500))
                  : null),
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
