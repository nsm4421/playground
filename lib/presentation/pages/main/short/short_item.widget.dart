part of 'short.screen.dart';

class ShortItemWidget extends StatefulWidget {
  const ShortItemWidget(this.entity, {super.key});

  final ShortEntity entity;

  @override
  State<ShortItemWidget> createState() => _ShortItemWidgetState();
}

class _ShortItemWidgetState extends State<ShortItemWidget> {
  static const double _titleHeight = 30;
  static const double _contentHeight = 50;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width * 0.75,
      child: Stack(
        children: [
          // 비디오
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: _titleHeight, bottom: _contentHeight),
              child: VideoPreviewItemWidget(widget.entity),
            ),
          ),

          // 제목
          Positioned(
              top: 0,
              left: 0,
              child: SizedBox(
                height: _titleHeight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(widget.entity.title!,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Theme.of(context).colorScheme.primary)),
                  ],
                ),
              )),

          // 영상 정보
          Positioned(
              bottom: 0,
              child: SizedBox(
                height: _contentHeight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      widget.entity.content!,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
