import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:my_app/data/entity/short/short.entity.dart';
import 'package:my_app/presentation/bloc/short/upload/upload_short.state.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/constant/status.dart';
import '../../../../domain/usecase/module/short/short.usecase.dart';

@lazySingleton
class UploadShortCubit extends Cubit<UploadShortState> {
  final ShortUseCase _useCase;

  UploadShortCubit(this._useCase) : super(const UploadShortState());

  void initState() {
    emit(state.copyWith(status: Status.initial));
  }

  Future<void> uploadShort(
      {required String title,
      required String content,
      required File video}) async {
    try {
      final id = (const Uuid()).v4();
      emit(state.copyWith(
          title: title,
          content: content,
          video: video,
          status: Status.loading));

      // 동영상 업로드
      await _useCase.uploadVideo(id: id, video: video).then(
          (res) => res.fold((l) => throw l.toCustomException(), (r) => r));

      // 동영상 다운로드 url
      final shortUrl = await _useCase.getShortUrl(id).then(
          (res) => res.fold((l) => throw l.toCustomException(), (r) => r));

      // 동영상 정보 저장
      await _useCase
          .saveShort(ShortEntity(
              id: id, title: title, content: content, shortUrl: shortUrl))
          .then((res) => res.fold(
              (l) => emit(state.copyWith(
                  status: Status.error,
                  errorMessage: l.message ?? 'Upload Fil')),
              (r) => emit(state.copyWith(status: Status.success))));
    } catch (error) {
      emit(state.copyWith(status: Status.error));
    }
  }
}
