part of '../index.page.dart';

class EditMetaDataScreen extends StatefulWidget {
  const EditMetaDataScreen({super.key});

  @override
  State<EditMetaDataScreen> createState() => _EditMetaDataScreenState();
}

class _EditMetaDataScreenState extends State<EditMetaDataScreen> {
  _handleUpload() {
    context.read<EditDiaryBloc>().add(SubmitDiaryEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              context
                  .read<EditDiaryBloc>()
                  .add(InitializeEvent(step: EditDiaryStep.editing));
            },
          ),
          elevation: 0,
        ),
        body: SafeArea(
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              SizedBox(height: MediaQuery.of(context).size.width / 5),
              const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  child: HashtagFragment()),
              const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  child: Divider()),
              const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  child: LocationFragment()),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ElevatedButton(
                    onPressed: _handleUpload,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Submit',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(fontWeight: FontWeight.bold)),
                          const SizedBox(width: 12),
                          const Icon(Icons.upload, size: 24)
                        ])),
              ),
              SizedBox(height: MediaQuery.of(context).size.width / 5),
            ])));
  }
}
