import 'package:flutter/material.dart';
import 'package:flutter_sns/model/activity_dto.dart';
import 'package:flutter_sns/screen/home/w_avatar.dart';
import 'package:flutter_sns/util/common_size.dart';

class ActiveScreen extends StatelessWidget {
  const ActiveScreen({super.key});

  static const String _MOCK_IMAGE_URL =
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR2OT6twSQM_jZlMBv6ix78oy5_HdmBaRS4S2dzAJhChBM5c-EbkhFGRYvnYT8uxPOWYZY&usqp=CAU';

  static List<ActivityDto> _MOCK_ACTIVITY_VO = [
    ActivityDto(
        message: "테스트 메세지1 입니다",
        imagePath: _MOCK_IMAGE_URL,
        createdAt: DateTime.now().subtract(Duration(hours: 5))),
    ActivityDto(message: "테스트 메세지2 입니다", imagePath: _MOCK_IMAGE_URL),
    ActivityDto(message: "테스트 메세지3 입니다", imagePath: _MOCK_IMAGE_URL),
    ActivityDto(message: "테스트 메세지4 입니다", imagePath: _MOCK_IMAGE_URL),
    ActivityDto(message: "테스트 메세지5 입니다", imagePath: _MOCK_IMAGE_URL),
    ActivityDto(message: "테스트 메세지6 입니다", imagePath: _MOCK_IMAGE_URL),
    ActivityDto(message: "테스트 메세지7 입니다", imagePath: _MOCK_IMAGE_URL),
  ];

  Widget _activityItem(ActivityDto activity) {
    return Padding(
      padding: EdgeInsets.all(CommonSize.paddingMd),
      child: Row(
        children: [
          MainStoryAvatarWidget(
              imagePath: _MOCK_IMAGE_URL, size: CommonSize.avatar2xl),
          SizedBox(
            width: CommonSize.marginSm,
          ),
          Expanded(
              child: Text.rich(
            TextSpan(text: activity.message),
            style: TextStyle(fontSize: CommonSize.fontsizeMd),
          )),
          if (activity.createdAt != null)
            Text(
              activity.createdAt!.toLocal().toString(),
              style: TextStyle(
                  fontSize: CommonSize.fontsizeSm, color: Colors.grey),
            )
        ],
      ),
    );
  }

  Widget _activityView(
      {required String title, required List<ActivityDto> activities}) {
    return Padding(
      padding: EdgeInsets.all(CommonSize.paddingMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: CommonSize.fontsizeLg),
          ),
          SizedBox(
            height: CommonSize.marginSm,
          ),
          ...activities.map((e) => _activityItem(e))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text("활동"),
        titleTextStyle: TextStyle(
            fontSize: CommonSize.fontsizeXl,
            fontWeight: FontWeight.bold,
            color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: CommonSize.marginLg,
            ),
            _activityView(title: "오늘", activities: _MOCK_ACTIVITY_VO),
            SizedBox(
              height: CommonSize.marginLg,
            ),
            _activityView(title: "이번주", activities: _MOCK_ACTIVITY_VO),
            SizedBox(
              height: CommonSize.marginLg,
            ),
            _activityView(title: "지난달", activities: _MOCK_ACTIVITY_VO)
          ],
        ),
      ),
    );
  }
}
