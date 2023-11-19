import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/core/utils/logging/custom_logger.dart';
import 'package:my_app/dependency_injection.dart';
import 'package:my_app/domain/repository/auth.repository.dart';
import 'package:my_app/presentation/pages/auth/sign-up/bloc/sign_up.bloc.dart';
import 'package:my_app/presentation/pages/auth/sign-up/bloc/sign_up.state.dart';

import '../../../../../core/constant/asset_path.dart';
import '../bloc/sign_up.event.dart';

class NicknameFragment extends StatelessWidget {
  const NicknameFragment({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<SignUpBloc, SignUpState>(
      builder: (_, state) => _NicknameFragmentView(state));
}

class _NicknameFragmentView extends StatefulWidget {
  const _NicknameFragmentView(this.state, {super.key});

  final SignUpState state;

  @override
  State<_NicknameFragmentView> createState() => _NicknameFragmentViewState();
}

class _NicknameFragmentViewState extends State<_NicknameFragmentView> {
  late TextEditingController _tec;

  bool _checkedDuplication = false; // 닉네임 중복 여부
  String _helperText = '';

  @override
  void initState() {
    super.initState();
    _tec = TextEditingController();
    _tec.text = widget.state.user.nickname;
  }

  @override
  void dispose() {
    super.dispose();
    _tec.dispose();
  }

  /// 닉네임 중복체크
  _checkNicknameDuplicated() async {
    // 유저 입력값 검사 : 3자 이상 작명했는지 체크
    final nickname = _tec.text.trim();
    if (nickname.length < 3) {
      _helperText = '닉네임은 최소 3글자로 작명해주세요';
      return;
    }
    try {
      _checkedDuplication =
          !await (getIt<AuthRepository>().checkNicknameDuplicated(nickname));
      _helperText = _checkedDuplication ? '사용 가능한 닉네임입니다' : '이미 사용중인 닉네임입니다';
      if (!_checkedDuplication) return;
      if (context.mounted) {
        context.read<SignUpBloc>().add(UpdateUserStateEvent(widget.state
            .copyWith(user: widget.state.user.copyWith(nickname: nickname))));
      }
    } catch (err) {
      _helperText = '닉네임 중복체크 중 에러가 발생했습니다';
      CustomLogger.logger.e(err);
    } finally {
      FocusManager.instance.primaryFocus?.unfocus();
      setState(() {});
    }
  }

  _handleOnTextChange(_) {
    setState(() {
      _helperText = '';
      _checkedDuplication = false;
    });
  }

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 80),
            Text("Nickname",
                style: GoogleFonts.lobsterTwo(
                    fontSize: 50, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Text("3~15자 이내로 작명해주세요",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.grey)),
            const SizedBox(height: 10),
            Text("닉네임 중복 여부를 체크해주세요",
                style: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(color: Colors.grey)),
            const SizedBox(height: 80),
            TextField(
              onChanged: _handleOnTextChange,
              controller: _tec,
              maxLength: 15,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  decorationThickness: 0,
                  color: Theme.of(context).colorScheme.primary),
              decoration: InputDecoration(
                  errorText: _helperText,
                  counterStyle: const TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Colors.grey[100],
                  suffixIcon: IconButton(
                      onPressed: _checkNicknameDuplicated,
                      icon: Opacity(
                          opacity: _checkedDuplication ? 1 : 0.3,
                          child: SvgPicture.asset(
                              color: _checkedDuplication
                                  ? Theme.of(context).primaryColor
                                  : Colors.black,
                              AssetPath.checkMark)))),
            ),
            const SizedBox(height: 20),
          ],
        ),
      );
}
