part of '../image_to_text.page.dart';

class DownloadScreen extends StatelessWidget {
  const DownloadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('모델 다운로드'),
        ),
        body: BlocBuilder<ImageToTextBloc, ImageToTextState>(
            builder: (context, state) {
          return Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                Text('통역을 위해 언어 모델을 다운 받아야 합니다',
                    style: Theme.of(context).textTheme.displaySmall),
                const SizedBox(height: 50),
                switch (state.status) {
                  Status.loading =>
                    const Center(child: CircularProgressIndicator()),
                  Status.error => Text('오류가 발생했습니다',
                      style: Theme.of(context).textTheme.titleLarge),
                  (_) => Column(
                      children: [
                        if (!state.sourceLangModelLoaded)
                          ElevatedButton(
                            onPressed: () {
                              context.read<ImageToTextBloc>().add(
                                  DownloadModelEvent(
                                      downloadSourceLangModel: true));
                            },
                            child: Text(
                                '${state.sourceLang.lang.name} 언어모델 다운 받기',
                                style: Theme.of(context).textTheme.titleLarge),
                          ),
                        if (!state.targetLangModelLoaded)
                          ElevatedButton(
                            onPressed: () {
                              context.read<ImageToTextBloc>().add(
                                  DownloadModelEvent(
                                      downloadTargetLangModel: true));
                            },
                            child: Text(
                                '${state.targetLang.lang.name} 언어모델 다운 받기',
                                style: Theme.of(context).textTheme.titleLarge),
                          ),
                      ],
                    )
                }
              ]));
        }));
  }
}
