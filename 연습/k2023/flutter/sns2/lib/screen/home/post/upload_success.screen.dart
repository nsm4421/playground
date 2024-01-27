import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/screen/home/post/bloc/post.bloc.dart';
import 'package:my_app/screen/home/post/bloc/post.event.dart';

class UploadSuccessScreen extends StatelessWidget {
  const UploadSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height / 4),
              Center(
                child: Text(
                  "Success",
                  style: GoogleFonts.lobster(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary),
                ),
              ),
              const SizedBox(height: 20),
              Text("Post upload successfully",
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 30),
              ElevatedButton(
                  onPressed: () {
                    context.read<PostBloc>().add(InitPostEvent());
                  },
                  child: Text(
                    "Initialize",
                    style: Theme.of(context).textTheme.titleMedium,
                  ))
            ],
          ),
        ),
      );
}
