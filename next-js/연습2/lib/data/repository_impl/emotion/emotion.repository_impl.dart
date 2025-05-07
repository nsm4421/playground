import 'package:injectable/injectable.dart';
import 'package:portfolio/data/model/emotion/emotion.model.dart';
import 'package:portfolio/domain/entity/emotion/emotion.entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/constant/response_wrapper.dart';
import '../../../core/util/exception.util.dart';
import '../../datasource/remote/emotion/impl/emotion.remote_datasource_impl.dart';

part '../../../domain/repository/emotion/emotion.repository.dart';

@LazySingleton(as: EmotionRepository)
class EmotionRepositoryImpl implements EmotionRepository {
  final EmotionRemoteDataSource _dataSource;

  EmotionRepositoryImpl(this._dataSource);

  @override
  Future<ResponseWrapper<void>> deleteEmotionById(String id) async {
    try {
      return await _dataSource
          .deleteEmotionById(id)
          .then((_) => ResponseWrapper.success(null));
    } catch (error) {
      throw CustomException.from(error);
    }
  }

  @override
  Future<ResponseWrapper<EmotionEntity>> upsertEmotion(
      EmotionEntity entity) async {
    try {
      return await _dataSource
          .upsertEmotion(EmotionModel.fromEntity(entity))
          .then(EmotionEntity.fromModel)
          .then(ResponseWrapper.success);
    } catch (error) {
      throw CustomException.from(error);
    }
  }

  @override
  RealtimeChannel getEmotionChannel(
      {void Function(EmotionEntity newModel)? onInsert,
      void Function(EmotionEntity oldModel, EmotionEntity newModel)? onUpdate,
      void Function(EmotionEntity oldModel)? onDelete}) {
    try {
      return _dataSource.getEmotionChannel(
        onInsert: onInsert == null
            ? null
            : (EmotionModel model) {
                onInsert(EmotionEntity.fromModel(model));
              },
        onUpdate: onUpdate == null
            ? null
            : (EmotionModel oldModel, EmotionModel newModel) {
                onUpdate(EmotionEntity.fromModel(oldModel),
                    EmotionEntity.fromModel(newModel));
              },
        onDelete: onDelete == null
            ? null
            : (EmotionModel model) {
                onDelete(EmotionEntity.fromModel(model));
              },
      );
    } catch (error) {
      throw CustomException.from(error);
    }
  }
}
