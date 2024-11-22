import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:travel/core/constant/constant.dart';
import 'package:travel/core/util/logger/logger.dart';
import 'package:travel/data/datasource/auth/datasource.dart';
import 'package:travel/data/datasource/database/comment/datasource.dart';
import 'package:travel/data/datasource/database/emotion/datasource.dart';
import 'package:travel/data/datasource/database/feed/datasource.dart';
import 'package:travel/data/datasource/database/reels/datasource.dart';
import 'package:travel/data/datasource/storage/datasource.dart';
import 'package:travel/data/model/comment/create.dart';
import 'package:travel/data/model/emotion/delete.dart';
import 'package:travel/data/model/emotion/edit.dart';
import 'package:travel/data/model/error/error_response.dart';
import 'package:travel/data/model/feed/create.dart';
import 'package:travel/data/model/feed/fetch.dart';
import 'package:travel/data/model/feed/update.dart';
import 'package:travel/data/model/reels/create.dart';
import 'package:travel/domain/entity/auth/presence.dart';
import 'package:travel/domain/entity/comment/comment.dart';
import 'package:travel/domain/entity/feed/feed.dart';
import 'package:travel/domain/entity/reels/reels.dart';
import 'package:travel/domain/repository/repository.dart';

part 'auth.dart';

part 'feed.dart';

part 'reels.dart';

part 'emotion.dart';

part 'comment.dart';
