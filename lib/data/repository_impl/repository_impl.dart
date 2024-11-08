import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:travel/data/datasource/database/feed/datasource.dart';
import 'package:travel/data/model/feed/create.dart';
import 'package:travel/data/model/feed/update.dart';
import 'package:travel/domain/entity/feed/feed.dart';

import '../../core/util/logger/logger.dart';
import '../../domain/entity/auth/presence.dart';
import '../../domain/repository/repository.dart';
import '../datasource/auth/datasource.dart';
import '../datasource/storage/datasource.dart';
import '../model/error/error_response.dart';

part 'auth.dart';

part 'feed.dart';
