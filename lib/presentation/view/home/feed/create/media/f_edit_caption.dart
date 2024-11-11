part of '../index.dart';

class EditCaptionFragment extends StatefulWidget {
  const EditCaptionFragment({super.key, required this.currentImage,this.initText });

  final AssetEntity currentImage;
  final String? initText;

  @override
  State<EditCaptionFragment> createState() => _EditCaptionFragmentState();
}

class _EditCaptionFragmentState extends State<EditCaptionFragment> {
  late TextEditingController _controller;

  static const int _maxLength = 50;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initText);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  child: RoundedIconWidget(
                    iconData: Icons.check,
                    size: 30,
                    onTap: () {
                      context.pop<String?>(null);
                    },
                  ),
                ),
                Container(
                  width: context.width,
                  height: context.width,
                  decoration: BoxDecoration(
                      color: CustomPalette.darkGrey.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(20)),
                  child: AssetEntityImage(
                    widget.currentImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              child: TextField(
                controller: _controller,
                minLines: 1,
                maxLines: 5,
                maxLength: _maxLength,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Caption'),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: RoundedIconWidget(
        iconData: Icons.check,
        size: 30,
        onTap: () {
          context.pop<String?>(_controller.text.trim());
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
