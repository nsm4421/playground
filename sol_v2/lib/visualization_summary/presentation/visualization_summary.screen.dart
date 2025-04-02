import 'package:flutter/material.dart';

import '../domain/entity/insurace_properties.entity.dart';
import '../domain/entity/product_info.entity.dart';

part 'insurance_category.fragment.dart';

part 'edit_insurance_category.widget.dart';

part 'insurance_properties.fragment.dart';

part 'edit_insurance_properties.widget.dart';

class VisualizationSummaryScreen extends StatelessWidget {
  const VisualizationSummaryScreen(this._product, {super.key});

  final ProductInfo _product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("시각화요약서 요건정의"), centerTitle: true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: InsuranceCategoryFragment(_product),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: InsurancePropertiesFragment(),
            ),
          ],
        ),
      ),
    );
  }
}
