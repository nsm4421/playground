part of 'visualization_summary.screen.dart';

class EditInsurancePropertiesWidget extends StatefulWidget {
  const EditInsurancePropertiesWidget({super.key});

  @override
  State<EditInsurancePropertiesWidget> createState() =>
      _EditInsurancePropertiesWidgetState();
}

class _EditInsurancePropertiesWidgetState
    extends State<EditInsurancePropertiesWidget> {
  late List<String> _insuranceProperties;
  late TextEditingController _controller;
  late GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    debugPrint('[API]보험의 특징 목록 불러오기');
    _insuranceProperties = dummyInitialInsuranceProperties;
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  _handleAddProperties() {
    _formKey.currentState?.save();
    final ok = _formKey.currentState?.validate();
    if (ok == null || !ok) {
      return;
    }
    final item = _controller.text.trim();
    debugPrint('[API]보험의 특징 저장');
    Navigator.pop(context, {'INSERT':item});
  }

  _handleDeleteProperties(String item) => () async {
    debugPrint('[API]보험의 특징 삭제');
    Navigator.pop(context, {'DELETE':item});
  };

  String? _validateProperties(String? text) {
    if (text == null || text.isEmpty) {
      return '보험의 특징를 입력해주세요';
    } else if (_insuranceProperties.contains(text)) {
      return '중복된 보험의 특징입니다';
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
                Text("보험의 특징 추가하기"),
                Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: _controller,
                    validator: _validateProperties,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: _handleAddProperties,
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
            itemCount: _insuranceProperties.length,
            itemBuilder: (ctx, index) {
              final text = _insuranceProperties[index];
              return ListTile(
                title: Text(text),
                trailing: IconButton(
                  onPressed: _handleDeleteProperties(text),
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
