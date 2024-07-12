import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hot_place/core/di/dependency_injection.dart';
import 'package:hot_place/core/util/toast.util.dart';
import 'package:hot_place/presentation/auth/widget/loading.widget.dart';
import 'package:hot_place/presentation/chat/bloc/chat_bloc.module.dart';
import 'package:hot_place/presentation/chat/bloc/room/open_chat/open_chat.bloc.dart';
import 'package:hot_place/presentation/feed/widget/hashtag_list.widget.dart';
import 'package:hot_place/presentation/setting/bloc/user.bloc.dart';

import '../../widget/error/open_chat_error.widget.dart';

class CreateOpenChatScreen extends StatelessWidget {
  const CreateOpenChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<ChatBlocModule>().openChatBloc..add(InitOpenChatEvent()),
      child: BlocListener<OpenChatBloc, OpenChatState>(
        listener: (_, state) {
          // 채팅방 생성에 성공하면 뒤로가기
          if (state is OpenChatSuccessState && context.mounted) {
            context.pop();
          }
        },
        child: BlocBuilder<OpenChatBloc, OpenChatState>(
          builder: (_, OpenChatState state) {
            if (state is InitialOpenChatState ||
                state is OpenChatSuccessState) {
              return const _View();
            } else if (state is OpenChatLoadingState) {
              return const LoadingWidget('채팅방을 만드는 중입니다');
            } else if (state is OpenChatFailureState) {
              return OpenChatErrorWidget(state.message);
            }
            return Text('err');
          },
        ),
      ),
    );
  }
}

class _View extends StatefulWidget {
  const _View({super.key});

  @override
  State<_View> createState() => _ViewState();
}

class _ViewState extends State<_View> {
  late TextEditingController _titleTextEditingController;
  late TextEditingController _hashtagTextEditingController;
  List<String> _hashtags = [];

  static const int _titleMaxLength = 30;
  static const int _hashtagMaxLength = 20;
  static const int _hashtagMaxNum = 3;

  @override
  void initState() {
    super.initState();
    _titleTextEditingController = TextEditingController();
    _hashtagTextEditingController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _titleTextEditingController.dispose();
    _hashtagTextEditingController.dispose();
  }

  _handleClearTitle() => _titleTextEditingController.clear();

  _handleAddHashtag() {
    if (_hashtags.length >= _hashtagMaxNum) {
      return;
    }
    final hashtag = _hashtagTextEditingController.text.trim();
    if (_hashtags.contains(hashtag)) {
      ToastUtil.toast('중복된 해시태그 입니다');
      return;
    }
    setState(() {
      _hashtags.add(hashtag);
    });
    _hashtagTextEditingController.clear();
  }

  _handleDeleteHashtag(String hashtag) => setState(() {
        _hashtags.remove(hashtag);
      });

  _handleCreateOpenChat() {
    final title = _titleTextEditingController.text.trim();
    if (title.isEmpty) {
      ToastUtil.toast('제목을 입력해주세요');
      return;
    }
    final currentUser = context.read<UserBloc>().state.user;
    context.read<OpenChatBloc>().add(CreateOpenChatEvent(
        title: title, hashtags: _hashtags, currentUser: currentUser));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("오픈 채팅방 만들기")),
      body: SingleChildScrollView(
          child: Column(children: [
        // 방제
        Padding(
          padding: const EdgeInsets.only(top: 30, right: 10, left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text("Title",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold)),
              TextField(
                maxLength: _titleMaxLength,
                maxLines: 1,
                controller: _titleTextEditingController,
                style:
                    const TextStyle(decorationThickness: 0, letterSpacing: 1.5),
                decoration: InputDecoration(
                    helperText: "채팅방 이름을 입력해주세요",
                    suffixIcon: IconButton(
                      onPressed: _handleClearTitle,
                      icon: const Icon(Icons.clear),
                    )),
              )
            ],
          ),
        ),

        Padding(
            padding: const EdgeInsets.only(top: 50, right: 10, left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Text("Hashtag",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontWeight: FontWeight.bold)),
                    Spacer(),
                    Text("(${_hashtags.length}/$_hashtagMaxNum)",
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(
                                color: Theme.of(context).colorScheme.secondary))
                  ],
                ),
                TextField(
                    controller: _hashtagTextEditingController,
                    maxLines: 1,
                    maxLength: _hashtagMaxLength,
                    decoration: InputDecoration(
                        helperText: "해시태그를 입력해주세요",
                        suffixIcon: _hashtags.length < _hashtagMaxNum
                            ? IconButton(
                                onPressed: _handleAddHashtag,
                                icon: const Icon(Icons.add))
                            : null))
              ],
            )),

        // 해시태그 목록
        HashtagListWidget(_hashtags, handleDelete: _handleDeleteHashtag)
      ])),

      // 제출 버튼
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: _handleCreateOpenChat,
        child: const Icon(Icons.create),
      ),
    );
  }
}
