import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio/features/auth/presentation/bloc/auth.bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HOME"),
        actions: [
          IconButton(onPressed: (){
            context.read<AuthBloc>().add(SignOutEvent());
          }, icon: Icon(Icons.logout))
        ],
      ),
    );
  }
}
