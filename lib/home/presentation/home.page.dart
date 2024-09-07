import 'package:flutter/material.dart';
import 'package:flutter_app/auth/presentation/bloc/authentication.bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home.screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return HomeScreen();
  }
}
