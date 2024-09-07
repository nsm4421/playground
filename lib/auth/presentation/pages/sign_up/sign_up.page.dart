import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:flutter_app/shared/shared.export.dart';

import '../../blocs/auth/sign_up/sign_up.cubit.dart';

part 'sign_up.screen.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => getIt<SignUpCubit>(),
        child: BlocListener<SignUpCubit, SignUpState>(
            listener: (context, state) {
              switch (state.status) {
                // TODO : 회원가입 완료 처리, 오류 처리
                case SignUpStatus.success:
                case SignUpStatus.dupliacatedUsername:
                case SignUpStatus.networkError:
                case SignUpStatus.error:
                default:
                  return;
              }
            },
            child: const SignUpScreen()));
  }
}
