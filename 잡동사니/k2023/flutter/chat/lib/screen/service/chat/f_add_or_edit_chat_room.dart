import 'package:chat_app/controller/chat_controller.dart';
import 'package:chat_app/repository/chat_repository.dart';
import 'package:chat_app/screen/widget/w_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

/// 채팅방을 만들거나, 수정하는 UI
class AddOrEditChatRoomFragment extends ConsumerStatefulWidget {
  const AddOrEditChatRoomFragment(this.chatRoomId, {super.key});

  final String? chatRoomId;

  @override
  ConsumerState<AddOrEditChatRoomFragment> createState() =>
      _AddChatRoomFragmentState();
}

class _AddChatRoomFragmentState
    extends ConsumerState<AddOrEditChatRoomFragment> {
  late TextEditingController _chatRoomNameTEC;
  late List<TextEditingController> _hashtagTECList;
  final _formKey = GlobalKey<FormState>();
  final int _maxHashtagNum = 3;
  final int _maxHashtagLength = 8;

  @override
  void initState() {
    super.initState();
    _chatRoomNameTEC = TextEditingController();
    _hashtagTECList = [];
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _init();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _chatRoomNameTEC.dispose();
    _hashtagTECList.map((tec) => tec.dispose());
  }

  _init() async {
    if (widget.chatRoomId == null) return;
    final fetched = await ref
        .read(chatRepositoryProvider)
        .getChatRoomById(widget.chatRoomId!);
    _chatRoomNameTEC.text = fetched?.chatRoomName ?? "";
    fetched?.hashtags.forEach((hashtag) {
      final tec = TextEditingController();
      tec.text = hashtag ?? "";
      _hashtagTECList.add(tec);
    });
  }

  _handleSubmit() async {
    (widget.chatRoomId == null)
        // create mode
        ? await ref.read(chatControllerProvider).createChatRoom(
              context: context,
              formKey: _formKey,
              chatRoomNameTEC: _chatRoomNameTEC,
              hashtagTECList: _hashtagTECList,
            )
        // edit mode
        : await ref.read(chatControllerProvider).editChatRoom(
              chatRoomId: widget.chatRoomId!,
              context: context,
              formKey: _formKey,
              chatRoomNameTEC: _chatRoomNameTEC,
              hashtagTECList: _hashtagTECList,
            );
  }

  _handleAddHashtag() {
    if (_hashtagTECList.length < _maxHashtagNum) {
      setState(() {
        _hashtagTECList.add(TextEditingController());
      });
    }
  }

  _handleDeleteHashtag(int index) {
    setState(() {
      _hashtagTECList.removeAt(index);
    });
  }

  _handleClose() => context.pop();

  _addChatRoomButton(BuildContext context) => IconButton(
      onPressed: _handleSubmit,
      icon: const Icon(
        Icons.create_outlined,
        size: 30,
        color: Colors.blue,
      ));

  _header() => Row(
        children: [
          const Width(15),
          Text(
            "Add Chat Room",
            style: GoogleFonts.lobster(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const ExpandedSizedBox(),
          _addChatRoomButton(context),
          IconButton(
            onPressed: _handleClose,
            icon: const Icon(Icons.cancel_outlined),
          ),
          const Width(15),
        ],
      );

  Widget _chatRoomNameTxtField() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.home_outlined,
                size: 25,
              ),
              Width(10),
              Text(
                "Chat Room Name",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ],
          ),
          const Height(10),
          TextFormField(
              controller: _chatRoomNameTEC,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                hintText: "Let's talk",
                border: OutlineInputBorder(),
              ),
              validator: (v) =>
                  (v == null || v.isEmpty) ? "Press Chat Room Name" : null),
        ],
      );

  Widget _hashTagTextField(int index) => Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.tag,
                size: 25,
              ),
              const Width(10),
              const Text(
                "Hashtag",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const ExpandedSizedBox(),
              if (_hashtagTECList.length < _maxHashtagNum)
                IconButton(
                  onPressed: _handleAddHashtag,
                  icon: const Icon(
                    Icons.add_circle_outline_sharp,
                    size: 25,
                  ),
                )
            ],
          ),
          const Height(15),
          ...List.generate(
            _hashtagTECList.length,
            (index) => _hashtagTextFieldItem(index),
          )
        ],
      );

  Widget _hashtagTextFieldItem(int index) => Column(
        children: [
          const Height(5),
          TextFormField(
            controller: _hashtagTECList[index],
            keyboardType: TextInputType.text,
            maxLength: 8,
            validator: (v) {
              if (v == null || v.isEmpty) {
                return "press hashtag";
              }
              if (v.length > _maxHashtagLength) {
                return "max length of hashtag is $_maxHashtagLength";
              }
              if (v.contains("#")) {
                return "remove # in hashtag";
              }
              return null;
            },
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: () {
                  _handleDeleteHashtag(index);
                },
                icon: const Icon(Icons.delete),
              ),
              border: const OutlineInputBorder(),
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        width: double.infinity,
        child: Column(
          children: [
            const Height(10),
            _header(),
            const Height(30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    _chatRoomNameTxtField(),
                    const Height(30),
                    _hashTagTextField(0),
                    const Height(30),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
