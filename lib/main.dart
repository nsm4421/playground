import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'auth/auth.export.dart';
import 'create_media/create_media.export.dart';
import 'feed/feed.export.dart';
import 'shared/shared.export.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 환경변수 불러오기
  await dotenv.load();

  // supabase client 초기화
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  // 의존성 주입
  configureDependencies();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          // 인증상태 Bloc
          BlocProvider(
              create: (_) => getIt<AuthenticationBloc>()..add(InitAuthEvent())),
          // 홈 화면 Bloc
          BlocProvider(create: (_) => getIt<DisplayFeedBloc>()),
          BlocProvider(create: (_) => getIt<CreateMediaCubit>())
        ],
        child: MaterialApp.router(
          theme: CustomLightTheme().theme,
          darkTheme: CustomDarkTheme().theme,
          routerConfig: getIt<CustomRoute>().routerConfig,
          builder: (context, child) {
            return Stack(
              children: [
                child!,
                SnakbarWidget(key: getIt<CustomSnakbar>().globalKey),
              ],
            );
          },
        ));
  }
}
