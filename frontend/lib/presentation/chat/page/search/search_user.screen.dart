import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hot_place/core/di/dependency_injection.dart';
import 'package:hot_place/presentation/chat/bloc/search_user/search_user.cubit.dart';
import 'package:hot_place/presentation/chat/bloc/search_user/search_user.state.dart';

import '../../../../core/constant/response.constant.dart';
import '../../../../core/constant/user.constant.dart';
import '../../../../core/util/toast.util.dart';
import '../../../../data/entity/user/user.entity.dart';
import '../../../setting/widget/profile_image.widget.dart';

class SearchUserScreen extends StatelessWidget {
  const SearchUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => getIt<SearchUserCubit>(),
        child:
            BlocBuilder<SearchUserCubit, SearchUserState>(builder: (_, state) {
          switch (state.status) {
            case Status.initial:
              return const _OnInit();
            case Status.loading:
              return const _OnLoading();
            case Status.success:
              return _OnSuccess(
                  type: state.type, keyword: state.keyword, users: state.users);
            case Status.error:
              return _OnError(state.errorMessage);
          }
        }));
  }
}

class _OnInit extends StatefulWidget {
  const _OnInit({super.key});

  @override
  State<_OnInit> createState() => _OnInitState();
}

class _OnInitState extends State<_OnInit> {
  late TextEditingController _textEditingController;
  late UserSearchType _type;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _type = context.read<SearchUserCubit>().state.type;
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
  }

  _handleType(UserSearchType type) => () => setState(() {
        context.read<SearchUserCubit>().switchType(type);
        _type = type;
      });

  _handleSearch() {
    final keyword = _textEditingController.text.trim();
    if (keyword.isEmpty) {
      ToastUtil.toast('검색어를 입력해주세요');
      return;
    }
    context.read<SearchUserCubit>().searchUsers(type: _type, keyword: keyword);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("유저 검색하기"),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 30, left: 10, right: 10, bottom: 30),
            child: Text("검색조건",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold)),
          ),

          // 검색조건 버튼
          Wrap(
            children: UserSearchType.values
                .map((e) => Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: ElevatedButton(
                          onPressed: _handleType(e),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: e == _type
                                  ? Theme.of(context)
                                      .colorScheme
                                      .primaryContainer
                                  : Theme.of(context)
                                      .colorScheme
                                      .secondaryContainer),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(e.iconData),
                              const SizedBox(width: 5),
                              Text(e.label,
                                  style: e == _type
                                      ? Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                              fontWeight: FontWeight.bold)
                                      : Theme.of(context).textTheme.titleSmall)
                            ],
                          )),
                    ))
                .toList(),
          ),

          // 입력창
          Padding(
            padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
            child: TextField(
              decoration: InputDecoration(
                  hintText: "${_type.label}을 입력해주세요",
                  prefixIcon: Icon(_type.iconData),
                  suffixIcon: IconButton(
                      onPressed: _handleSearch,
                      icon: Icon(Icons.search,
                          color: Theme.of(context).colorScheme.primary))),
              controller: _textEditingController,
            ),
          ),
        ],
      ),
    );
  }
}

class _OnLoading extends StatelessWidget {
  const _OnLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class _OnSuccess extends StatefulWidget {
  const _OnSuccess(
      {super.key,
      required this.type,
      required this.keyword,
      required this.users});

  final UserSearchType type;
  final String keyword;
  final List<UserEntity> users;

  @override
  State<_OnSuccess> createState() => _OnSuccessState();
}

class _OnSuccessState extends State<_OnSuccess> {
  _handleInitialize() {
    context.read<SearchUserCubit>().init();
  }

  _handlePop() {
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              tooltip: "검색 초기화",
              onPressed: _handleInitialize,
              icon: const Icon(Icons.rotate_left)),
          IconButton(onPressed: _handlePop, icon: const Icon(Icons.clear))
        ],
      ),
      body: widget.users.isEmpty
          ? Center(
              child: Text(
              "조회된 유저가 없습니다",
              style: Theme.of(context).textTheme.headlineSmall,
            ))
          : SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 25),
                    child: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: "\"${widget.keyword}\"",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.bold)),
                        const TextSpan(text: "로 검색한 결과"),
                      ]),
                    ),
                  ),
                  const Divider(indent: 30, endIndent: 30),

                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: widget.users.length,
                    itemBuilder: (_, index) {
                      final item = widget.users[index];
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            // 프로필 이미지
                            leading: ProfileImageWidget(item.profileImage),

                            // 닉네임
                            title: Text(
                              item.nickname ?? "Unknown",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),

                            // 자기소개
                            subtitle: item.introduce != null
                                ? Text(item.introduce ?? '',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge
                                        ?.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .tertiary))
                                : null,
                          ),

                          // 해시태그
                          if (item.hashtags.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Wrap(
                                  children: item.hashtags
                                      .map((e) => Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 5),
                                          margin:
                                              const EdgeInsets.only(left: 10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondaryContainer),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const Icon(Icons.tag),
                                              const SizedBox(width: 5),
                                              Text(e,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelLarge),
                                            ],
                                          )))
                                      .toList()),
                            )
                        ],
                      );
                    },
                    separatorBuilder: (_, __) =>
                        const Divider(indent: 20, endIndent: 20),
                  ),
                ],
              ),
            ),
    );
  }
}

class _OnError extends StatelessWidget {
  const _OnError(this.errorMessage, {super.key});

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child:
            Text(errorMessage, style: Theme.of(context).textTheme.displaySmall),
      ),
    );
  }
}
