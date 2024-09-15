part of 'create_reels.page.dart';

class EditCaptionFragment extends StatefulWidget {
  const EditCaptionFragment(this._tec, {super.key});

  final TextEditingController _tec;

  @override
  State<EditCaptionFragment> createState() => _EditCaptionFragmentState();
}

class _EditCaptionFragmentState extends State<EditCaptionFragment> {
  static const int _maxLength = 1000;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 캡션
          Padding(
              padding: EdgeInsets.only(
                  top: CustomSpacing.xl,
                  right: CustomSpacing.tiny,
                  left: CustomSpacing.tiny,
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: TextField(
                  minLines: 3,
                  maxLines: 10,
                  maxLength: _maxLength,
                  controller: widget._tec,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary),
                  decoration: InputDecoration(
                      counterStyle: Theme.of(context)
                          .textTheme
                          .labelLarge
                          ?.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary),
                      label: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: CustomSpacing.tiny),
                          child: Icon(Icons.abc,
                              size: CustomTextSize.xl,
                              color: Theme.of(context).colorScheme.onPrimary)),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: CustomSpacing.sm,
                          vertical: CustomSpacing.lg),
                      border: const OutlineInputBorder())))
        ]);
  }
}
