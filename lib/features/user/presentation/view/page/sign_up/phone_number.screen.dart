import 'package:country_pickers/country.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hot_place/features/user/presentation/view/widget/select_country_code.widget.dart';


class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({super.key});

  @override
  State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  static const String _defaultCountryCode = "82";

  Country _currentCountry =
      CountryPickerUtils.getCountryByPhoneCode(_defaultCountryCode);

  final TextEditingController _phoneTextEditingController =
      TextEditingController();

  _setCurrentCountry(Country country) => setState(() {
        _currentCountry = country;
      });

  _goToOtpPage() => () {};

  _clearText() => _phoneTextEditingController.clear();

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text("전화번호 인증"),
        centerTitle: true,
      ),
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
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("-없이 전화번호를 입력해주세요",
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(color: Colors.grey)),
              TextField(
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                  controller: _phoneTextEditingController,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: _clearText, icon: const Icon(Icons.clear)),
                      hintText: "010-0000-0000",
                      border: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      )))
            ]))
      ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
          onPressed: _goToOtpPage,
          label: Text(
            "NEXT",
            style: Theme.of(context)
                .textTheme
                .labelLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          )));
}
