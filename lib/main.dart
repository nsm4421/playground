import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_app/core/constant/routes.dart';
import 'package:my_app/domain/model/chat/message/local_private_chat_message.model.dart';
import 'package:my_app/presentation/bloc/user/user.bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/dependency_injection/dependency_injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 환경변수 초기화
  await dotenv.load();

  // TODO : adapter 등록 못하는 버그 수정하기
  // 로컬 DB 초기화
  await Hive.initFlutter();
  Hive.registerAdapter<LocalPrivateChatMessageModel>(
      LocalPrivateChatMessageModelAdapter());

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
    return BlocProvider(
      create: (context) => getIt<UserBloc>()..add(InitUserEvent()),
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
