import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../domain/entity/insurace_property_from_name.entity.dart';
import '../../domain/entity/main_insurace_property.entity.dart';
import '../../domain/entity/product_info.entity.dart';

part 'insurance_category/insurance_category.fragment.dart';

part 'insurance_category/edit_insurance_category.widget.dart';

part 'main_insurance_property/main_insurance_properties.fragment.dart';

part 'main_insurance_property/edit_main_insurance_properties.widget.dart';

part 'insurance_property_from_name/insurance_property_from_name.fragment.dart';

part 'insurance_property_from_name/edit_insurance_property_from_name.widget.dart';

class InsuranceContractAbstraction extends StatelessWidget {
  const InsuranceContractAbstraction(this._product, {super.key});

  final ProductInfo _product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text("보험계약의 개요", style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: 8),
            Text(
              _product.productName,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: InsuranceCategoryFragment(_product),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: MainInsurancePropertiesFragment(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: InsurancePropertyFromNameFragment(_product),
            ),
          ],
        ),
      ),
    );
  }
}
