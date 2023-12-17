import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/screen/home/profile/feed.fragment.dart';
import 'package:my_app/screen/home/profile/reply.fragment.dart';

enum _ProfileTabItems {
  feed(label: 'Feed', fragment: FeedFragment()),
  reply(label: 'Replies', fragment: ReplyFragment()),
  repost(label: 'Reposts', fragment: ReplyFragment());

  final String label;
  final Widget fragment;

  const _ProfileTabItems({required this.label, required this.fragment});
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(
      length: _ProfileTabItems.values.length,
      vsync: this,
      initialIndex: 0,
      animationDuration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(right: 15, left: 15, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text("test",
                    style: GoogleFonts.karla(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                subtitle: Text("@test",
                    style: GoogleFonts.karla(
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.secondary)),
                contentPadding: const EdgeInsets.all(0),
                trailing: const CircleAvatar(
                  // TODO : 유저 프로필 이미지
                  // backgroundImage: ,
                  radius: 25,
                ),
              ),
              // TODO : 팔로잉 숫자 표시
              const Text("1000 Followers"),
              const SizedBox(height: 20),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                InkWell(
                    onTap: () {},
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Theme.of(context)
                              .colorScheme
                              .tertiary
                              .withOpacity(0.5)),
                      alignment: Alignment.center,
                      child: Text("Edit Profile",
                          style: GoogleFonts.karla(
                              fontWeight: FontWeight.w700,
                              color: Theme.of(context).colorScheme.primary)),
                    )),
                InkWell(
                    onTap: () {},
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Theme.of(context)
                              .colorScheme
                              .tertiary
                              .withOpacity(0.5)),
                      alignment: Alignment.center,
                      child: Text("Share Profile",
                          style: GoogleFonts.karla(
                              fontWeight: FontWeight.w700,
                              color: Theme.of(context).colorScheme.primary)),
                    ))
              ]),
              const SizedBox(height: 30),
              TabBar(
                controller: _controller,
                labelColor: Theme.of(context).colorScheme.primary,
                indicatorColor: Theme.of(context).colorScheme.secondary,
                tabs: _ProfileTabItems.values
                    .map((e) => SizedBox(
                        width: double.infinity, child: Tab(text: e.label)))
                    .toList(),
              ),
              Expanded(
                child: TabBarView(
                    controller: _controller,
                    children: _ProfileTabItems.values
                        .map((e) => e.fragment)
                        .toList()),
              )
            ],
          ),
        ),
      );
}
