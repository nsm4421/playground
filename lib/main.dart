import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:my_app/core/config/dependency_injection.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'presentation/view/home.screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // get environment variables
  await dotenv.load(fileName: 'assets/config/.env');
  final String? dbUrl = dotenv.env['DB_URL'];
  final String? anonKey = dotenv.env['ANON_KEY'];
  if (dbUrl == null || anonKey == null) {
    throw Exception('environment variable injection fail');
  }

  // connect to database
  await Supabase.initialize(url: dbUrl, anonKey: anonKey);

  // dependency injection
  configureDependencies();

  // run app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

