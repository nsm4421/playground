import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/domain/repository/auth/auth.repository.dart';
import 'package:my_app/presentation/bloc/user/user.bloc.dart';
import 'package:my_app/presentation/view/route/routes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../core/config/dependency_injection.dart';
import 'bloc/auth/auth.bloc.dart';
import 'bloc/auth/auth.event.dart';
import 'bloc/user/user.event.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) => MultiBlocProvider(

          // 앱 전역에서 접근할 수 있는 Bloc설정
          providers: [
            BlocProvider<AuthBloc>(create: (_) => getIt<AuthBloc>()),
            BlocProvider<UserBloc>(
                create: (_) => getIt<UserBloc>()..add((InitProfile()))),
          ],

          // Stream을 사용해 인증상태 변경 시마다 상태 변경
          child: StreamBuilder<User?>(
              stream: getIt<AuthRepository>().authStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  final user = snapshot.data;
                  context.read<AuthBloc>().add(UpdateAuthState(user: user));

                  // 라우팅 설정
                  return MaterialApp.router(
                    routerConfig: router,
                    debugShowCheckedModeBanner: false,
                  );
                }
                return const SizedBox();
              }));
}
