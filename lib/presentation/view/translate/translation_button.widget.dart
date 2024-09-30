part of '../index.page.dart';

class TranslationButtonWidget extends StatelessWidget {
  const TranslationButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImageToTextBloc, ImageToTextState>(
        builder: (context, state) {
      if (state.blocks.isNotEmpty) {
        return FloatingActionButton(
            child: switch (state.status) {
              Status.loading => Transform.scale(
                  scale: 0.5, child: const CircularProgressIndicator()),
              Status.error => const Icon(Icons.error_outline),
              (_) => const Icon(Icons.g_translate)
            },
            onPressed: () async {
              if (state.status.ok) {
                final d = OnDeviceTranslator(
                    sourceLanguage: TranslateLanguage.english,
                    targetLanguage: TranslateLanguage.korean);
                final test =
                    await d.translateText(state.blocks.first.originalText);
                await d.close();

                // context.read<ImageToTextCubit>().handleTranslate();
              }
            });
      } else {
        return const SizedBox();
      }
    });
  }
}
