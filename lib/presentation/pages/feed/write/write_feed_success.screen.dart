import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class WriteFeedSuccessScreen extends StatelessWidget {
  const WriteFeedSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
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
                Text("피드 작성에 성공하였습니다",
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 50),
                ElevatedButton(
                    onPressed: () {
                      context.pop();
                    },
                    child: Text(
                      "홈으로",
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
