import 'package:flutter/material.dart';

import '../../../../../common/widget/product_card_widget.dart';
import '../../../../../common/widget/size_widget.dart';
import '../../../../../common/widget/view_module_title_widget.dart';
import '../../../../../domain/model/view_module_model.dart';

class ViewModuleCategory extends StatefulWidget {
  const ViewModuleCategory(this.viewModuleModel, {super.key});

  final ViewModuleModel viewModuleModel;

  @override
  State<ViewModuleCategory> createState() => _ViewModuleCategoryState();
}

class _ViewModuleCategoryState extends State<ViewModuleCategory>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: widget.viewModuleModel.tabs.length, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: ViewModuleTitleWidget(
              title: widget.viewModuleModel.title,
            ),
          ),
          Height(12),
          TabBar(
            tabs: widget.viewModuleModel.tabs.map((e) => Tab(text: e)).toList(),
            controller: _tabController,
            isScrollable: true,
          ),
          Height(12),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4),
            child: AspectRatio(
              aspectRatio: 343 / 452,
              child: TabBarView(
                children: List.generate(
                  widget.viewModuleModel.tabs.length,
                  (index) => GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 8,
                      childAspectRatio: 107 / 220,
                    ),
                    itemBuilder: (_, idx) => SmallProductCardComponent(
                      context: context,
                      productInfoModel: widget.viewModuleModel.products[index],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
}
