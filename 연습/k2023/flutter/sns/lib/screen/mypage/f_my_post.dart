import 'package:flutter/material.dart';
import 'package:flutter_sns/util/common_size.dart';
import 'package:flutter_sns/util/get_image_path.dart';
import 'package:flutter_sns/widget/w_image_icon.dart';

class MyPostFragment extends StatefulWidget {
  const MyPostFragment({super.key});

  @override
  State<MyPostFragment> createState() => _MyPostFragmentState();
}

class _MyPostFragmentState extends State<MyPostFragment>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  TabBar _tabBar() {
    return TabBar(
      indicatorColor: Colors.black54,
      controller: tabController,
      tabs: [
        Padding(
          padding: EdgeInsets.all(CommonSize.paddingMd),
          child: ImageIconWidget(imagePath: ImagePath.gridViewOn),
        ),
        Padding(
            padding: EdgeInsets.all(CommonSize.paddingMd),
            child: ImageIconWidget(imagePath: ImagePath.myTagImageOff)),
      ],
    );
  }

  // TODO
  Widget _tabView() {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: CommonSize.padding2xl, horizontal: CommonSize.paddingSm),
      child: GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 100,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1,
              mainAxisSpacing: 1,
              crossAxisSpacing: 1),
          itemBuilder: (BuildContext buildContext, int index) {
            return Container(color: Colors.grey);
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [_tabBar(), _tabView()]);
  }
}
