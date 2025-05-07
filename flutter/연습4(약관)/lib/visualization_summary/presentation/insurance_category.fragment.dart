part of 'visualization_summary.screen.dart';

class InsuranceCategoryFragment extends StatefulWidget {
  const InsuranceCategoryFragment(this._product, {super.key});

  final ProductInfo _product;

  @override
  State<InsuranceCategoryFragment> createState() =>
      _InsuranceCategoryFragmentState();
}

class _InsuranceCategoryFragmentState extends State<InsuranceCategoryFragment> {
  late List<String> _insuranceCategories;
  late String _currentInsuranceCategory;

  @override
  void initState() {
    super.initState();
    debugPrint('[API]카테고리 목록 불러오기');
    _insuranceCategories = ['상해보험', '질병보험', '상해 및 질병보험'];
    _currentInsuranceCategory = widget._product.productCategory;
    assert(_insuranceCategories.contains(_currentInsuranceCategory));
  }

  _handleShowEditView() async {
    final category = await showModalBottomSheet<String>(
      showDragHandle: true,
      isScrollControlled: true,
      context: context,
      builder: (_) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          child: EditInsuranceCategoryWidget(),
        );
      },
    );
    if (category == null) {
      return;
    } else if (_insuranceCategories.contains(category)) {
      setState(() {
        _insuranceCategories.remove(category);
      });
    } else {
      setState(() {
        _insuranceCategories = [..._insuranceCategories, category];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text("보험종목", style: Theme.of(context).textTheme.titleLarge),
            Spacer(),
            IconButton(
              onPressed: _handleShowEditView,
              icon: Icon(Icons.edit),
            ),
          ],
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: _insuranceCategories.length,
          itemBuilder: (context, index) {
            final text = _insuranceCategories[index];
            final isSelected = text == _currentInsuranceCategory;
            return ListTile(
              onTap: () {
                setState(() {
                  _currentInsuranceCategory = text;
                });
              },
              leading:
                  isSelected
                      ? Icon(Icons.check)
                      : Icon(Icons.check_box_outline_blank),
              title: Text(text),
            );
          },
        ),
      ],
    );
  }
}
