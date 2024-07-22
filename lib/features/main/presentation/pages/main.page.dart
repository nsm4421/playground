import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio/features/auth/presentation/bloc/auth.bloc.dart';
import 'package:portfolio/features/auth/presentation/pages/sign_in/sign_in.page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../components/loading.screen.dart';
import 'entry/entry.page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late Stream<AuthState> _stream;

  @override
  void initState() {
    super.initState();
    _stream = context.read<AuthBloc>().authStream;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
        stream: _stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingScreen();
          }
          return snapshot.data?.session == null
              ? const SignInPage()
              : const EntryPage();
        });
  }
}
