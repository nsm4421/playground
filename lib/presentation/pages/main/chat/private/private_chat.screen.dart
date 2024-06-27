part of 'private_chat.page.dart';

class PrivateChatScreen extends StatefulWidget {
  const PrivateChatScreen(this._opponent, {super.key});

  final AccountEntity _opponent;

  @override
  State<PrivateChatScreen> createState() => _PrivateChatScreenState();
}

class _PrivateChatScreenState extends State<PrivateChatScreen> {
  late TextEditingController _tec;

  @override
  void initState() {
    super.initState();
    _tec = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _tec.dispose();
  }

  _handlePop() {
    if (context.mounted) {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._opponent.nickname!,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold)),
        leading: AvatarWidget(widget._opponent.profileUrl!),
        actions: [
          IconButton(onPressed: _handlePop, icon: const Icon(Icons.clear))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [PrivateChatTextField(widget._opponent)],
        ),
      ),
    );
  }
}
