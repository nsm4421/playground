import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/domain/repository/auth/auth.repository.dart';
import 'package:my_app/presentation/view/route/routes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../core/config/dependency_injection.dart';
import 'bloc/auth/user.bloc.dart';
import 'bloc/auth/user.event.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider<UserBloc>(
      create: (_) => getIt<UserBloc>()..add(UpdateUserState(null)),
      child: StreamBuilder<User?>(
          stream: getIt<AuthRepository>().getCurrentUserStream(),
          builder: (context, snapshot) {
            final user = snapshot.data;
            context.read<UserBloc>().add(UpdateUserState(user));

            return MaterialApp.router(
              routerConfig: router,
              debugShowCheckedModeBanner: false,
            );
          }));
}
