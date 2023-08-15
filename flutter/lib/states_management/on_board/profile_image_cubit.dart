import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImageCubit extends Cubit<File> {
  ProfileImageCubit() : super(null);
  final _imagePicker = ImagePicker();

  Future<void> getImage() async {
    PickedFile image = await _imagePicker.getImage(
        source: ImageSource.gallery, imageQuality: 50);
    if (image == null) return;
    emit(File(image.path));
  }
}
