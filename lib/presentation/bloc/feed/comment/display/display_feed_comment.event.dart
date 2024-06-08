part of '../feed_comment.bloc.dart';

@immutable
sealed class DisplayFeedCommentEvent {}

final class InitDisplayFeedCommentEvent extends DisplayFeedCommentEvent {}

final class FetchDisplayFeedCommentEvent extends DisplayFeedCommentEvent {
  final int _take;

  FetchDisplayFeedCommentEvent(this._take);
}
