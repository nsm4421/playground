import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/core/constant/enums/status.enum.dart';
import 'package:my_app/presentation/pages/chat/bloc/chat_room/chat_room.bloc.dart';
import 'package:my_app/presentation/pages/chat/bloc/chat_room/chat_room.event.dart';
import 'package:my_app/presentation/pages/chat/bloc/chat_room/chat_room.state.dart';

import '../../../core/constant/asset_path.dart';
import '../../../dependency_injection.dart';

class CreateChatRoomScreen extends StatelessWidget {
  const CreateChatRoomScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => getIt<ChatRoomBloc>(),
        child: BlocBuilder<ChatRoomBloc, ChatRoomState>(
          builder: (_, state) {
            switch (state.status) {
              case Status.loading:
                return const Center(child: CircularProgressIndicator());
              case Status.initial:
              case Status.success:
              case Status.error:
                return const _CreateChatRoomView();
            }
          },
        ),
      );
}

class _CreateChatRoomView extends StatefulWidget {
  const _CreateChatRoomView({super.key});

  @override
  State<_CreateChatRoomView> createState() => _CreateChatRoomViewState();
}

class _CreateChatRoomViewState extends State<_CreateChatRoomView> {
  static const double _horizontalPadding = 15;
  static const int _maxHashtagNum = 3;

  late TextEditingController _chatRoomNameTEC;
  late List<TextEditingController> _hashtagTECList;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _chatRoomNameTEC = TextEditingController();
    _hashtagTECList = [];
  }

  @override
  void dispose() {
    super.dispose();
    _chatRoomNameTEC.dispose();
    _hashtagTECList.map((e) => e.dispose());
  }

  _handleCloseDialog() => context.pop();

  _handleAddHashtagTextField() => setState(() {
        if (_hashtagTECList.length >= _maxHashtagNum) return;
        _hashtagTECList.add(TextEditingController());
      });

  _handleDeleteHashtagTextField(int idx) => () => setState(() {
        _hashtagTECList.removeAt(idx);
      });

  _handleSubmit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    context.read<ChatRoomBloc>()
      ..add(ChatRoomCreateEvent(
          chatRoomName: _chatRoomNameTEC.text.trim(),
          hashtags: _hashtagTECList
              .map((e) => e.text.trim().replaceAll("#", ""))
              .toList()))
      ..add(ChatRoomInitializedEvent());
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('채팅방이 만들어졌습니다'),
      duration: Duration(seconds: 2),
    ));
    context.pop();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
              horizontal: _horizontalPadding, vertical: 50),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("채팅방 만들기",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold)),
                IconButton(
                    onPressed: _handleCloseDialog,
                    icon: Icon(Icons.cancel_outlined,
                        color: Theme.of(context).colorScheme.primary))
              ],
            ),
            const SizedBox(height: 50),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ChatRoomNameTextField(_chatRoomNameTEC),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("해시태그",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.w700)),
                      IconButton(
                          onPressed: _handleAddHashtagTextField,
                          icon: SvgPicture.asset(AssetPath.add))
                    ],
                  ),
                  const SizedBox(height: 20),
                  ...List.generate(
                      _hashtagTECList.length,
                      (index) => _HashtagsTextField(
                          tec: _hashtagTECList[index],
                          callback: _handleDeleteHashtagTextField(index)))
                ],
              ),
            )
          ]),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _handleSubmit,
          child: SvgPicture.asset(
            AssetPath.chevronRight,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      );
}

class _ChatRoomNameTextField extends StatelessWidget {
  const _ChatRoomNameTextField(this.tec, {super.key});

  final TextEditingController tec;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("채팅방 제목",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 20),
          TextFormField(
            controller: tec,
            keyboardType: TextInputType.text,
            maxLength: 20,
            validator: (v) {
              if (v == null || v.isEmpty) {
                return "방제목을 입력해주세요";
              }
              if (v.length < 5) {
                return "방 제목은 최소 5글자로 작명해주세요";
              }
              return null;
            },
            decoration: const InputDecoration(border: OutlineInputBorder()),
          ),
        ],
      );
}

class _HashtagsTextField extends StatelessWidget {
  const _HashtagsTextField(
      {super.key, required this.tec, required this.callback});

  final TextEditingController tec;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          TextFormField(
            controller: tec,
            keyboardType: TextInputType.text,
            maxLength: 20,
            validator: (v) {
              if (v == null || v.isEmpty) {
                return "해시태그를 입력해주세요";
              }
              if (v.length < 2) {
                return "최소 2글자를 입력해주세요";
              }
              return null;
            },
            decoration: InputDecoration(
                border: const OutlineInputBorder(),
                prefixIcon: Icon(
                  Icons.tag,
                  color: Theme.of(context).colorScheme.primary,
                ),
                suffixIcon: IconButton(
                    onPressed: callback,
                    icon: Icon(Icons.delete_forever,
                        color: Theme.of(context).colorScheme.primary))),
          ),
          const SizedBox(height: 10),
        ],
      );
}
