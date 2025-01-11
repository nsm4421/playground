part of '../export.pages.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(GetUserEvent(isOnMount: true));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(
              flex: 1,
            ),
            Text(
              "Karma",
              style: context.textTheme.displayLarge?.copyWith(
                  color: context.colorScheme.primary,
                  fontWeight: FontWeight.bold),
            ),
            25.height,

            /// sign in button
            Text(
              "To start, need to login first",
              style: context.textTheme.labelLarge?.copyWith(
                  color: context.colorScheme.primary,
                  fontWeight: FontWeight.w600),
            ),
            ElevatedButton(
                onPressed: () {
                  context.push(Routes.signIn.path);
                },
                child: const Text("Sign In")),
            25.height,

            /// sign up button
            Text(
              "If you don't have account",
              style: context.textTheme.labelLarge?.copyWith(
                  color: context.colorScheme.primary,
                  fontWeight: FontWeight.w600),
            ),
            ElevatedButton(
                onPressed: () {
                  context.push(Routes.signUp.path);
                },
                child: const Text("Sign Up")),
            const Spacer(
              flex: 2,
            )
          ],
        ),
      ),
    );
  }
}
