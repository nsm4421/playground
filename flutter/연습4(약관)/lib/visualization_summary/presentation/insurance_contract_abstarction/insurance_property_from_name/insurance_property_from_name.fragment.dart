part of '../insurance_contract_abstraction.screen.dart';

class InsurancePropertyFromNameFragment extends StatefulWidget {
  const InsurancePropertyFromNameFragment(this._product, {super.key});

  final ProductInfo _product;

  @override
  State<InsurancePropertyFromNameFragment> createState() =>
      _InsurancePropertyFromNameFragmentState();
}

class _InsurancePropertyFromNameFragmentState
    extends State<InsurancePropertyFromNameFragment> {
  late List<InsurancePropertyFromName> _insurancePropertiesFromName;
  late List<InsurancePropertyFromName> _selectedInsurancePropertiesFromName;

  @override
  void initState() {
    super.initState();
    _insurancePropertiesFromName = initialInsurancePropertiesFromName;
    _selectedInsurancePropertiesFromName =
        initialInsurancePropertiesFromName
            .where((item) => widget._product.productName.contains(item.keyword))
            .toList();
  }

  _handleShowEditView() async {
    final info =
        await showModalBottomSheet<Map<String, InsurancePropertyFromName>>(
          showDragHandle: true,
          isScrollControlled: true,
          context: context,
          builder: (_) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: EditInsurancePropertyWidget(_insurancePropertiesFromName),
            );
          },
        );
    if (info == null) {
      return;
    } else if (info['INSERT'] != null) {
      final inserted = info['INSERT'] as InsurancePropertyFromName;
      setState(() {
        _insurancePropertiesFromName.add(inserted);
      });
    } else if (info['DELETE'] != null) {
      final deleted = info['DELETE'] as InsurancePropertyFromName;
      setState(() {
        _insurancePropertiesFromName.remove(deleted);
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
            Text(
              "상품명으로 이해한 상품특징",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Spacer(),
            IconButton(onPressed: _handleShowEditView, icon: Icon(Icons.edit)),
          ],
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: _insurancePropertiesFromName.length,
          itemBuilder: (context, index) {
            final property = _insurancePropertiesFromName[index];
            final isSelected = _selectedInsurancePropertiesFromName.contains(
              property,
            );
            return ListTile(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    _selectedInsurancePropertiesFromName.remove(property);
                  } else {
                    _selectedInsurancePropertiesFromName.add(property);
                  }
                });
              },
              leading:
                  isSelected
                      ? Icon(Icons.check)
                      : Icon(Icons.check_box_outline_blank),
              title: Text(property.keyword),
              subtitle: Text(property.description, overflow: TextOverflow.clip),
            );
          },
        ),
      ],
    );
  }
}
