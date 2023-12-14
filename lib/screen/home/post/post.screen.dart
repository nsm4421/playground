import 'package:flutter/material.dart';
import 'package:my_app/configurations.dart';
import 'package:my_app/repository/auth/auth.repository.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  late TextEditingController _postTec;

  @override
  void initState() {
    super.initState();
    _postTec = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _postTec.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("Create Post"),
          // centerTitle: true,
          actions: [
            ElevatedButton(onPressed: () {}, child: const Text("Submit"))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 20, right: 15, left: 15),
          child: Column(
            children: [
              Row(
                children: [
                  const CircleAvatar(),
                  const SizedBox(width: 15),
                  // TODO : uid대신 닉네임
                  Text(getIt<AuthRepository>().currentUid ?? 'User',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  const Spacer(),
                  IconButton(
                      onPressed: () {},
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
                          controller: _postTec,
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
      );
}
