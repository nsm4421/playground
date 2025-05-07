import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:travel/core/abstract/abstract.dart';
import 'package:travel/core/constant/constant.dart';
import 'package:travel/core/di/dependency_injection.dart';
import 'package:travel/core/util/bloc/display_bloc.dart';
import 'package:travel/core/util/extension/extension.dart';
import 'package:travel/core/util/snackbar/snackbar.dart';
import 'package:travel/domain/entity/comment/comment.dart';
import 'package:travel/presentation/bloc/comment/create/cubit.dart';
import 'package:travel/presentation/bloc/comment/display/bloc.dart';
import '../../core/theme/theme.dart';

part 'atom/divider.dart';

part 'atom/loading.dart';

part 'atom/button.dart';

part 'atom/image.dart';

part 'atom/text.dart';

part 'component/create_comment.dart';

part 'component/display_comment.dart';
