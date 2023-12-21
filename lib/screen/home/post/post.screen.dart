import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:my_app/screen/home/post/bloc/post.bloc.dart';
import 'package:my_app/screen/home/post/bloc/post.state.dart';
import 'package:my_app/screen/home/post/hashtag.fragment.dart';
import 'package:my_app/screen/home/post/photo.fragment.dart';
import 'package:my_app/screen/home/post/upload_success.screen.dart';

import '../../../configurations.dart';
import '../bloc/auth.bloc.dart';
import 'bloc/post.event.dart';
import 'content.fragment.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: BlocProvider(
          create: (_) => getIt<PostBloc>()..add(InitPostEvent()),
          child: BlocBuilder<PostBloc, PostState>(
            builder: (_, state) {
              switch (state.status) {
                case PostStatus.initial:
                  return const _PostScreenView();
                case PostStatus.success:
                  return const UploadSuccessScreen();
                case PostStatus.loading:
                  return const Center(child: CircularProgressIndicator());
                case PostStatus.error:
                  return const Text("ERROR");
              }
            },
          ),
        ),
      );
}

class _PostScreenView extends StatefulWidget {
  const _PostScreenView({super.key});

  @override
  State<_PostScreenView> createState() => _PostScreenViewState();
}

class _PostScreenViewState extends State<_PostScreenView> {
  static const int _maxImages = 5;

  late TextEditingController _contentTec;
  late PageController _pc;
  late List<TextEditingController> _hashtagTecList;
  late List<Asset> _assets;
  int _currentPage = 0;

  @override
  initState() {
    super.initState();
    _contentTec = TextEditingController();
    _pc = PageController();
    _hashtagTecList = [TextEditingController()];
    _assets = [];
  }

  @override
  dispose() {
    super.dispose();
    _contentTec.dispose();
    _pc.dispose();
    _hashtagTecList.forEach((tec) => tec.dispose());
  }

  _handlePageChange(int index) => setState(() {
        _currentPage = index;
      });

  _moveToPage(int page) => () => _pc.animateToPage(page,
      duration: const Duration(milliseconds: 300), curve: Curves.easeIn);

  _setHashtagTecList(List<TextEditingController> hashtagTecList) =>
      setState(() {
        _hashtagTecList = hashtagTecList;
      });

  _setAssets(List<Asset> assets) => setState(() {
        _assets = assets;
      });

  _handleUpload() {
    try {
      context.read<PostBloc>().add(SubmitPostEvent(
          content: _contentTec.text.trim(),
          hashtags: _hashtagTecList
              .map((tec) => tec.text)
              .where((text) => text.trim().isNotEmpty)
              .toSet()
              .toList(),
          images: _assets));
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("Create Post"),
          actions: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).colorScheme.onPrimaryContainer),
                onPressed: _handleUpload,
                child: Text(
                  "Submit",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimary),
                )),
            const SizedBox(width: 10)
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 20, right: 15, left: 15),
          child: Column(
            children: [
              Row(
                children: [
                  // profile image
                  context.read<AuthBloc>().state.profileImageUrls.isEmpty
                      ? const CircleAvatar(
                          child: Icon(Icons.account_circle_outlined))
                      : CircleAvatar(
                          backgroundImage: NetworkImage(context
                              .read<AuthBloc>()
                              .state
                              .profileImageUrls[0])),

                  const SizedBox(width: 15),
                  Text(context.read<AuthBloc>().state.nickname,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold)),
                  const Spacer(),
                  // content button
                  IconButton(
                      onPressed: _moveToPage(0),
                      icon: Icon(Icons.book,
                          color: _currentPage == 0
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.tertiary)),
                  const SizedBox(width: 5),
                  // hashtag button
                  IconButton(
                      onPressed: _moveToPage(1),
                      icon: Icon(
                        Icons.tag,
                        color: _currentPage == 1
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.tertiary,
                      )),
                  const SizedBox(width: 5),
                  // camera button
                  IconButton(
                      onPressed: _moveToPage(2),
                      icon: Icon(
                        Icons.add_a_photo_outlined,
                        color: _currentPage == 2
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.tertiary,
                      )),
                ],
              ),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 20),
              Expanded(
                child: PageView(
                  onPageChanged: _handlePageChange,
                  controller: _pc,
                  pageSnapping: true,
                  children: [
                    // content
                    ContentFragment(_contentTec),
                    HashtagFragment(
                        hashtagTecList: _hashtagTecList,
                        setHashtagTecList: _setHashtagTecList),
                    PhotoFragment(assets: _assets, setAssets: _setAssets)
                  ],
                ),
              )
            ],
          ),
        ),
      );
}
