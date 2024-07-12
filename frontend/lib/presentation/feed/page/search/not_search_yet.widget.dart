import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hot_place/core/util/toast.util.dart';
import 'package:hot_place/presentation/feed/bloc/base/feed.bloc.dart';

class NotSearchedYetWidget extends StatefulWidget {
  const NotSearchedYetWidget({super.key});

  @override
  State<NotSearchedYetWidget> createState() => _NotSearchedYetWidgetState();
}

class _NotSearchedYetWidgetState extends State<NotSearchedYetWidget> {
  static const int _maxLength = 15;

  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
  }

  _handleClear() {
    _textEditingController.clear();
  }

  _handleSearch() {
    final hashtag = _textEditingController.text.trim();
    if (hashtag.isEmpty) {
      ToastUtil.toast('검색어를 입력해주세요');
      return;
    }
    context
        .read<FeedBloc>()
        .add(SearchFeedsByHashtagEvent(hashtag: hashtag, page: 1, size: 200));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Hashtag 검색"), centerTitle: true),
      body: Column(
        children: [
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 4),
            child: TextField(
              maxLength: _maxLength,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  decorationThickness: 0, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                  helperText: "최대 200개의 최신 피드를 조회할 수 있어요",
                  helperStyle: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(
                          color: Theme.of(context).colorScheme.secondary),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.tertiary)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary)),
                  prefixIcon: const Icon(Icons.tag),
                  suffixIcon: IconButton(
                      icon: const Icon(Icons.clear), onPressed: _handleClear)),
              controller: _textEditingController,
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Theme.of(context).colorScheme.primaryContainer)),
            onPressed: _handleSearch,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.search),
                  const SizedBox(width: 10),
                  Text("Search",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          )),
    );
  }
}
