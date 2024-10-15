part of 'page.dart';

class SelectThumbnailFragment extends StatefulWidget {
  const SelectThumbnailFragment({super.key});

  @override
  State<SelectThumbnailFragment> createState() =>
      _SelectThumbnailFragmentState();
}

class _SelectThumbnailFragmentState extends State<SelectThumbnailFragment> {
  File? _thumbnail;

  _handleSelectThumbnail() async {
    await customUtil.pickImageAndReturnCompressedImage().then((res) {
      if (res == null) return;
      setState(() {
        _thumbnail = res;
      });
      context.read<CreateMeetingCubit>().setThumbnail(res);
    });
  }

  _handleUnSelectThumbnail() {
    setState(() {
      _thumbnail = null;
    });
    context.read<CreateMeetingCubit>().setThumbnail(null);
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        const Icon(Icons.add_photo_alternate_outlined),
        const SizedBox(width: 12),
        Text('Thumbnail',
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.bold)),
        const Spacer()
      ]),
      const SizedBox(height: 24),
      _thumbnail == null
          ? ElevatedButton(
              onPressed: _handleSelectThumbnail, child: const Text('Select'))
          : Stack(children: [
              CircularAvatarAssetWidget(size: 120, _thumbnail!),
              Positioned(
                  top: -10,
                  right: -10,
                  child: IconButton(
                      onPressed: _handleUnSelectThumbnail,
                      icon: const Icon(Icons.clear, size: 25)))
            ])
    ]);
  }
}
