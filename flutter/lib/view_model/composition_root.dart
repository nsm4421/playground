import 'package:chat/chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_prj/screen/pages/on_board/on_board_page.dart';
import 'package:flutter_prj/service/image_upload_service.dart';
import 'package:flutter_prj/states_management/home/home_cubit.dart';
import 'package:flutter_prj/states_management/on_board/on_boarding_cubit.dart';
import 'package:flutter_prj/states_management/on_board/profile_image_cubit.dart';
import 'package:rethink_db_ns/rethink_db_ns.dart';

import '../screen/pages/home/home_page.dart';

class CompositionRoot {
  static RethinkDb _db;
  static Connection _connection;
  static IUserService _userService;

  static configure() async {
    _db = RethinkDb();
    _connection = await _db.connect(
      // 에뮬레이터는 host를 localhost지정하면 에러발생...
      host: '10.0.2.2',
      port: 28015,
    );
    _userService = UserService(_db, _connection);
  }

  static Widget composeOnBoardingUi() {
    ImageUploadService imageUploader =
        // 에뮬레이터는 host를 localhost지정하면 에러발생...
        ImageUploadService('http://10.0.2.2:3000/upload');
    OnBoardingCubit onBoardingCubit =
        OnBoardingCubit(_userService, imageUploader);
    ProfileImageCubit profileImageCubit = ProfileImageCubit();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => onBoardingCubit),
        BlocProvider(create: (BuildContext context) => profileImageCubit),
      ],
      child: const OnBoarding(),
    );
  }

  static Widget composeHomeUi() {
    HomeCubit homeCubit = HomeCubit(_userService);
    return MultiBlocProvider(
        providers: [BlocProvider(create: (BuildContext context) => homeCubit)],
        child: const Home());
  }
}
