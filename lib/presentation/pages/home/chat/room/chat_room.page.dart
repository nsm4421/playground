part of '../../../export.pages.dart';

class ChatRoomPage extends StatefulWidget {
  const ChatRoomPage({super.key, required this.chatId});

  final String chatId;

  @override
  State<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> with DebounceMixIn {
  late GlobalKey<ScaffoldState> _scaffoldKey;
  late TextEditingController _textController;
  late ScrollController _scrollController;

  bool _showJumpButton = false;

  @override
  void initState() {
    super.initState();
    _scaffoldKey = GlobalKey<ScaffoldState>();
    _textController = TextEditingController();
    _scrollController = ScrollController()
      ..addListener(_handleScrollController);
  }

  @override
  dispose() {
    super.dispose();
    _textController.dispose();
    _scrollController
      ..removeListener(_handleScrollController)
      ..dispose();
    cancelTimer();
  }

  _handleOpenEndDrawer() {
    _scaffoldKey.currentState?.openEndDrawer();
  }

  _handleSendMessage() {}

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
                  Spacer(
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
        itemCount: 1000,
        reverse: true,
        itemBuilder: (context, index) {
          return Align(
            alignment: Alignment.centerRight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: context.colorScheme.primaryContainer),
                  child: Text(
                    "Sender",
                    style: context.textTheme.bodyLarge?.copyWith(
                        color: context.colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, bottom: 8),
                  child: Text(
                    'message created at',
                    style: context.textTheme.labelLarge
                        ?.copyWith(color: Colors.blueGrey),
                  ),
                )
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: context.viewInsets.bottom),
        child: TextField(
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
