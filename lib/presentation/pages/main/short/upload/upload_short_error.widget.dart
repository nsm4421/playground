part of 'upload_short.screen.dart';

class UploadShortErrorWidget extends StatelessWidget {
  const UploadShortErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text("ERROR", style: Theme.of(context).textTheme.displayLarge),
          const SizedBox(height: 20),
          ElevatedButton(
              onPressed: () {
                context.read<UploadShortCubit>().initState();
              },
              child: const Text("INIT"))
        ],
      ),
    );
  }
}
