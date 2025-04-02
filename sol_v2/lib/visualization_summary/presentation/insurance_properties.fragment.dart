part of 'visualization_summary.screen.dart';

class InsurancePropertiesFragment extends StatefulWidget {
  const InsurancePropertiesFragment({super.key});

  @override
  State<InsurancePropertiesFragment> createState() =>
      _InsurancePropertiesFragmentState();
}

class _InsurancePropertiesFragmentState
    extends State<InsurancePropertiesFragment> {
  late List<String> _properties;
  late List<String> _selectedProperties;

  @override
  void initState() {
    super.initState();
    _properties = dummyInitialInsuranceProperties;
    _selectedProperties = [];
  }

  _handleShowEditView() async {
    final info = await showModalBottomSheet<Map<String, String>>(
      showDragHandle: true,
      isScrollControlled: true,
      context: context,
      builder: (_) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          child: EditInsurancePropertiesWidget(),
        );
      },
    );
    if (info == null) {
      return;
    } else if (info['INSERT'] != null) {
      final inserted = info['INSERT'] as String;
      setState(() {
        _properties.add(inserted);
      });
    } else if (info['DELETE'] != null) {
      final deleted = info['DELETE'] as String;
      setState(() {
        _properties.remove(deleted);
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
            Text("보험의 특징", style: Theme.of(context).textTheme.titleLarge),
            Spacer(),
            IconButton(onPressed: _handleShowEditView, icon: Icon(Icons.edit)),
          ],
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: _properties.length,
          itemBuilder: (context, index) {
            final text = _properties[index];
            final isSelected = _selectedProperties.contains(text);
            return ListTile(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    _selectedProperties.remove(text);
                  } else {
                    _selectedProperties.add(text);
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
