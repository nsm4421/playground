part of '../export.datasource.dart';

abstract interface class FeedRemoteDataSource {

  Future<void> create({required List<File> files, required CreateFeedDto dto});

  Future<void> modify({required List<File> files,required ModifyFeedDto dto});

  Future<void> delete(int id);
}
