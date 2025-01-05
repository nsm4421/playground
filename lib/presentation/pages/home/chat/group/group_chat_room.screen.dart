part of '../../../export.pages.dart';

class ChatRoomScreen extends StatefulWidget {
  const ChatRoomScreen({super.key, required this.chatId});

  final String chatId;

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> with DebounceMixIn {
  late GlobalKey<ScaffoldState> _scaffoldKey;
  late TextEditingController _textEditingController;
  late ScrollController _scrollController;
  late StreamSubscription<MessageEntity> _subscription;

  bool _showJumpButton = false;

  List<MessageEntity> _messages = [];

  @override
  void initState() {
    super.initState();
    _scaffoldKey = GlobalKey<ScaffoldState>();
    _textEditingController = TextEditingController();
    _scrollController = ScrollController()
      ..addListener(_handleScrollController);
    _subscription = context.read<GroupChatBloc>().messageStream.listen((data) {
      setState(() {
        _messages.add(data);
      });
    });
  }

  @override
  dispose() {
    super.dispose();
    _textEditingController.dispose();
    _scrollController
      ..removeListener(_handleScrollController)
      ..dispose();
    _subscription.cancel();
    cancelTimer();
  }

  _handleOpenEndDrawer() {
    _scaffoldKey.currentState?.openEndDrawer();
  }

  _handleSendMessage() {
    final text = _textEditingController.text.trim();
    if (text.isNotEmpty) {
      context.read<GroupChatBloc>().add(SendMessageEvent(text));
      _textEditingController.clear();
    }
  }

  _handleScrollController() {
    final currentPosition = _scrollController.position.pixels;
    final top = _scrollController.position.maxScrollExtent;
    final bottom = _scrollController.position.minScrollExtent;
    if (currentPosition == top) {
      // TODO : Fetch More message
    }
    debounce(() {
      setState(() {
        _showJumpButton = currentPosition != bottom;
      });
      Timer(2.sec, () {
        setState(() {
          _showJumpButton = false;
        });
      });
    });
  }

  _handleJumpToBottom() {
    _scrollController.animateTo(_scrollController.position.minScrollExtent,
        curve: Curves.easeInSine, duration: 500.ms);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Oppoent Username"),
        actions: [
          DrawerButton(
            onPressed: _handleOpenEndDrawer,
          )
        ],
      ),
      endDrawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DrawerHeader(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Conversation",
                    style: context.textTheme.titleLarge
                        ?.copyWith(fontWeight: FontWeight.w800),
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  CircleAvatar(), // TODO : 프사
                  const Spacer(
                    flex: 1,
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 500,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        radius: 20,
                      ),
                      title: Text("Username $index"),
                    );
                  }),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.star_outline),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.exit_to_app),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.notification_important_outlined),
                ),
              ],
            ),
          ],
        ),
      ),
      body: ListView.builder(
        controller: _scrollController,
        shrinkWrap: true,
        itemCount: _messages.length,
        reverse: true,
        itemBuilder: (context, index) {
          final item = _messages[index];
          return Text(item.message);
        },
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: context.viewInsets.bottom),
        child: TextField(
          controller: _textEditingController,
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              suffixIcon: IconButton(
                onPressed: _handleSendMessage,
                icon: Icon(
                  Icons.send,
                  color: context.colorScheme.primary,
                ),
              )),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _showJumpButton
          ? FloatingActionButton(
              backgroundColor: Colors.transparent,
              onPressed: _handleJumpToBottom,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Icon(
                Icons.arrow_downward_sharp,
                color: context.colorScheme.tertiary,
              ),
            )
          : null,
    );
  }
}
