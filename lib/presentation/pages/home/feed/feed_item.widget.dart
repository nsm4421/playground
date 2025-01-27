part of '../../export.pages.dart';

class FeedItemWidget extends StatelessWidget {
  const FeedItemWidget(this._feed, {super.key});

  final FeedEntity _feed;

  @override
  Widget build(BuildContext context) {
    final isMine = _feed.author.id == context.read<AuthBloc>().state.user!.id;
    return Container(
      decoration: BoxDecoration(
          color: context.colorScheme.primaryContainer.withOpacity(0.3),
          borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            child: Row(
              children: [
                CustomCircleAvatarWidget(_feed.author.profileImage),
                (12.width),
                Text(_feed.author.nickname),
                const Spacer(),
                // 더보기 버튼
                if (isMine)
                  FeedMoreButtonWidget(_feed)
              ],
            ),
          ),
          if (_feed.images.isNotEmpty)
            CarouselWidget(
              _feed.images,
              showIndicator:
                  _feed.images.length > 1, // 이미지가 여러개인 경우만 indicator 보여기주기
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            child: Text(_feed.content),
          ),
          Row(
            children: [
              LikeIconWidget(_feed),
              CommentIconWidget(_feed),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.share),
              ),
            ],
          )
        ],
      ),
    );
  }
}
