import 'package:flutter/material.dart';

import '../../../domain/entity/coverage.entity.dart';

class CoverageInfoScreen extends StatefulWidget {
  const CoverageInfoScreen({super.key});

  @override
  State<CoverageInfoScreen> createState() => _CoverageInfoScreenState();
}

class _CoverageInfoScreenState extends State<CoverageInfoScreen> {
  late List<Coverage> _coverages;

  @override
  void initState() {
    super.initState();
    _coverages = initialCoverages;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("담보정보 수정하기"),),
      body: Center(
        child: DataTable(
          clipBehavior: Clip.antiAlias,
          columns: [
            DataColumn(label: Text('담보구분')),
            DataColumn(label: Text('담보명')),
            DataColumn(label: Text('보장한도')),
            DataColumn(label: Text('자기부담금')),
            DataColumn(label: Text('실손보상여부')),
          ],
          rows:
              _coverages
                  .map(
                    (coverage) => DataRow(
                      cells: [
                        DataCell(Text(coverage.category)),
                        DataCell(Text(coverage.coverageName)),
                        DataCell(Text(coverage.policyLimit)),
                        DataCell(Text(coverage.deductible)),
                        DataCell(Text(coverage.indemnity ? "Y" : "N")),
                      ],
                    ),
                  )
                  .toList(),
        ),
      ),
    );
  }
}
