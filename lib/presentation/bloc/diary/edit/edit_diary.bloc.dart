import 'dart:io';
import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:travel/domain/usecase/diary/usecase.dart';

import '../../../../core/constant/constant.dart';
import '../../../../core/util/util.dart';

part 'edit_diary.state.dart';

part 'edit_diary.event.dart';

@injectable
class EditDiaryBloc extends Bloc<EditDiaryEvent, EditDiaryState> {
  final String _id;
  final DiaryUseCase _useCase;

  String get id => _id;

  EditDiaryBloc(@factoryParam this._id, DiaryUseCase useCase)
      : _useCase = useCase,
        super(EditDiaryState()) {
    on<LoadDiaryEvent>(_onLoad); // TODO
    on<InitializeEvent>(_onInit);
    on<UpdateCaptionEvent>(_onUpdateCaption);
    on<UpdateImageEvent>(_onUpdateImage);
    on<AddPageEvent>(_onAddPage);
    on<DeletePageEvent>(_onDeletePage);
    on<MovePageEvent>(_onMovePage);
    on<MoveToMetaDataPage>(_onMoveToMetaDataPage);
    on<UpdateMetaDataEvent>(_onUpdateMetaData);
    on<SubmitDiaryEvent>(_onSubmit);
  }

  // TODO : edit모드인 경우 기존 데이터를 불러오기
  Future<void> _onLoad(
      LoadDiaryEvent event, Emitter<EditDiaryState> emit) async {
    try {
      if (state.update) {
        // TODO : 기존 게시글 불러와서 이미지를 File객체로 만들어 상태 업데이트
      }
      emit(state.copyWith(step: EditDiaryStep.editing, status: Status.initial));
    } on Exception catch (error) {
      emit(state.copyWith(
          status: Status.error, errorMessage: '기존 데이터 불러오는 중 오류 발생'));
      customUtil.logger.e(error);
    }
  }

  Future<void> _onInit(
      InitializeEvent event, Emitter<EditDiaryState> emit) async {
    try {
      emit(state.copyWith(status: event.status, step: event.step));
    } on Exception catch (error) {
      emit(state.copyWith(status: Status.error, errorMessage: '초기화 도중 에러 발생'));
      customUtil.logger.e(error);
    }
  }

  Future<void> _onUpdateCaption(
      UpdateCaptionEvent event, Emitter<EditDiaryState> emit) async {
    try {
      emit(state.copyWith(
          pages: state.pages
              .map((item) => item.index == event.index
                  ? item.copyWith(caption: event.caption)
                  : item)
              .toList()));
    } on Exception catch (error) {
      emit(state.copyWith(
          status: Status.error, errorMessage: '캡션 상태 업데이트 발생했습니다'));
      customUtil.logger.e(error);
    }
  }

  Future<void> _onUpdateImage(
      UpdateImageEvent event, Emitter<EditDiaryState> emit) async {
    try {
      emit(state.copyWith(
          pages: state.pages
              .map((item) => item.index == event.index
                  ? item.copyWithImage(event.image)
                  : item)
              .toList()));
    } on Exception catch (error) {
      emit(state.copyWith(
          status: Status.error, errorMessage: '이미지 상태 업데이트 발생했습니다'));
      customUtil.logger.e(error);
    }
  }

  Future<void> _onAddPage(
      AddPageEvent event, Emitter<EditDiaryState> emit) async {
    try {
      emit(state.copyWith(
          pages: [...state.pages, DiaryPage(index: state.pages.length)],
          currentIndex: state.currentIndex + 1));
    } on Exception catch (error) {
      emit(state.copyWith(
          status: Status.error, errorMessage: '페이지 추가 중 발생했습니다'));
      customUtil.logger.e(error);
    }
  }

  Future<void> _onDeletePage(
      DeletePageEvent event, Emitter<EditDiaryState> emit) async {
    try {
      assert(state.pages.length >= 2);
      final currentIndex = max(0, state.currentIndex - 1);
      final pages = state.pages
          .where((item) => item.index != state.currentIndex)
          .map((item) => item.index < state.currentIndex
              ? item
              : item.copyWith(index: item.index - 1))
          .toList();
      emit(state.copyWith(pages: pages, currentIndex: currentIndex));
    } on Exception catch (error) {
      emit(state.copyWith(
          status: Status.error, errorMessage: '페이지 추가 중 발생했습니다'));
      customUtil.logger.e(error);
    }
  }

  Future<void> _onMovePage(
      MovePageEvent event, Emitter<EditDiaryState> emit) async {
    try {
      emit(state.copyWith(currentIndex: event.page));
    } on Exception catch (error) {
      emit(state.copyWith(
          status: Status.error, errorMessage: '페이지 전환 중 에러가 발생했습니다'));
      customUtil.logger.e(error);
    }
  }

  Future<void> _onMoveToMetaDataPage(
      MoveToMetaDataPage event, Emitter<EditDiaryState> emit) async {
    try {
      // 이미지나 캡션이 첨부되지 않은 페이지 찾기
      final unNecessary = state.pages
          .where((item) => (item.image == null) && (item.caption.isEmpty))
          .map((item) => item.index)
          .firstOrNull;
      if (unNecessary == null) {
        emit(state.copyWith(
            status: Status.success, step: EditDiaryStep.metaData));
      } else {
        emit(state.copyWith(
            status: Status.error,
            step: EditDiaryStep.editing,
            currentIndex: unNecessary,
            errorMessage: '캡션이나 이미지가 빈 페이지가 있습니다'));
      }
    } on Exception catch (error) {
      emit(state.copyWith(
          status: Status.error, errorMessage: '메타데이터 페이지로 넘어가는 중 발생했습니다'));
      customUtil.logger.e(error);
    }
  }

  Future<void> _onUpdateMetaData(
      UpdateMetaDataEvent event, Emitter<EditDiaryState> emit) async {
    try {
      emit(state.copyWith(hashtags: event.hashtags, location: event.location));
    } on Exception catch (error) {
      emit(state.copyWith(
          status: Status.error, errorMessage: '페이지 전환 중 에러가 발생했습니다'));
      customUtil.logger.e(error);
    }
  }

  Future<void> _onSubmit(
      SubmitDiaryEvent event, Emitter<EditDiaryState> emit) async {
    try {
      emit(state.copyWith(
          step: EditDiaryStep.uploading, status: Status.loading));
      final res = await _useCase.edit.call(
          id: id,
          location: state.location,
          hashtags: state.hashtags,
          images: state.pages.map((item) => item.image).toList(),
          captions: state.pages.map((item) => item.caption).toList(),
          isPrivate: state.isPrivate,
          update: state.update);
      if (res.ok) {
        emit(state.copyWith(status: Status.success));
      } else {
        emit(state.copyWith(
            status: Status.error, errorMessage: '업로드 중 에러가 발생했습니다'));
      }
    } on Exception catch (error) {
      emit(state.copyWith(
          status: Status.error, errorMessage: '업로드 중 에러가 발생했습니다'));
      customUtil.logger.e(error);
    }
  }
}
