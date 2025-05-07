// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feed_comment.state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$FeedCommentState {
  Status get status => throw _privateConstructorUsedError;
  String get feedId => throw _privateConstructorUsedError;
  List<FeedCommentModel> get comments => throw _privateConstructorUsedError;
  ErrorResponse get error => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FeedCommentStateCopyWith<FeedCommentState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeedCommentStateCopyWith<$Res> {
  factory $FeedCommentStateCopyWith(
          FeedCommentState value, $Res Function(FeedCommentState) then) =
      _$FeedCommentStateCopyWithImpl<$Res, FeedCommentState>;
  @useResult
  $Res call(
      {Status status,
      String feedId,
      List<FeedCommentModel> comments,
      ErrorResponse error});
}

/// @nodoc
class _$FeedCommentStateCopyWithImpl<$Res, $Val extends FeedCommentState>
    implements $FeedCommentStateCopyWith<$Res> {
  _$FeedCommentStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? feedId = null,
    Object? comments = null,
    Object? error = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as Status,
      feedId: null == feedId
          ? _value.feedId
          : feedId // ignore: cast_nullable_to_non_nullable
              as String,
      comments: null == comments
          ? _value.comments
          : comments // ignore: cast_nullable_to_non_nullable
              as List<FeedCommentModel>,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as ErrorResponse,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FeedCommentStateImplCopyWith<$Res>
    implements $FeedCommentStateCopyWith<$Res> {
  factory _$$FeedCommentStateImplCopyWith(_$FeedCommentStateImpl value,
          $Res Function(_$FeedCommentStateImpl) then) =
      __$$FeedCommentStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Status status,
      String feedId,
      List<FeedCommentModel> comments,
      ErrorResponse error});
}

/// @nodoc
class __$$FeedCommentStateImplCopyWithImpl<$Res>
    extends _$FeedCommentStateCopyWithImpl<$Res, _$FeedCommentStateImpl>
    implements _$$FeedCommentStateImplCopyWith<$Res> {
  __$$FeedCommentStateImplCopyWithImpl(_$FeedCommentStateImpl _value,
      $Res Function(_$FeedCommentStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? feedId = null,
    Object? comments = null,
    Object? error = null,
  }) {
    return _then(_$FeedCommentStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as Status,
      feedId: null == feedId
          ? _value.feedId
          : feedId // ignore: cast_nullable_to_non_nullable
              as String,
      comments: null == comments
          ? _value._comments
          : comments // ignore: cast_nullable_to_non_nullable
              as List<FeedCommentModel>,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as ErrorResponse,
    ));
  }
}

/// @nodoc

class _$FeedCommentStateImpl
    with DiagnosticableTreeMixin
    implements _FeedCommentState {
  const _$FeedCommentStateImpl(
      {this.status = Status.initial,
      this.feedId = '',
      final List<FeedCommentModel> comments = const <FeedCommentModel>[],
      this.error = const ErrorResponse()})
      : _comments = comments;

  @override
  @JsonKey()
  final Status status;
  @override
  @JsonKey()
  final String feedId;
  final List<FeedCommentModel> _comments;
  @override
  @JsonKey()
  List<FeedCommentModel> get comments {
    if (_comments is EqualUnmodifiableListView) return _comments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_comments);
  }

  @override
  @JsonKey()
  final ErrorResponse error;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FeedCommentState(status: $status, feedId: $feedId, comments: $comments, error: $error)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'FeedCommentState'))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('feedId', feedId))
      ..add(DiagnosticsProperty('comments', comments))
      ..add(DiagnosticsProperty('error', error));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FeedCommentStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.feedId, feedId) || other.feedId == feedId) &&
            const DeepCollectionEquality().equals(other._comments, _comments) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status, feedId,
      const DeepCollectionEquality().hash(_comments), error);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FeedCommentStateImplCopyWith<_$FeedCommentStateImpl> get copyWith =>
      __$$FeedCommentStateImplCopyWithImpl<_$FeedCommentStateImpl>(
          this, _$identity);
}

abstract class _FeedCommentState implements FeedCommentState {
  const factory _FeedCommentState(
      {final Status status,
      final String feedId,
      final List<FeedCommentModel> comments,
      final ErrorResponse error}) = _$FeedCommentStateImpl;

  @override
  Status get status;
  @override
  String get feedId;
  @override
  List<FeedCommentModel> get comments;
  @override
  ErrorResponse get error;
  @override
  @JsonKey(ignore: true)
  _$$FeedCommentStateImplCopyWith<_$FeedCommentStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
