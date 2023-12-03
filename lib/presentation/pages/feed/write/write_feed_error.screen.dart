import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/presentation/pages/feed/write/bloc/write_feed/write_feed.bloc.dart';
import 'package:my_app/presentation/pages/feed/write/bloc/write_feed/write_feed.event.dart';

class WriteFeedErrorScreen extends StatelessWidget {
  const WriteFeedErrorScreen({super.key});

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height / 4),
                Center(
                  child: Text(
                    "Error",
                    style: GoogleFonts.lobster(
                        fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),
                Text("작성 중 에러가 발생했습니다",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).colorScheme.secondary)),
                const SizedBox(height: 50),
                ElevatedButton(
                    onPressed: () {
                      context
                          .read<WriteFeedBloc>()
                          .add(WriteFeedInitializedEvent());
                    },
                    child: Text(
                      "돌아가기",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    )),
              ],
            ),
          ),
        ),
      );
}
