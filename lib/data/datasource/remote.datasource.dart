import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

import 'auth/auth.datasource.dart';
import 'auth/auth.datasource.impl.dart';

@module
abstract class RemoteDataSource {
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();
  final _logger = Logger();

  @singleton
  RemoteAuthDataSource get auth => RemoteAuthDataSourceImpl(
      auth: _auth, googleSignIn: _googleSignIn, logger: _logger);
}
