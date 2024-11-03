import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../core/constant/constant.dart';
import '../../core/util/logger/logger.dart';
import '../../domain/entity/auth/presence.dart';
import '../../domain/repository/repository.dart';
import '../datasource/auth/datasource.dart';
import '../datasource/storage/datasource.dart';
import '../model/error/error_response.dart';

part 'auth.repository_impl.dart';
