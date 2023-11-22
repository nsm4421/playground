import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:my_app/core/utils/logging/custom_logger.dart';
import 'package:my_app/presentation/pages/auth/sign-up/bloc/sign_up.bloc.dart';
import 'package:my_app/presentation/pages/auth/sign-up/bloc/sign_up.event.dart';
import 'package:my_app/presentation/pages/auth/sign-up/bloc/sign_up.state.dart';

class ProfileImageFragment extends StatelessWidget {
  const ProfileImageFragment({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<SignUpBloc, SignUpState>(
      builder: (_, state) => _ProfileImageFragmentView(state));
}

class _ProfileImageFragmentView extends StatefulWidget {
  const _ProfileImageFragmentView(this.state, {super.key});

  final SignUpState state;

  @override
  State<_ProfileImageFragmentView> createState() =>
      _ProfileImageFragmentViewState();
}

class _ProfileImageFragmentViewState extends State<_ProfileImageFragmentView> {
  static const int _maxImages = 5;

  /// 이미지 선택하기
  _handleSelectImage() async {
    try {
      await MultiImagePicker.pickImages(
        maxImages: _maxImages,
        enableCamera: true,
        selectedAssets: widget.state.images,
        cupertinoOptions: const CupertinoOptions(takePhotoIcon: "프사"),
        materialOptions: const MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "프사",
          allViewTitle: "All",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      ).then((selected) {
        context.read<SignUpBloc>().add(
            UpdateOnBoardStateEvent(widget.state.copyWith(images: selected)));
      });
    } catch (err) {
      CustomLogger.logger.e(err);
    }
  }

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 50),
            Text("Profile Image",
                style: GoogleFonts.lobsterTwo(
                    fontSize: 50, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: _handleSelectImage,
                child: Row(
                  children: [
                    Text("잘 나온 사진을 선택해주세요(최대 $_maxImages개)",
                        style: Theme.of(context).textTheme.bodyMedium),
                    const Spacer(),
                    const Icon(Icons.add_a_photo_outlined),
                  ],
                )),
            const SizedBox(height: 50),
            _CarouselSlicer(widget.state.images)
          ],
        ),
      );
}

class _CarouselSlicer extends StatelessWidget {
  const _CarouselSlicer(this.images, {super.key});

  final List<Asset> images;

  @override
  Widget build(BuildContext context) => CarouselSlider(
        items: images
            .map((asset) => Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onPrimaryContainer),
                  child: AssetThumb(
                    asset: asset,
                    width: MediaQuery.of(context).size.width.floor(),
                    height: MediaQuery.of(context).size.width.floor(),
                  ),
                ))
            .toList(),
        options: CarouselOptions(
          autoPlay: true,
          autoPlayAnimationDuration: const Duration(seconds: 1),
          enableInfiniteScroll: false,
          enlargeCenterPage: true,
        ),
      );
}
