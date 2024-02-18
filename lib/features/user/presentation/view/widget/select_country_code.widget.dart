import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dialog.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/material.dart';

class SelectCountryCodeWidget extends StatefulWidget {
  const SelectCountryCodeWidget(
      {super.key, required this.country, required this.setCountry});

  final Country country;
  final void Function(Country country) setCountry;

  @override
  State<SelectCountryCodeWidget> createState() =>
      _SelectCountryCodeWidgetState();
}

class _SelectCountryCodeWidgetState extends State<SelectCountryCodeWidget> {
  _showDialog() => showDialog(
      context: context, builder: (_) => _Dialog(setCountry: widget.setCountry));

  @override
  Widget build(BuildContext context) => ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 2),
        onTap: _showDialog,
        title: Container(
          height: 40,
          alignment: Alignment.center,
          decoration: const BoxDecoration(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              CountryPickerUtils.getDefaultFlagImage(widget.country),
              Text(" +${widget.country.phoneCode}"),
              const SizedBox(width: 10),
              Expanded(
                  child: Text(
                " ${widget.country.name}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )),
            ],
          ),
        ),
      );
}

class _Dialog extends StatefulWidget {
  const _Dialog({required this.setCountry});

  final void Function(Country country) setCountry;

  @override
  State<_Dialog> createState() => _DialogState();
}

class _DialogState extends State<_Dialog> {
  onValuePicked(Country country) => setState(() {
        widget.setCountry(country);
      });

  @override
  Widget build(BuildContext context) => CountryPickerDialog(
        titlePadding: const EdgeInsets.all(8.0),
        searchInputDecoration: const InputDecoration(
          hintText: "search by country code or name",
        ),
        isSearchable: true,
        title: Text(
          "Search Country Code",
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        onValuePicked: onValuePicked,
        itemBuilder: (Country country) => Container(
          height: 40,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            border: Border(),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CountryPickerUtils.getDefaultFlagImage(country),
              Text(" +${country.phoneCode}"),
              Expanded(
                  child: Text(
                " ${country.name}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )),
            ],
          ),
        ),
      );
}
