import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:travel/core/theme/theme.dart';
import 'package:travel/core/util/snackbar/snackbar.dart';
import 'package:travel/presentation/bloc/module.dart';
import 'package:travel/presentation/route/router.dart';

import 'core/di/dependency_injection.dart';
import 'core/env/env.dart';
import 'presentation/bloc/auth/presence/bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
      url: Env.supabaseUrl,
      anonKey: Env.supabaseAnonKey); // supabase client 초기화

  configureDependencies(); // 의존성 주입

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      /// 인증상태가 변경되는 경우 라우팅 처리
      create: (_) => getIt<BlocModule>().auth..add(UpdateCurrentUserEvent()),
      child: MaterialApp.router(
        title: 'Traveler',
        theme: customThemeData,
        routerConfig: getIt<CustomRouter>().routerConfig,
        builder: (context, child) => Stack(
          children: [
            child!,
            SnackBarWidget(key: getIt<CustomSnackBar>().snackbarKey),
          ],
        ),
      ),
    );
  }
}
