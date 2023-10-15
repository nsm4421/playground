// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return _UserModel.fromJson(json);
}

/// @nodoc
mixin _$UserModel {
  String? get email => throw _privateConstructorUsedError; // 이메일
  String? get password => throw _privateConstructorUsedError; // 비밀번호
  String? get nickname => throw _privateConstructorUsedError; // 닉네임
  int? get age => throw _privateConstructorUsedError; // 연령
  String? get phone => throw _privateConstructorUsedError; // 전화번호
  String? get city => throw _privateConstructorUsedError; // 도시
  String? get introduce => throw _privateConstructorUsedError; // 자기소개
  int? get height => throw _privateConstructorUsedError; // 몸무게
  String? get job => throw _privateConstructorUsedError; // 직업
  String? get ideal => throw _privateConstructorUsedError; // 이상형
  String? get profileImageUrl =>
      throw _privateConstructorUsedError; // 프로필 이미지 Url
  DateTime? get createdAt => throw _privateConstructorUsedError; // 생성시간
  DateTime? get modifiedAt => throw _privateConstructorUsedError; // 수정시간
  DateTime? get removedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserModelCopyWith<UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserModelCopyWith<$Res> {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) then) =
      _$UserModelCopyWithImpl<$Res, UserModel>;
  @useResult
  $Res call(
      {String? email,
      String? password,
      String? nickname,
      int? age,
      String? phone,
      String? city,
      String? introduce,
      int? height,
      String? job,
      String? ideal,
      String? profileImageUrl,
      DateTime? createdAt,
      DateTime? modifiedAt,
      DateTime? removedAt});
}

/// @nodoc
class _$UserModelCopyWithImpl<$Res, $Val extends UserModel>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = freezed,
    Object? password = freezed,
    Object? nickname = freezed,
    Object? age = freezed,
    Object? phone = freezed,
    Object? city = freezed,
    Object? introduce = freezed,
    Object? height = freezed,
    Object? job = freezed,
    Object? ideal = freezed,
    Object? profileImageUrl = freezed,
    Object? createdAt = freezed,
    Object? modifiedAt = freezed,
    Object? removedAt = freezed,
  }) {
    return _then(_value.copyWith(
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      nickname: freezed == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String?,
      age: freezed == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      introduce: freezed == introduce
          ? _value.introduce
          : introduce // ignore: cast_nullable_to_non_nullable
              as String?,
      height: freezed == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as int?,
      job: freezed == job
          ? _value.job
          : job // ignore: cast_nullable_to_non_nullable
              as String?,
      ideal: freezed == ideal
          ? _value.ideal
          : ideal // ignore: cast_nullable_to_non_nullable
              as String?,
      profileImageUrl: freezed == profileImageUrl
          ? _value.profileImageUrl
          : profileImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      modifiedAt: freezed == modifiedAt
          ? _value.modifiedAt
          : modifiedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      removedAt: freezed == removedAt
          ? _value.removedAt
          : removedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserModelImplCopyWith<$Res>
    implements $UserModelCopyWith<$Res> {
  factory _$$UserModelImplCopyWith(
          _$UserModelImpl value, $Res Function(_$UserModelImpl) then) =
      __$$UserModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? email,
      String? password,
      String? nickname,
      int? age,
      String? phone,
      String? city,
      String? introduce,
      int? height,
      String? job,
      String? ideal,
      String? profileImageUrl,
      DateTime? createdAt,
      DateTime? modifiedAt,
      DateTime? removedAt});
}

/// @nodoc
class __$$UserModelImplCopyWithImpl<$Res>
    extends _$UserModelCopyWithImpl<$Res, _$UserModelImpl>
    implements _$$UserModelImplCopyWith<$Res> {
  __$$UserModelImplCopyWithImpl(
      _$UserModelImpl _value, $Res Function(_$UserModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = freezed,
    Object? password = freezed,
    Object? nickname = freezed,
    Object? age = freezed,
    Object? phone = freezed,
    Object? city = freezed,
    Object? introduce = freezed,
    Object? height = freezed,
    Object? job = freezed,
    Object? ideal = freezed,
    Object? profileImageUrl = freezed,
    Object? createdAt = freezed,
    Object? modifiedAt = freezed,
    Object? removedAt = freezed,
  }) {
    return _then(_$UserModelImpl(
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      nickname: freezed == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String?,
      age: freezed == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      introduce: freezed == introduce
          ? _value.introduce
          : introduce // ignore: cast_nullable_to_non_nullable
              as String?,
      height: freezed == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as int?,
      job: freezed == job
          ? _value.job
          : job // ignore: cast_nullable_to_non_nullable
              as String?,
      ideal: freezed == ideal
          ? _value.ideal
          : ideal // ignore: cast_nullable_to_non_nullable
              as String?,
      profileImageUrl: freezed == profileImageUrl
          ? _value.profileImageUrl
          : profileImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      modifiedAt: freezed == modifiedAt
          ? _value.modifiedAt
          : modifiedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      removedAt: freezed == removedAt
          ? _value.removedAt
          : removedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserModelImpl implements _UserModel {
  const _$UserModelImpl(
      {this.email = '',
      this.password = '',
      this.nickname = '',
      this.age = -1,
      this.phone = '',
      this.city = '',
      this.introduce = '',
      this.height = -1,
      this.job = '',
      this.ideal = '',
      this.profileImageUrl = '',
      this.createdAt,
      this.modifiedAt,
      this.removedAt});

  factory _$UserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserModelImplFromJson(json);

  @override
  @JsonKey()
  final String? email;
// 이메일
  @override
  @JsonKey()
  final String? password;
// 비밀번호
  @override
  @JsonKey()
  final String? nickname;
// 닉네임
  @override
  @JsonKey()
  final int? age;
// 연령
  @override
  @JsonKey()
  final String? phone;
// 전화번호
  @override
  @JsonKey()
  final String? city;
// 도시
  @override
  @JsonKey()
  final String? introduce;
// 자기소개
  @override
  @JsonKey()
  final int? height;
// 몸무게
  @override
  @JsonKey()
  final String? job;
// 직업
  @override
  @JsonKey()
  final String? ideal;
// 이상형
  @override
  @JsonKey()
  final String? profileImageUrl;
// 프로필 이미지 Url
  @override
  final DateTime? createdAt;
// 생성시간
  @override
  final DateTime? modifiedAt;
// 수정시간
  @override
  final DateTime? removedAt;

  @override
  String toString() {
    return 'UserModel(email: $email, password: $password, nickname: $nickname, age: $age, phone: $phone, city: $city, introduce: $introduce, height: $height, job: $job, ideal: $ideal, profileImageUrl: $profileImageUrl, createdAt: $createdAt, modifiedAt: $modifiedAt, removedAt: $removedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserModelImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.age, age) || other.age == age) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.introduce, introduce) ||
                other.introduce == introduce) &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.job, job) || other.job == job) &&
            (identical(other.ideal, ideal) || other.ideal == ideal) &&
            (identical(other.profileImageUrl, profileImageUrl) ||
                other.profileImageUrl == profileImageUrl) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.modifiedAt, modifiedAt) ||
                other.modifiedAt == modifiedAt) &&
            (identical(other.removedAt, removedAt) ||
                other.removedAt == removedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      email,
      password,
      nickname,
      age,
      phone,
      city,
      introduce,
      height,
      job,
      ideal,
      profileImageUrl,
      createdAt,
      modifiedAt,
      removedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      __$$UserModelImplCopyWithImpl<_$UserModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserModelImplToJson(
      this,
    );
  }
}

abstract class _UserModel implements UserModel {
  const factory _UserModel(
      {final String? email,
      final String? password,
      final String? nickname,
      final int? age,
      final String? phone,
      final String? city,
      final String? introduce,
      final int? height,
      final String? job,
      final String? ideal,
      final String? profileImageUrl,
      final DateTime? createdAt,
      final DateTime? modifiedAt,
      final DateTime? removedAt}) = _$UserModelImpl;

  factory _UserModel.fromJson(Map<String, dynamic> json) =
      _$UserModelImpl.fromJson;

  @override
  String? get email;
  @override // 이메일
  String? get password;
  @override // 비밀번호
  String? get nickname;
  @override // 닉네임
  int? get age;
  @override // 연령
  String? get phone;
  @override // 전화번호
  String? get city;
  @override // 도시
  String? get introduce;
  @override // 자기소개
  int? get height;
  @override // 몸무게
  String? get job;
  @override // 직업
  String? get ideal;
  @override // 이상형
  String? get profileImageUrl;
  @override // 프로필 이미지 Url
  DateTime? get createdAt;
  @override // 생성시간
  DateTime? get modifiedAt;
  @override // 수정시간
  DateTime? get removedAt;
  @override
  @JsonKey(ignore: true)
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
