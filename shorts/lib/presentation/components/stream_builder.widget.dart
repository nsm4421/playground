import 'package:flutter/material.dart';

class StreamBuilderWidget<T> extends StatelessWidget {
  const StreamBuilderWidget({
    super.key,
    required Stream<T> stream,
    required Widget Function(T data) onSuccessWidgetBuilder,
    Widget? onLoadingWidget,
    Widget? onErrorWidget,
    T? initData,
  })  : _stream = stream,
        _initData = initData,
        _onSuccessWidgetBuilder = onSuccessWidgetBuilder,
        _onLoadingWidget = onLoadingWidget,
        _onErrorWidget = onErrorWidget;

  final Stream<T> _stream;
  final T? _initData;
  final Widget Function(T data) _onSuccessWidgetBuilder;
  final Widget? _onLoadingWidget;
  final Widget? _onErrorWidget;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
        initialData: _initData,
        stream: _stream,
        builder: (_, snapshot) {
          if (snapshot.hasError) {
            // on error
            return _onErrorWidget ?? const Center(child: Text("ERROR"));
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            // on loading
            return _onLoadingWidget ??
                const Center(child: CircularProgressIndicator());
          }
          // on success
          return _onSuccessWidgetBuilder(snapshot.data as T);
        });
  }
}
