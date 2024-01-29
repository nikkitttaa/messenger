import 'package:flutter/material.dart';
import 'package:messanger_test/screens/login_screen.dart';
import 'package:messanger_test/screens/register_screen.dart';

class Landing extends StatefulWidget {
  const Landing({super.key});

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  bool showLoginPage = true;

  void toggleScreens() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage == true) {
      return LoginScreen(onTap: toggleScreens);
    } else {
      return RegisterScreen(onTap: toggleScreens);
    }
  }
}
