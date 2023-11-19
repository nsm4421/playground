import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constant/enums/sign_up.enum.dart';
import '../bloc/sign_up.bloc.dart';
import '../bloc/sign_up.event.dart';
import '../bloc/sign_up.state.dart';

class SelectSexWidget extends StatefulWidget {
  const SelectSexWidget(this.state, {super.key});

  final SignUpState state;

  @override
  State<SelectSexWidget> createState() => _SexWidgetState();
}

class _SexWidgetState extends State<SelectSexWidget> {
  Sex? _sex;

  @override
  initState() {
    super.initState();
    setState(() {
      _sex = widget.state.user.sex;
    });
  }

  _handleSelectSex(Sex sex) => () {
        _sex = (_sex == sex ? null : sex);
        context.read<SignUpBloc>().add(UpdateUserStateEvent(widget.state
            .copyWith(user: widget.state.user.copyWith(sex: _sex))));
        setState(() {});
      };

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("성별", style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(width: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: _sex == Sex.male
                          ? Colors.blueAccent[100]
                          : Colors.grey[100]),
                  onPressed: _handleSelectSex(Sex.male),
                  child: const Row(
                    children: [
                      Icon(Icons.male_rounded),
                      SizedBox(width: 20),
                      Text("남자",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          )),
                    ],
                  )),
              const SizedBox(width: 15),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: _sex == Sex.female
                          ? Colors.redAccent[100]
                          : Colors.grey[100]),
                  onPressed: _handleSelectSex(Sex.female),
                  child: const Row(
                    children: [
                      Icon(Icons.female_rounded),
                      SizedBox(width: 20),
                      Text("여자",
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 18)),
                    ],
                  )),
            ],
          ),
        ],
      );
}
