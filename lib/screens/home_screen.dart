import 'package:flutter/material.dart';
import 'package:messanger_test/services/auth/auth_service.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void signOut() {
    final authService = Provider.of<AuthService>(context, listen: false);

    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Чаты',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          //signOut button
          IconButton(
              onPressed: signOut,
              icon: const Icon(
                Icons.logout,
                color: Colors.black,
              ))
        ],
      ),
    );
  }
}
