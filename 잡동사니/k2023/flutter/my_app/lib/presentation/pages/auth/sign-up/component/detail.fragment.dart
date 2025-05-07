import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/presentation/pages/auth/sign-up/bloc/sign_up.bloc.dart';
import 'package:my_app/presentation/pages/auth/sign-up/bloc/sign_up.state.dart';
import 'package:my_app/presentation/pages/auth/sign-up/component/introduce_textfield.widget.dart';
import 'package:my_app/presentation/pages/auth/sign-up/component/select_age.widget.dart';
import 'package:my_app/presentation/pages/auth/sign-up/component/select_sex.widget.dart';

class DetailFragment extends StatefulWidget {
  const DetailFragment({super.key});

  @override
  State<DetailFragment> createState() => _DetailFragmentState();
}

class _DetailFragmentState extends State<DetailFragment> {
  late TextEditingController _description;

  static const double _horizontalPadding = 15;

  @override
  void initState() {
    super.initState();
    _description = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _description.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<SignUpBloc, SignUpState>(
        builder: (_, state) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: _horizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 50),
              Text("Who Am I?",
                  style: GoogleFonts.lobsterTwo(
                      fontSize: 50, fontWeight: FontWeight.bold)),
              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(height: 10),
              SelectSexWidget(state),
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 10),
              SelectAgeWidget(state),
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 10),
              IntroduceTextFieldWidget(state),
            ],
          ),
        ),
      );
}
