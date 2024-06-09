part of 'auth.page.dart';

class SignInWithEmailAndPasswordFragment extends StatefulWidget {
  const SignInWithEmailAndPasswordFragment({super.key});

  @override
  State<SignInWithEmailAndPasswordFragment> createState() =>
      _SignInWithEmailAndPasswordFragmentState();
}

class _SignInWithEmailAndPasswordFragmentState
    extends State<SignInWithEmailAndPasswordFragment> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController _emailTec;
  late TextEditingController _passwordTec;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _emailTec = TextEditingController();
    _passwordTec = TextEditingController();
  }

  @override
  dispose() {
    super.dispose();
    _emailTec.dispose();
    _passwordTec.dispose();
  }

  String? _handleValidateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return '이메일을 입력해주세요';
    } else if (!(RegExp(r'^[^@]+@[^@]+\.[^@]+')).hasMatch(email)) {
      return '유효한 이메일을 입력해주세요';
    } else {
      return null;
    }
  }

  String? _handleValidatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return '비밀번호를 입력해주세요';
    } else if (password.length < 6) {
      return '비밀번호를 6자 이상 입력해주세요';
    } else {
      return null;
    }
  }

  _handleClearEmail() => _emailTec.clear();

  _handleClearPassword() => _passwordTec.clear();

  _handleSignIn() {
    final email = _emailTec.text.trim();
    final password = _passwordTec.text.trim();
    if (!_formKey.currentState!.validate()) {
      ToastUtil.toast('유효한 값을 입력해주세요');
      return;
    } else {
      context.read<UserBloc>().add(
          SignInWithEmailAndPasswordEvent(email: email, password: password));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(children: [
          // 이메일
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: TextFormField(
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(decorationThickness: 0),
                controller: _emailTec,
                validator: _handleValidateEmail,
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email),
                    labelText: "이메일",
                    suffixIcon: IconButton(
                        onPressed: _handleClearEmail,
                        icon: const Icon(Icons.clear))),
              )),

          // 비밀번호
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: TextFormField(
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(decorationThickness: 0),
                controller: _passwordTec,
                validator: _handleValidatePassword,
                decoration: InputDecoration(
                    labelText: "비밀번호",
                    prefixIcon: const Icon(Icons.key),
                    suffixIcon: IconButton(
                        onPressed: _handleClearPassword,
                        icon: const Icon(Icons.clear))),
              )),

          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: ElevatedButton(
                onPressed: _handleSignIn,
                child: const Text("로그인하기"),
              )),
        ]));
  }
}
