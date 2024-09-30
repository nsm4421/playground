part of '../index.page.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  Lang? _sourceLang;
  Lang? _targetLang;

  _handleSubmit() {
    if (_sourceLang == null || _targetLang == null) {
      return;
    } else if (_sourceLang?.lang.name == _targetLang?.lang.name) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Source언어와 Target언어가 동일합니다'),
        duration: Duration(seconds: 2),
      ));
      return;
    }
    context.read<ImageToTextBloc>().add(SettingLanguageEvent(
        sourceLang: _sourceLang!, targetLang: _targetLang!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('통역할 언어를 선택해주세요'),
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          // source 언어
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
            child: SelectLangWidget(
              label: 'Select Source Language',
              initialLang: _sourceLang,
              setLang: (Lang? lang) {
                _sourceLang = lang;
              },
            ),
          ),

          // target 언어
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
            child: SelectLangWidget(
              label: 'Select Target Language',
              initialLang: _targetLang,
              setLang: (Lang? lang) {
                _targetLang = lang;
              },
            ),
          )
        ])),

        // 제출 버튼
        floatingActionButton: FloatingActionButton(
          isExtended: true,
          onPressed: _handleSubmit,
          child: const Icon(Icons.chevron_right_rounded),
        ));
  }
}
