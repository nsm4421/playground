part of '../../export.pages.dart';

class PasswordRecoveryScreen extends StatefulWidget {
  const PasswordRecoveryScreen({super.key});

  @override
  State<PasswordRecoveryScreen> createState() => _PasswordRecoveryScreenState();
}

class _PasswordRecoveryScreenState extends State<PasswordRecoveryScreen> {
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
  }

  _handleClearEmail() {
    // Regex로 올바른 이메일 형식인지 검사
    _emailController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Password Recovery"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "new password will be send to your email",
              style: context.textTheme.bodyLarge
                  ?.copyWith(color: context.colorScheme.tertiary),
            ),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: 'karma@naver.com',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: _handleClearEmail,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
