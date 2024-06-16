part of 'create_open_chat.page.dart';

class CreateOpenChatScreen extends StatefulWidget {
  const CreateOpenChatScreen({super.key});

  @override
  State<CreateOpenChatScreen> createState() => _CreateOpenChatScreenState();
}

class _CreateOpenChatScreenState extends State<CreateOpenChatScreen> {
  late TextEditingController _titleTec;
  late GlobalKey<FormState> _formKey;

  static const _maxLength = 30;

  @override
  void initState() {
    super.initState();
    _titleTec = TextEditingController();
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    super.dispose();
    _titleTec.dispose();
  }

  _handleChangeTitle(String? text) {
    context.read<CreateOpenChatCubit>().setTitle(text ?? '');
  }

  String? _handleValidateTitle(String? text) {
    if (text == null || text.trim().isEmpty) {
      return "제목을 입력해주세요";
    }
    return null;
  }

  _handleClearTitle() {
    _titleTec.clear();
  }

  _handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      context.read<CreateOpenChatCubit>().upload();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("오픈 채팅방 만들기")),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
                child: TextFormField(
                  onChanged: _handleChangeTitle,
                  controller: _titleTec,
                  validator: _handleValidateTitle,
                  maxLength: _maxLength,
                  maxLines: 1,
                  decoration: InputDecoration(
                      labelText: "방제",
                      helperText: "채팅방 제목을 30자 이내로 지어주세요",
                      suffixIcon: IconButton(
                          onPressed: _handleClearTitle,
                          icon: const Icon(Icons.clear))),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      decorationThickness: 0),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Text("제출하기",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.w800))),
        onPressed: _handleSubmit,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
