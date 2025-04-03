import 'package:flutter/material.dart';
import 'package:sol_v2/visualization_summary/presentation/insurance_contract_abstarction/insurance_contract_abstraction.screen.dart';

import '../domain/entity/product_info.entity.dart';
import 'essential_customer_notice/essential_customer_notice.screen.dart';

class VisualizationSummaryScreen extends StatelessWidget {
  const VisualizationSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("시각화요약서")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Spacer(flex: 1),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) =>
                                  InsuranceContractAbstraction(dummyProduct),
                        ),
                      );
                    },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Icon(Icons.numbers_sharp), Text("보험계약의 개요")],
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EssentialCustomerNoticeScreen(dummyProduct),
                        ),
                      );
                    },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.numbers_sharp),
                          Text("소비자가 반드시 알아두어야 할 유의사항"),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Spacer(flex: 2),
        ],
      ),
    );
  }
}
