part of '../../../export.pages.dart';

enum CreateFeedStep {
  selectMedia(iconData: Icons.enhance_photo_translate_outlined),
  editContent(iconData: Icons.edit_outlined),
  editMeta(iconData: Icons.tag);

  final IconData iconData;

  const CreateFeedStep({required this.iconData});
}

class CreateFeedScreen extends StatefulWidget {
  const CreateFeedScreen({super.key});

  @override
  State<CreateFeedScreen> createState() => _CreateFeedScreenState();
}

class _CreateFeedScreenState extends State<CreateFeedScreen> {
  static const double _stepBarHeight = 80;
  late PageController _controller;
  late CreateFeedStep _currentStep;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
    _currentStep = CreateFeedStep.values.first;
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  _onTapStepper(int index) async {
    setState(() {
      _currentStep = CreateFeedStep.values[index];
    });
    await _controller.animateToPage(index,
        duration: 500.ms, curve: Curves.easeInSine);
  }

  _handleGoBack() {
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:
            IconButton(onPressed: _handleGoBack, icon: const Icon(Icons.clear)),
        title: const Text('Create Feed'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(_stepBarHeight),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 80),
            child: Stepper(
              type: StepperType.horizontal,
              currentStep: _currentStep.index,
              onStepTapped: (index) {
                _onTapStepper(index);
              },
              controlsBuilder: (context, details) => const SizedBox.shrink(),
              steps: List.generate(CreateFeedStep.values.length, (index) {
                final item = CreateFeedStep.values[index];

                return Step(
                    title: _currentStep.index == index
                        ? Icon(item.iconData,
                            color: context.colorScheme.primary)
                        : const SizedBox.shrink(),
                    content: const SizedBox.shrink(),
                    isActive: _currentStep.index == index,
                    state: _currentStep.index > index
                        ? StepState.complete
                        : StepState.indexed);
              }).toList(),
            ),
          ),
        ),
      ),
      body: PageView.builder(
          controller: _controller,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: CreateFeedStep.values.length,
          itemBuilder: (context, index) {
            switch (index) {
              case 0:
                return const SelectImageFragment();
              case 1:
                return const EditContentFragment();
              default:
                return const EditMetaDataFragment();
            }
          }),
    );
  }
}
