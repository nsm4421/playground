import 'dart:io';

import 'package:flutter_app/reels/data/dto/edit_reels.dto.dart';
import 'package:flutter_app/reels/reels.export.dart';
import 'package:injectable/injectable.dart';

import '../../../shared/shared.export.dart';
import '../../domain/entity/reels.entity.dart';
import '../dto/create_reels.dto.dart';

part 'repository.dart';

@LazySingleton(as: ReelsRepository)
class ReelsRepositoryImpl extends ReelsRepository {
  final ReelsDataSource _reelsDataSource;
  final StorageDataSource _storageDataSource;

  ReelsRepositoryImpl(
      {required ReelsDataSource reelsDataSource,
      required StorageDataSource storageDataSource})
      : _reelsDataSource = reelsDataSource,
        _storageDataSource = storageDataSource;

  @override
  Future<RepositoryResponseWrapper<void>> createReels(
      {required String reelsId,
      required String media,
      required String caption}) async {
    try {
      return await _reelsDataSource
          .createReels(
              CreateReelsDto(id: reelsId, media: media, caption: caption))
          .then(RepositorySuccess<void>.from);
    } on Exception catch (error) {
      return RepositoryError<void>.from(error);
    }
  }

  @override
  Future<RepositoryResponseWrapper<void>> deleteReelsById(
      String reelsId) async {
    try {
      return await _reelsDataSource
          .deleteReelsById(reelsId)
          .then(RepositorySuccess<void>.from);
    } on Exception catch (error) {
      return RepositoryError<void>.from(error);
    }
  }

  @override
  Future<RepositoryResponseWrapper<void>> editReels(
      {required String reelsId, String? media, String? caption}) async {
    try {
      return await _reelsDataSource
          .editReels(EditReelsDto(id: reelsId, media: media, caption: caption))
          .then(RepositorySuccess<void>.from);
    } on Exception catch (error) {
      return RepositoryError<void>.from(error);
    }
  }

  @override
  Future<RepositoryResponseWrapper<List<ReelsEntity>>> fetchReels(
      {required DateTime beforeAt, int limit = 5}) async {
    try {
      return await _reelsDataSource
          .fetchReels(beforeAt: beforeAt, limit: limit)
          .then((res) => res.map(ReelsEntity.from).toList())
          .then(RepositorySuccess<List<ReelsEntity>>.from);
    } on Exception catch (error) {
      return RepositoryError<List<ReelsEntity>>.from(error);
    }
  }

  @override
  Future<RepositoryResponseWrapper<String>> uploadReelsVideo(File video,
      {bool upsert = false}) async {
    try {
      return await _storageDataSource
          .uploadImage(
              file: video, bucketName: Buckets.reels.name, upsert: upsert)
          .then(RepositorySuccess<String>.from);
    } on Exception catch (error) {
      return RepositoryError<String>.from(error);
    }
  }
}
