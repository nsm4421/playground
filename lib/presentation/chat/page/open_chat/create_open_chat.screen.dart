import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hot_place/core/di/dependency_injection.dart';
import 'package:hot_place/core/util/toast.util.dart';
import 'package:hot_place/domain/usecase/chat/open_chat/create_open_chat.usecase.dart';
import 'package:hot_place/presentation/auth/bloc/auth.bloc.dart';
import 'package:hot_place/presentation/feed/widget/hashtag_list.widget.dart';
import 'package:hot_place/presentation/setting/bloc/user.bloc.dart';

class CreateOpenChatScreen extends StatefulWidget {
  const CreateOpenChatScreen({super.key});

  @override
  State<CreateOpenChatScreen> createState() => _CreateOpenChatScreenState();
}

class _CreateOpenChatScreenState extends State<CreateOpenChatScreen> {
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

  _handleDeleteHashtag(String hashtag) => () {
        setState(() {
          _hashtags.remove(hashtag);
        });
      };

  _handleCreateOpenChat() async {
    final title = _titleTextEditingController.text.trim();
    final currentUser = context.read<UserBloc>().state.user;
    final res = await getIt<CreateOpenChatUseCase>()
        .call(title: title, hashtags: _hashtags, currentUser: currentUser);
    res.fold((l) {
      ToastUtil.toast(l.message ?? 'error');
    }, (r) {
      ToastUtil.toast('success');
      if (context.mounted) {
        context.pop();
      }
    });
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
