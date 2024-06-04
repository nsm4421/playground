part of 'short.page.dart';

class ShortScreen extends StatefulWidget {
  const ShortScreen({super.key});

  @override
  State<ShortScreen> createState() => _ShortScreenState();
}

class _ShortScreenState extends State<ShortScreen> {
  late Stream<List<ShortEntity>> _stream;
  List<ShortEntity> _shorts = [];

  @override
  void initState() {
    super.initState();
    _stream = context.read<ShortBloc>().shortStream;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<ShortBloc, ShortState>(
          listenWhen: (previous, current) {
            return (current is InitialShortState) ||
                (current is ShortSuccessState);
          },
          listener: (_, state) {
            if (state is InitialShortState) {
              context.read<ShortBloc>().add(FetchShortEvent());
            } else if (state is ShortSuccessState) {
              _shorts.addAll(state.shorts);
            }
          },
          child: StreamBuilderWidget<List<ShortEntity>>(
              initData: _shorts,
              stream: _stream,
              onSuccessWidgetBuilder: (List<ShortEntity> data) {
                return ShortListFragment([...data, ..._shorts]);
              })),
    );
  }
}
