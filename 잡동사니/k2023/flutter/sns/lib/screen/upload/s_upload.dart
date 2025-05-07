import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_sns/util/common_size.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({Key? key}) : super(key: key);

  static const int _IMAGE_COUNT = 30;

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  var albums = <AssetPathEntity>[];
  var imageList = <AssetEntity>[];
  AssetEntity? selectedImage;
  String? headerTitle;

  @override
  void initState() {
    super.initState();
    _loadPhoto();
  }

  void _loadPhoto() async {
    if ((await PhotoManager.requestPermissionExtend()).isAuth) {
      albums = await PhotoManager.getAssetPathList(
          type: RequestType.image,
          filterOption: FilterOptionGroup(
              imageOption: FilterOption(
                sizeConstraint: SizeConstraint(minHeight: 100, minWidth: 100),
              ),
              orders: [
                OrderOption(type: OrderOptionType.createDate, asc: false)
              ]));
      headerTitle = albums.first.name;
      imageList.addAll(await albums.first
          .getAssetListPaged(page: 0, size: UploadScreen._IMAGE_COUNT));
      selectedImage = imageList.first;
      update();
    }
  }

  void update() => setState(() {});

  // TODO : 카메라에서 가져오기
  void getImageFromCamera() async {}

  // TODO : 이미지 여러개 가져오기
  void getMultiImage() async {}

  AppBar _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      leading: GestureDetector(onTap: Get.back, child: Icon(Icons.close)),
      title: Text(
        "새 게시글",
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: CommonSize.fontsizeLg,
            color: Colors.black),
      ),
      actions: [
        GestureDetector(
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: CommonSize.paddingLg),
              child: Icon(Icons.arrow_forward_rounded),
            ))
      ],
    );
  }

  Widget _preView() {
    return Container(
        width: Get.width,
        height: Get.width,
        color: Colors.grey,
        child: _photoItem(e: selectedImage, size: Get.width.toInt()));
  }

  Widget _menuItem(
      {String? label,
      required VoidCallback callback,
      required IconData iconData}) {
    return InkWell(
      onTap: callback,
      child: Container(
          padding: EdgeInsets.all(CommonSize.paddingSm),
          decoration: BoxDecoration(
              color: Colors.grey, borderRadius: BorderRadius.circular(20)),
          child: Row(
            children: [
              Icon(
                iconData,
                color: Colors.white,
              ),
              if (label != null)
                SizedBox(
                  width: CommonSize.paddingSm,
                ),
              if (label != null)
                Text(
                  label,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )
            ],
          )),
    );
  }

  Widget _menu() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: CommonSize.marginXl),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  constraints: BoxConstraints(maxHeight: Get.height / 2),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )),
                  context: context,
                  builder: (_) => Container(
                        padding:
                            EdgeInsets.symmetric(vertical: CommonSize.marginXl),
                        margin: EdgeInsets.symmetric(
                            horizontal: CommonSize.paddingLg),
                        height: Get.height / 2,
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: List.generate(
                                      albums.length,
                                      (index) => InkWell(
                                            onTap: () {
                                              // TODO : 선택시 선택한 갤러리 변경
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: CommonSize.marginXl,
                                                  horizontal:
                                                      CommonSize.paddingMd),
                                              child: Text(
                                                albums[index].name,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize:
                                                        CommonSize.fontsizeLg),
                                              ),
                                            ),
                                          )),
                                ),
                              ),
                            )
                          ],
                        ),
                      ));
            },
            child: Row(
              children: [
                Text(
                  headerTitle ?? "Gallery",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: CommonSize.fontsizeLg),
                ),
                Icon(Icons.arrow_drop_down_sharp),
              ],
            ),
          ),
          Expanded(child: SizedBox()),
          _menuItem(
              label: "MultiSelect",
              callback: getMultiImage,
              iconData: Icons.drive_folder_upload),
          SizedBox(
            width: CommonSize.fontsizeLg,
          ),
          _menuItem(
              callback: getImageFromCamera,
              iconData: Icons.camera_alt_outlined),
          SizedBox(
            width: CommonSize.marginMd,
          ),
        ],
      ),
    );
  }

  Widget _gridView() {
    return GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: imageList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 1,
            crossAxisSpacing: 1,
            childAspectRatio: 1),
        itemBuilder: (BuildContext buildContext, int index) {
          final item = imageList[index];
          return GestureDetector(
            onTap: () {
              selectedImage = item;
              update();
            },
            child:
                _photoItem(e: item, opacity: (item == selectedImage ? 0.5 : 1)),
          );
        });
  }

  Widget _photoItem({AssetEntity? e, int? size, double? opacity}) {
    return FutureBuilder(
      builder: (_, AsyncSnapshot<Uint8List?> snapshot) {
        if (snapshot.hasData) {
          return Opacity(
            opacity: opacity ?? 1,
            child: Image.memory(
              snapshot.data!,
              fit: BoxFit.cover,
            ),
          );
        }
        return Container();
      },
      future: e?.thumbnailDataWithSize(ThumbnailSize.square((size ?? 200))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: CommonSize.marginLg),
            _preView(),
            SizedBox(height: CommonSize.marginXl),
            _menu(),
            SizedBox(height: CommonSize.marginLg),
            _gridView()
          ],
        ),
      ),
    );
  }
}
