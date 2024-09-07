part of 'snackbar.dart';

class SnackbarItemWidget extends StatefulWidget {
  const SnackbarItemWidget(this._message, {super.key});

  final SnackbarMessage _message;

  @override
  State<SnackbarItemWidget> createState() => _SnackbarItemWidgetState();
}

class _SnackbarItemWidgetState extends State<SnackbarItemWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget._message.onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: CustomSpacing.lg, vertical: CustomSpacing.sm),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: widget._message.bgColor,
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  widget._message.iconData,
                  color: widget._message.textColor,
                ),
                CustomWidth.sm,
                Text(widget._message.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: widget._message.textColor),
                    overflow: TextOverflow.ellipsis),
              ],
            ),
            if (widget._message.description != null)
              Padding(
                padding: EdgeInsets.only(top: CustomSpacing.sm / 2),
                child: Text(widget._message.description!,
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge
                        ?.copyWith(color: widget._message.textColor),
                    overflow: TextOverflow.ellipsis),
              ),
          ],
        ),
      ),
    );
  }
}
