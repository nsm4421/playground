part of 'short.screen.dart';

class ShortViewFragment extends StatefulWidget {
  const ShortViewFragment({super.key});

  @override
  State<ShortViewFragment> createState() => _ShortViewFragmentState();
}

class _ShortViewFragmentState extends State<ShortViewFragment> {
  late Stream<List<ShortEntity>> _stream;
  List<ShortEntity> _shorts = [];

  @override
  void initState() {
    super.initState();
    _stream = context.read<ShortBloc>().shortStream;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ShortBloc, ShortState>(
        listenWhen: (previous, current) {
          return (current is InitialShortState) ||
              (current is ShortSuccessState);
        },
        listener: (_, state) {
          log('listen');
          if (state is InitialShortState) {
            log('fetch shorts');
            context.read<ShortBloc>().add(FetchShortEvent());
          } else if (state is ShortSuccessState) {
            _shorts.addAll(state.shorts);
          }
        },
        child: StreamBuilderWidget<List<ShortEntity>>(
            initData: _shorts,
            stream: _stream,
            onSuccessWidgetBuilder: (List<ShortEntity> data) {
              return ShortListWidget([...data, ..._shorts]);
            }));
  }
}
