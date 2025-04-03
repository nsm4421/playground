import 'package:flutter/material.dart';

import '../../domain/entity/product_info.entity.dart';
import 'benefit/benefit.screen.dart';
import 'coverage/coverage_info.screen.dart';

class EssentialCustomerNoticeScreen extends StatelessWidget {
  const EssentialCustomerNoticeScreen(this._product, {super.key});

  final ProductInfo _product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              "소비자가 반드시 알아 두어야 할 유의사항",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 8),
            Text(
              _product.productName,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Spacer(flex: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BenefitScreen()),
                  );
                },
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Icon(Icons.numbers_sharp), Text("감액면책 정보")],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CoverageInfoScreen()),
                  );
                },
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Icon(Icons.numbers_sharp), Text("담보정보")],
                  ),
                ),
              ),
            ),
          ),
          Spacer(flex: 2),
        ],
      ),
    );
  }
}
