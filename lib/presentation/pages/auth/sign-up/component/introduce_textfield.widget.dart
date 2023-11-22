import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/sign_up.bloc.dart';
import '../bloc/sign_up.event.dart';
import '../bloc/sign_up.state.dart';

class IntroduceTextFieldWidget extends StatefulWidget {
  const IntroduceTextFieldWidget(this.state, {super.key});

  final SignUpState state;

  @override
  State<IntroduceTextFieldWidget> createState() =>
      _IntroduceTextFieldWidgetState();
}

class _IntroduceTextFieldWidgetState extends State<IntroduceTextFieldWidget> {
  late TextEditingController _tec;

  @override
  initState() {
    super.initState();
    _tec = TextEditingController();
    _tec.text = widget.state.user.description;
  }

  @override
  dispose() {
    super.dispose();
    _tec.dispose();
  }

  _handleChange(String description) {
    context.read<SignUpBloc>().add(UpdateOnBoardStateEvent(widget.state.copyWith(
        user: widget.state.user.copyWith(description: description.trim()))));
  }

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text("자기소개", style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              onChanged: _handleChange,
              maxLength: 1000,
              minLines: 3,
              maxLines: 20,
              controller: _tec,
              decoration: InputDecoration(
                  hintText: "안녕하세요 \n 주말에 놀 사람 구해요",
                  counterStyle: const TextStyle(color: Colors.black),
                  filled: true,
                  fillColor: Colors.grey[100]),
            ),
          )
        ],
      );
}
