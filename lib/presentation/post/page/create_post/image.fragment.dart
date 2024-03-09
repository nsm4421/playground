import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hot_place/presentation/component/image.widget.dart';

import '../../bloc/create_post/create_post.cubit.dart';

class ImageFragment extends StatefulWidget {
  const ImageFragment({super.key});

  @override
  State<ImageFragment> createState() => _ImageFragmentState();
}

class _ImageFragmentState extends State<ImageFragment> {
  int _currentImageIndex = 0;

  _selectImage() async {
    await context.read<CreatePostCubit>().selectImages();
    setState(() {
      _currentImageIndex = 0;
    });
  }

  _changeCurrentImage(int index) => () => setState(() {
        _currentImageIndex = index;
      });

  _deleteImage(int index) => () {
        context.read<CreatePostCubit>().deleteImage(index);
        setState(() {
          _currentImageIndex = 0;
        });
      };

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 제목
            Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 10, bottom: 5),
                child: Row(
                  children: [
                    Text("Image",
                        style: Theme.of(context).textTheme.titleLarge),
                    const Spacer(),
                    if (context.read<CreatePostCubit>().state.assets.isNotEmpty)
                      IconButton(
                          onPressed: _selectImage,
                          icon: const Icon(Icons.add_a_photo))
                  ],
                )),
            Padding(
                padding: const EdgeInsets.only(left: 10.0, bottom: 20),
                child: Text("최대 3개의 이미지를 업로드 할 수 있습니다",
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Theme.of(context).colorScheme.secondary))),
            // 이미지
            Container(
                decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .primaryContainer
                        .withAlpha(80)),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width,
                child: context.read<CreatePostCubit>().state.assets.isEmpty
                    ? InkWell(
                        onTap: _selectImage,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.add_a_photo_outlined, size: 35),
                            const SizedBox(height: 20),
                            Text("선택된 사진이 없습니다",
                                style: Theme.of(context).textTheme.bodyLarge),
                          ],
                        ),
                      )
                    : SquareImageWidget(context
                        .read<CreatePostCubit>()
                        .state
                        .assets[_currentImageIndex])),
            const SizedBox(height: 30),
            const Divider(indent: 20, endIndent: 20),
            const SizedBox(height: 30),

            // 선택한 이미지
            if (context.read<CreatePostCubit>().state.assets.isNotEmpty)
              Wrap(
                  spacing: 1,
                  children: List.generate(
                      context.read<CreatePostCubit>().state.assets.length,
                      (index) {
                    final image =
                        context.read<CreatePostCubit>().state.assets[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Stack(
                        children: [
                          GestureDetector(
                              onTap: _changeCurrentImage(index),
                              child: CircleImageWidget(image, size: 120)),
                          // 삭제버튼
                          Positioned(
                            top: 0,
                            right: 0,
                            child: IconButton(
                              onPressed: _deleteImage(index),
                              icon: Icon(
                                Icons.remove_circle,
                                size: 30,
                                color: Theme.of(context)
                                    .colorScheme
                                    .tertiaryContainer,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }))
          ],
        ),
      );
}
