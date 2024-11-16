part of 'index.dart';

class ReelsScreen extends StatefulWidget {
  const ReelsScreen({super.key});

  @override
  State<ReelsScreen> createState() => _ReelsScreenState();
}

class _ReelsScreenState extends State<ReelsScreen> {
  Timer? _timer;

  void _debounce(VoidCallback callback) {
    if (_timer?.isActive ?? false) _timer?.cancel();
    _timer = Timer(300.ms, callback);
  }

  _handleChangePage(int index) {
    _debounce(() {
      if (!context.read<DisplayReelsBloc>().state.isEnd &&
          context.read<DisplayReelsBloc>().state.status != Status.loading &&
          index >= context.read<DisplayReelsBloc>().state.data.length - 1) {
        log('fetch reels');
        context.read<DisplayReelsBloc>().add(FetchEvent());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DisplayReelsBloc, CustomDisplayState<ReelsEntity>>(
        builder: (context, state) {
          return PageView.builder(
            onPageChanged: _handleChangePage,
            scrollDirection: Axis.vertical,
            itemCount: state.data.length,
            itemBuilder: (context, index) {
              return ReelsItemWidget(state.data[index]);
            },
          );
        },
      ),
    );
  }
}
