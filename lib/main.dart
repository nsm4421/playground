import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:my_app/core/constant/routes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/dependency_injection/dependency_injection.dart';
import 'presentation/bloc/user/auth/auth.cubit.dart';
import 'presentation/bloc/user/account/account.bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 환경변수 초기화
  await dotenv.load();

  // Supabase 초기화
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABSE_ANON_KEY']!,
  );

  // 의존성 주입 초기화
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
            create: (context) => getIt<AccountBloc>()..add(InitAccountEvent()))
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
