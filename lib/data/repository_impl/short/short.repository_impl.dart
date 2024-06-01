import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:fpdart/src/either.dart';
import 'package:injectable/injectable.dart';
import 'package:my_app/core/exception/failure.dart';
import 'package:my_app/data/entity/short/short.entity.dart';
import 'package:my_app/domain/model/short/short.model.dart';
import 'package:my_app/domain/repository/short/short.repository.dart';

import '../../../core/exception/custom_exeption.dart';
import '../../datasource/short/short.datasource.dart';

@LazySingleton(as: ShortRepository)
class ShortRepositoryImpl implements ShortRepository {
  final RemoteShortDataSource _remoteDataSource;

  ShortRepositoryImpl({required RemoteShortDataSource remoteDataSource})
      : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, void>> saveShort(ShortEntity entity) async {
    try {
      return await _remoteDataSource
          .saveShort(ShortModel.fromEntity(entity))
          .then(right);
    } on CustomException catch (error) {
      return left(Failure(code: error.code, message: error.message));
    }
  }

  @override
  Future<Either<Failure, String>> getShortDownloadUrl(String id) async {
    try {
      return await _remoteDataSource.getShortDownloadUrl(id).then(right);
    } on CustomException catch (error) {
      return left(Failure(code: error.code, message: error.message));
    }
  }

  @override
  Future<Either<Failure, void>> saveVideo(
      {required id, required File video}) async {
    try {
      return await _remoteDataSource
          .saveVideo(id: id, video: video)
          .then(right);
    } on CustomException catch (error) {
      return left(Failure(code: error.code, message: error.message));
    }
  }
}
