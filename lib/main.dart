import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:messanger_test/firebase_options.dart';
import 'package:messanger_test/services/auth/auth_service.dart';
import 'package:messanger_test/services/auth/check_auth.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthService(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CheckAuth(),
    );
  }
}
