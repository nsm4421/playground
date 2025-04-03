part of '../insurance_contract_abstraction.screen.dart';

class MainInsurancePropertiesFragment extends StatefulWidget {
  const MainInsurancePropertiesFragment({super.key});

  @override
  State<MainInsurancePropertiesFragment> createState() =>
      _MainInsurancePropertiesFragmentState();
}

class _MainInsurancePropertiesFragmentState
    extends State<MainInsurancePropertiesFragment> {
  late List<String> _mainInsuranceProperties;
  late List<String> _selectedMainInsuranceProperties;

  @override
  void initState() {
    super.initState();
    _mainInsuranceProperties = initialMainInsuranceProperties;
    _selectedMainInsuranceProperties = [];
  }

  _handleShowEditView() async {
    final info = await showModalBottomSheet<Map<String, String>>(
      showDragHandle: true,
      isScrollControlled: true,
      context: context,
      builder: (_) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          child: EditMainInsurancePropertiesWidget(),
        );
      },
    );
    if (info == null) {
      return;
    } else if (info['INSERT'] != null) {
      final inserted = info['INSERT'] as String;
      setState(() {
        _mainInsuranceProperties.add(inserted);
      });
    } else if (info['DELETE'] != null) {
      final deleted = info['DELETE'] as String;
      setState(() {
        _mainInsuranceProperties.remove(deleted);
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
            Text("상품의 주요 특징", style: Theme.of(context).textTheme.titleLarge),
            Spacer(),
            IconButton(onPressed: _handleShowEditView, icon: Icon(Icons.edit)),
          ],
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: _mainInsuranceProperties.length,
          itemBuilder: (context, index) {
            final text = _mainInsuranceProperties[index];
            final isSelected = _selectedMainInsuranceProperties.contains(text);
            return ListTile(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    _selectedMainInsuranceProperties.remove(text);
                  } else {
                    _selectedMainInsuranceProperties.add(text);
                  }
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
