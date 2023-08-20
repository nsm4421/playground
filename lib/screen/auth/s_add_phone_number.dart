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
      return showAlertDialogWidget(
        context: context,
        message: "전화번호를 입력해주세요!",
      );
    }
    if (phoneNumber.length < 9) {
      return showAlertDialogWidget(
        context: context,
        message: '전화번호는 최소 9글자여야 합니다!',
      );
    }
    // SMS 인증
    ref.read(authControllerProvider).sendSmsCode(
        context: context, phoneNumber: '+$countryCode$phoneNumber');
  }

  _handleVerifySmsCode() {}

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

  // 뒤로가기(Welcome page로)
  void _handleGoBack(BuildContext context) =>
    Navigator.pop(context, false);


  @override
  Widget build(BuildContext context) {
    const double fontSizeLg = 25;
    const double fontSizeMd = 18;
    const double marginSize2Xl = 35;
    const double marginSizeMd = 20;
    const double marginSizeSm = 10;

    return Scaffold(
      /// appbar
      appBar: AppBar(
        elevation: 0,
        leading: InkWell(
          onTap: (){
            _handleGoBack(context);
          },
          // onTap: _handleGoBack(context),
          child: const Icon(
            Icons.arrow_back_ios_new,
            size: fontSizeLg,
          ),
        ),
        title: Text(
          'PHONE',
          style: GoogleFonts.lobster(
            fontSize: fontSizeLg,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Height(height: marginSizeMd),

          /// header
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: marginSizeMd,
              vertical: marginSizeSm,
            ),
            child: Text(
              "전화번호를 입력해주세요",
              style: TextStyle(fontSize: fontSizeMd),
            ),
          ),
          const Height(height: marginSizeMd),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: marginSize2Xl,
            ),
            child: Row(
              children: [
                /// 국가 선택
                SizedBox(
                  width: 70,
                  child: CustomTextFieldWidget(
                    onTap: _handleShowCountryPicker,
                    controller: _countryCodeController,
                    prefixText: '+',
                    readOnly: true,
                  ),
                ),
                const SizedBox(width: marginSizeSm),

                /// 전화번호 text field
                Expanded(
                  child: CustomTextFieldWidget(
                    controller: _phoneNumberController,
                    hintText: 'phone number',
                    textAlign: TextAlign.left,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
          ),
          const Height(height: marginSizeMd)
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      /// next 버튼
      floatingActionButton: ElevatedButton(
          onPressed: _handleClickNextButton, child: const Text("NEXT")),
    );
  }
}
