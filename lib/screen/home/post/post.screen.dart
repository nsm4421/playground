import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:my_app/screen/home/bloc/auth.bloc.dart';
import 'package:my_app/screen/home/post/bloc/post.bloc.dart';
import 'package:my_app/screen/home/post/bloc/post.state.dart';

import '../../../configurations.dart';
import 'bloc/post.event.dart';

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
                  return const _UploadSuccessScreen();
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
  late TextEditingController _tec;
  List<String> _hashtags = [];
  List<Asset> _images = [];

  @override
  initState() {
    super.initState();
    _tec = TextEditingController();
  }

  @override
  dispose() {
    super.dispose();
    _tec.dispose();
  }

  // TODO : 해시태그 입력 기능
  _handleShowHashtagWidget() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Text("TODO"),
      isScrollControlled: true,
      enableDrag: true,
      isDismissible: true,
      useSafeArea: true,
      barrierColor: Colors.grey.withOpacity(0.5),
    );
  }

  // TODO : 이미지 선택 입력 기능
  _handleShowSelectImageWidget() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Text("TODO"),
      isScrollControlled: true,
      enableDrag: true,
      isDismissible: true,
      useSafeArea: true,
      barrierColor: Colors.grey.withOpacity(0.5),
    );
  }

  _handleUpload() {
    try {
      context.read<PostBloc>().add(SubmitPostEvent(
          content: _tec.text.trim(), hashtags: _hashtags, images: _images));
    } catch (err) {}
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("Create Post"),
          actions: [
            ElevatedButton(
                onPressed: _handleUpload, child: const Text("Submit"))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 20, right: 15, left: 15),
          child: SingleChildScrollView(
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
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold)),
                    const Spacer(),
                    // hashtag button
                    IconButton(
                        onPressed: _handleShowHashtagWidget,
                        icon: Icon(
                          Icons.tag,
                          color: Theme.of(context).colorScheme.primary,
                        )),
                    const SizedBox(width: 5),
                    // camera button
                    IconButton(
                        onPressed: _handleShowSelectImageWidget,
                        icon: Icon(
                          Icons.add_a_photo_outlined,
                          color: Theme.of(context).colorScheme.primary,
                        )),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(width: 50),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: _tec,
                            minLines: 1,
                            maxLines: 20,
                            decoration:
                                const InputDecoration(border: InputBorder.none),
                            maxLength: 1000,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
}

class _UploadSuccessScreen extends StatelessWidget {
  const _UploadSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height / 4),
              Center(
                child: Text(
                  "Success",
                  style: GoogleFonts.lobster(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary),
                ),
              ),
              const SizedBox(height: 20),
              Text("Post upload successfully",
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 50),
            ],
          ),
        ),
      );
}
