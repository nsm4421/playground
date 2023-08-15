import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_prj/screen/custom_design/colors.dart';

import '../../states_management/on_board/profile_image_cubit.dart';
import '../custom_design/theme.dart';

class ProfileUploadWidget extends StatelessWidget {
  final double _size = 100.0;

  const ProfileUploadWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _size,
      width: _size,
      child: Material(
        color: _color(context),
        borderRadius: BorderRadius.circular(128.0),
        child: InkWell(
          onTap: () async {
            await context.read<ProfileImageCubit>().getImage();
          },
          child: Stack(
            fit: StackFit.expand,
            children: [
              _circularAvatar(context, _size),
              _addIcon(_size),
            ],
          ),
        ),
      ),
    );
  }
}

Color _color(context) =>
    isLightTheme(context) ? const Color(0xFFF2F2F2) : Colors.black;

Color _iconColor(context) => isLightTheme(context) ? kIconLight : Colors.black;

Icon _personIcon(context, size) => Icon(
      Icons.person_outline_rounded,
      size: size * 0.8,
      color: _iconColor(context),
    );

Align _addIcon(size) => Align(
      alignment: Alignment.bottomRight,
      child: Icon(
        Icons.add_circle_outline_rounded,
        size: size * 0.3,
        color: kPrimary,
      ),
    );

ClipRRect _profileImage(context, size, state) => ClipRRect(
      borderRadius: BorderRadius.circular(size),
      child: Image.file(
        state,
        width: size,
        height: size,
        fit: BoxFit.fill,
      ),
    );

Widget _circularAvatar(BuildContext context, double size) {
  return CircleAvatar(
      backgroundColor: Colors.transparent,
      child: BlocBuilder<ProfileImageCubit, File>(builder: (context, state) {
        return state == null
            ? _personIcon(context, size)
            : _profileImage(context, size, state);
      }));
}
