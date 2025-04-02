part of 'visualization_summary.screen.dart';

class EditInsuranceCategoryWidget extends StatefulWidget {
  const EditInsuranceCategoryWidget({super.key});

  @override
  State<EditInsuranceCategoryWidget> createState() =>
      _EditInsuranceCategoryWidgetState();
}

class _EditInsuranceCategoryWidgetState
    extends State<EditInsuranceCategoryWidget> {
  late List<String> _insuranceCategories;
  late TextEditingController _controller;
  late GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    debugPrint('[API]카테고리 목록 불러오기');
    _insuranceCategories = ['상해보험', '질병보험', '상해 및 질병보험'];
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  _handleAddCategory() {
    _formKey.currentState?.save();
    final ok = _formKey.currentState?.validate();
    if (ok == null || !ok) {
      return;
    }
    final item = _controller.text.trim();
    debugPrint('[API]카테고리 저장');
    Navigator.pop(context, item);
  }

  _handleDeleteCategory(String category) => () async {
    debugPrint('[API]카테고리 삭제');
    Navigator.pop(context, category);
  };

  String? _validateCategory(String? text) {
    if (text == null || text.isEmpty) {
      return '카테고리를 입력해주세요';
    } else if (_insuranceCategories.contains(text)) {
      return '중복된 카테고리입니다';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("보헝종목 추가하기"),
                Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: _controller,
                    validator: _validateCategory,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: _handleAddCategory,
                        icon: Icon(Icons.add),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: _insuranceCategories.length,
            itemBuilder: (ctx, index) {
              final text = _insuranceCategories[index];
              return ListTile(
                title: Text(text),
                trailing: IconButton(
                  onPressed: _handleDeleteCategory(text),
                  icon: Icon(Icons.delete_outline),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
