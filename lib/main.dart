import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/core/constant/routes.dart';

import 'core/dependency_injection/dependency_injection.dart';
import 'firebase_options.dart';
import 'presentation/bloc/auth/auth.cubit.dart';
import 'presentation/bloc/user/user.bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // init firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // init dependency injection
  configureDependencies();

  runApp(const RootWidget());
}

class RootWidget extends StatelessWidget {
  const RootWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // 앱 전역에서 접근할 수 있는 Bloc
        BlocProvider(create: (context) => getIt<AuthCubit>()),
        BlocProvider(
            create: (context) => getIt<UserBloc>()..add(InitUserEvent()))
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'My Short App',
        theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.blueGrey,
              brightness: Brightness.dark,
            )),
        routerConfig: routerConfig,
      ),
    );
  }
}
