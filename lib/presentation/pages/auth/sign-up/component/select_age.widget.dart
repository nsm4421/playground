import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/sign_up.bloc.dart';
import '../bloc/sign_up.event.dart';
import '../bloc/sign_up.state.dart';

class SelectAgeWidget extends StatefulWidget {
  const SelectAgeWidget(this.state, {super.key});

  final SignUpState state;

  @override
  State<SelectAgeWidget> createState() => _SelectAgeWidgetState();
}

class _SelectAgeWidgetState extends State<SelectAgeWidget> {
  _handleSelectBirthDay() => showDatePicker(
              context: context,
              initialDate: DateTime(1995),
              firstDate: DateTime(1995),
              lastDate: DateTime.now())
          .then((selectedDate) {
        context.read<SignUpBloc>().add(UpdateOnBoardStateEvent(widget.state
            .copyWith(
                user: widget.state.user.copyWith(birthday: selectedDate))));
      });

  _birthdayFormatting(DateTime? birthday) => birthday == null
      ? "생일 선택하기"
      : "${birthday.year}-${birthday.month.toString().padLeft(2, '0')}-${birthday.day.toString().padLeft(2, '0')}";

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("생일", style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(width: 30),
          ElevatedButton(
              onPressed: _handleSelectBirthDay,
              child: Text(
                _birthdayFormatting(widget.state.user.birthday),
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ))
        ],
      );
}
