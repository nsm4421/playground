part of '../insurance_contract_abstraction.screen.dart';

class EditInsurancePropertyWidget extends StatefulWidget {
  const EditInsurancePropertyWidget(
    this._insurancePropertiesFromName, {
    super.key,
  });

  final List<InsurancePropertyFromName> _insurancePropertiesFromName;

  @override
  State<EditInsurancePropertyWidget> createState() =>
      _EditInsurancePropertyWidgetState();
}

class _EditInsurancePropertyWidgetState
    extends State<EditInsurancePropertyWidget> {
  late List<InsurancePropertyFromName> _insurancePropertiesFromName;
  late TextEditingController _keywordController;
  late TextEditingController _descriptionController;
  late GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    _keywordController = TextEditingController();
    _descriptionController = TextEditingController();
    debugPrint('[API]상품명으로 이해한 상품특징 불러오기');
    _insurancePropertiesFromName = widget._insurancePropertiesFromName;
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    super.dispose();
    _keywordController.dispose();
    _descriptionController.dispose();
  }

  _handleAddProperties() {
    _formKey.currentState?.save();
    final ok = _formKey.currentState?.validate();
    if (ok == null || !ok) {
      return;
    }
    final keyword = _keywordController.text.trim();
    final description = _keywordController.text.trim();
    debugPrint('[API]상품명으로 이해한 상품특징 저장');
    Navigator.pop(context, {
      'INSERT': InsurancePropertyFromName(
        keyword: keyword,
        description: description,
      ),
    });
  }

  _handleDeleteProperties(InsurancePropertyFromName property) => () async {
    debugPrint('[API]상품명으로 이해한 상품특징 삭제');
    Navigator.pop(context, {'DELETE': property});
  };

  String? _validateKeyword(String? text) {
    if (text == null || text.isEmpty) {
      return '키워드를 입력해주세요';
    } else if (_insurancePropertiesFromName
        .map((item) => item.keyword)
        .contains(text)) {
      return '중복된 키워드입니다';
    }
    return null;
  }

  String? _validateDescription(String? text) {
    if (text == null || text.isEmpty) {
      return '설명을 입력해주세요';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text("상품명으로 이해한 상품특징 추가하기"),
                      Spacer(),
                      IconButton(
                        onPressed: _handleAddProperties,
                        icon: Icon(Icons.add),
                      ),
                    ],
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _keywordController,
                          validator: _validateKeyword,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "키워드를 적어주세요",
                          ),
                        ),
                        SizedBox(height: 12),
                        TextFormField(
                          controller: _descriptionController,
                          validator: _validateDescription,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "설명을 적어주세요",
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: _insurancePropertiesFromName.length,
              itemBuilder: (ctx, index) {
                final property = _insurancePropertiesFromName[index];
                return ListTile(
                  title: Text(property.keyword),
                  subtitle: Text(
                    property.description,
                    overflow: TextOverflow.clip,
                  ),
                  trailing: IconButton(
                    onPressed: _handleDeleteProperties(property),
                    icon: Icon(Icons.delete_outline),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
