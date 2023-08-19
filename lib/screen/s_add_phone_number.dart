import 'package:chat_app/common/theme/colors.dart';
import 'package:chat_app/common/widget/w_show_dialog.dart';
import 'package:chat_app/common/widget/w_size.dart';
import 'package:chat_app/common/widget/w_text_feild.dart';
import 'package:chat_app/controller/auth_controller.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class AddPhoneNumberScreen extends ConsumerStatefulWidget {
  const AddPhoneNumberScreen({super.key});

  @override
  ConsumerState<AddPhoneNumberScreen> createState() =>
      _AddPhoneNumberScreenState();
}

class _AddPhoneNumberScreenState extends ConsumerState<AddPhoneNumberScreen> {
  late TextEditingController _countryNameController;
  late TextEditingController _countryCodeController;
  late TextEditingController _phoneNumberController;
  final _colors =
      (ThemeMode.system == ThemeMode.light) ? LightColors() : DarkColors();

  @override
  void initState() {
    _countryNameController = TextEditingController(text: 'South Korea');
    _countryCodeController = TextEditingController(text: '82');
    _phoneNumberController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _countryNameController.dispose();
    _countryCodeController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  _handleClickNextButton() {
    final phoneNumber = _phoneNumberController.text;
    final countryName = _countryNameController.text;
    final countryCode = _countryCodeController.text;

    if (phoneNumber.isEmpty) {
      return showAlertDialog(
        context: context,
        message: "전화번호를 입력해주세요!",
      );
    }
    if (phoneNumber.length < 9) {
      return showAlertDialog(
        context: context,
        message: '전화번호는 최소 9글자여야 합니다!',
      );
    }
    // SMS 인증
    ref
        .read(authControllerProvider)
        .sendSmsCode(context: context, phoneNumber: '+$countryCode$phoneNumber');
  }

  _handleVerifySmsCode(){

  }

  _handleShowCountryPicker() {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      favorite: ['KR'],
      countryListTheme: CountryListThemeData(
        bottomSheetHeight: 600,
        flagSize: 22,
        borderRadius: BorderRadius.circular(20),
        inputDecoration: const InputDecoration(
          prefixIcon: Icon(
            Icons.language,
          ),
          hintText: '사용 국가를 선택해주세요',
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(),
          ),
        ),
      ),
      onSelect: (country) {
        _countryNameController.text = country.name;
        _countryCodeController.text = country.phoneCode;
      },
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      title: Text(
        'PHONE',
        style: GoogleFonts.lobster(fontSize: 25, color: _colors.grey),
      ),
      centerTitle: true,
    );
  }

  Widget _header() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        "전화번호를 등록해주세요",
      ),
    );
  }

  Widget _phoneNumberFragment() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Row(
        children: [
          SizedBox(
            width: 70,
            child: CustomTextField(
              onTap: _handleShowCountryPicker,
              controller: _countryCodeController,
              prefixText: '+',
              readOnly: true,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: CustomTextField(
              controller: _phoneNumberController,
              hintText: 'phone number',
              textAlign: TextAlign.left,
              keyboardType: TextInputType.number,
            ),
          ),
        ],
      ),
    );
  }

  Widget _floatingActionButton() {
    return ElevatedButton(
        onPressed: _handleClickNextButton, child: const Text("NEXT"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Column(
        children: [
          const Height(height: 20),
          _header(),
          const Height(height: 20),
          _phoneNumberFragment(),
          const Height(height: 20)
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _floatingActionButton(),
    );
  }
}
