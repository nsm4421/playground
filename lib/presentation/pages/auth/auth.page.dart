import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/presentation/bloc/user/user.bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/constant/routes.dart';
import '../../../core/util/toast.util.dart';

part 'auth.screen.dart';
part 'sign_in_with_email.fragment.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AuthScreen();
  }
}
