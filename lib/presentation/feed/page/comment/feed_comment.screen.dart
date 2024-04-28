import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hot_place/core/di/dependency_injection.dart';
import 'package:hot_place/core/util/toast.util.dart';
import 'package:hot_place/data/entity/feed/base/feed.entity.dart';
import 'package:hot_place/data/entity/feed/comment/feed_comment.entity.dart';
import 'package:hot_place/presentation/feed/bloc/comment/feed_comment.bloc.dart';
import 'package:hot_place/presentation/setting/bloc/user.bloc.dart';

import 'feed_comment_item.widget.dart';

class FeedCommentScreen extends StatelessWidget {
  const FeedCommentScreen(this._feed, {super.key});

  final FeedEntity _feed;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) =>
            getIt<FeedCommentBloc>()..add(InitFeedCommentStateEvent(_feed.id!)),
        child:
            BlocBuilder<FeedCommentBloc, FeedCommentState>(builder: (_, state) {
          // 로딩중
          if (state is InitialFeedCommentState ||
              state is FeedCommentLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          // 오류
          else if (State is FeedCommentFailureState) {
            return Center(
                child: Text("ERROR",
                    style: Theme.of(context).textTheme.displayMedium));
          }
          // 정상
          return const _View();
        }));
  }
}

class _View extends StatefulWidget {
  const _View();

  @override
  State<_View> createState() => _ViewState();
}

class _ViewState extends State<_View> {
  static const _maxLength = 300;

  late TextEditingController _textEditingController;
  late Stream<List<FeedCommentEntity>> _stream;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _stream = context.read<FeedCommentBloc>().commentStream;
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
  }

  _handleSendComment() async {
    final content = _textEditingController.text.trim();
    if (content.isEmpty) {
      ToastUtil.toast('본문을 입력해주세요');
      return;
    }
    context.read<FeedCommentBloc>().add(CreateFeedCommentEvent(
        currentUser: context.read<UserBloc>().state.user,
        content: _textEditingController.text.trim()));
  }

  _handleClear() {
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).padding.top + 20),
        Row(children: [
          IconButton(onPressed: _handleClear, icon: const Icon(Icons.clear))
        ]),
        Expanded(
          child: StreamBuilder<List<FeedCommentEntity>>(
              stream: _stream,
              builder: (_, snapshot) {
                // 정상
                if (snapshot.hasData &&
                    !snapshot.hasError &&
                    snapshot.connectionState == ConnectionState.active) {
                  final data = snapshot.data ?? [];
                  return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (_, index) =>
                          FeedCommentItemWidget(data[index]));
                }
                // 오류
                else if (snapshot.hasError) {
                  return const Center(child: Text("ERROR"));
                }
                // 로딩중
                else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
        ),
        TextField(
            controller: _textEditingController,
            maxLength: _maxLength,
            decoration: InputDecoration(
                counterText: '',
                hintText: '최대 $_maxLength자',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                    onPressed: _handleSendComment,
                    icon: const Icon(Icons.send)))),
        SizedBox(height: MediaQuery.of(context).viewInsets.bottom)
      ],
    );
  }
}
