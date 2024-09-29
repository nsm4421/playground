import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

part 'format.util.dart';

part 'logger.util.dart';

part 'media.util.dart';

class CustomUtil with CustomMediaUtil, CustomLoggerUtil, CustomFormatUtil {}

@lazySingleton
CustomUtil get customUtil => CustomUtil();
