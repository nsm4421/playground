part of 'index.dart';

class SearchOptionWidget extends StatefulWidget {
  const SearchOptionWidget({super.key});

  @override
  State<SearchOptionWidget> createState() => _SearchOptionWidgetState();
}

class _SearchOptionWidgetState extends State<SearchOptionWidget> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Search'),
          TextField(
            controller: _controller,
          ),
        ],
      ),
    );
  }
}
