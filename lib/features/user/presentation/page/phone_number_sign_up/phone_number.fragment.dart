import 'package:country_pickers/country.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hot_place/features/app/util/toast.util.dart';
import 'package:hot_place/features/user/presentation/bloc/phone_sign_up/sign_up.bloc.dart';
import 'package:hot_place/features/user/presentation/component/select_country_code.widget.dart';

import '../../bloc/phone_sign_up/sign_up.event.dart';

class PhoneNumberFragment extends StatefulWidget {
  const PhoneNumberFragment({super.key});

  @override
  State<PhoneNumberFragment> createState() => _PhoneNumberFragmentState();
}

class _PhoneNumberFragmentState extends State<PhoneNumberFragment> {
  static const String _defaultCountryCode = "82";
  late TextEditingController _phoneTextEditingController;
  late Country _currentCountry;

  @override
  void initState() {
    super.initState();
    _phoneTextEditingController = TextEditingController();
    _currentCountry =
        CountryPickerUtils.getCountryByPhoneCode(_defaultCountryCode);
  }

  @override
  dispose() {
    super.dispose();
    _phoneTextEditingController.dispose();
  }

  _setCurrentCountry(Country country) => setState(() {
        _currentCountry = country;
      });

  _clearText() => _phoneTextEditingController.clear();

  // OTP페이지로 이동
  _handleGoNext() {
    try {
      debugPrint(
          '+${_currentCountry.phoneCode}${_phoneTextEditingController.text}');
      context.read<SignUpBloc>().add(VerifyPhoneNumber(
          "+${_currentCountry.phoneCode}${_phoneTextEditingController.text}"));
    } catch (err) {
      ToastUtil.toast('전화번호 인증에 실패하였습니다');
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Column(children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("국가를 선택해주세요",
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(color: Colors.grey)),
                SelectCountryCodeWidget(
                    country: _currentCountry, setCountry: _setCurrentCountry),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("-없이 전화번호를 입력해주세요",
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(color: Colors.grey)),
                    TextField(
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(11),
                        ],
                        controller: _phoneTextEditingController,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: _clearText,
                                icon: const Icon(Icons.clear)),
                            hintText: "010-0000-0000",
                            border: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            )))
                  ]))
        ]),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
            onPressed: _handleGoNext,
            label: Text(
              "NEXT",
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(fontWeight: FontWeight.w700),
            )),
      );
}
