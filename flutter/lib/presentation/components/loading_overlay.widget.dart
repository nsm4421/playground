part of 'export.components.dart';

class LoadingOverLayWidget extends StatelessWidget {
  const LoadingOverLayWidget(
      {super.key,
      required this.isLoading,
      this.loadingWidget,
      required this.child,
      this.opacity = 0.5});

  final bool isLoading;
  final Widget? loadingWidget;
  final Widget child;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Opacity(
              opacity: opacity,
              child:
                  const ModalBarrier(dismissible: false, color: Colors.black)),
        if (isLoading && loadingWidget != null)
          Center(
            child: loadingWidget,
          ),
      ],
    );
  }
}
