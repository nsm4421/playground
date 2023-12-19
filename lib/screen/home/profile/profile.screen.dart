import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/screen/home/bloc/auth.bloc.dart';
import 'package:my_app/screen/home/bloc/auth.event.dart';
import 'package:my_app/screen/component/feed.fragment.dart';
import 'package:my_app/screen/home/profile/reply.fragment.dart';

enum _ProfileTabItems {
  feed(label: 'Feed', fragment: FeedFragment(isMyFeed: true)),
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

  // TODO : 이미지 선택 입력 기능
  _handleShowEditProfile() {
    showModalBottomSheet(
      context: context,
      builder: (context) => const _EditProfileWidget(),
      showDragHandle: true,
      isScrollControlled: false,
      enableDrag: true,
      isDismissible: true,
      useSafeArea: true,
      barrierColor: Colors.grey.withOpacity(0.5),
    );
  }

  _handleSignOut() => context.read<AuthBloc>().add(SignOutEvent());

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(right: 15, left: 15, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: context
                        .read<AuthBloc>()
                        .state
                        .profileImageUrls
                        .isNotEmpty
                    ? CircleAvatar(
                        backgroundImage: NetworkImage(
                            context.read<AuthBloc>().state.profileImageUrls[0]),
                        radius: 25,
                      )
                    : const CircleAvatar(
                        child: Icon(Icons.account_circle_outlined)),
                title: Text(context.read<AuthBloc>().state.nickname ?? '',
                    style: GoogleFonts.karla(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                subtitle: Text("1000 followers",
                    style: GoogleFonts.karla(
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.secondary)),
                contentPadding: const EdgeInsets.all(0),
                trailing: IconButton(
                  icon: const Icon(Icons.exit_to_app),
                  onPressed: _handleSignOut,
                  tooltip: "Sign Out",
                ),
              ),
              const SizedBox(height: 20),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                InkWell(
                    onTap: _handleShowEditProfile,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Theme.of(context)
                              .colorScheme
                              .tertiary
                              .withOpacity(0.3)),
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
                              .withOpacity(0.3)),
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

class _EditProfileWidget extends StatefulWidget {
  const _EditProfileWidget({super.key});

  @override
  State<_EditProfileWidget> createState() => _EditProfileWidgetState();
}

class _EditProfileWidgetState extends State<_EditProfileWidget> {
  late TextEditingController _nicknameTec;

  @override
  void initState() {
    super.initState();
    _nicknameTec = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _nicknameTec.dispose();
  }

  _handleClearText() => _nicknameTec.clear();

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Nickname",
              style: GoogleFonts.lobsterTwo(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 18),
            ),
            TextFormField(
              controller: _nicknameTec,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: _handleClearText,
                      icon: const Icon(Icons.clear))),
            )
          ],
        ),
      );
}
