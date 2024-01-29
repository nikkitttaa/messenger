// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:messanger_test/components/my_button.dart';
import 'package:messanger_test/components/my_text_field.dart';
import 'package:messanger_test/services/auth/auth_service.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  final void Function()? onTap;

  const RegisterScreen({super.key, required this.onTap});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  void signUp() async {
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Пароли не совпадают!')));
    }

    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.signUpWithEmailAndPassword(emailController.text,
          passwordController.text, usernameController.text);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //logo
              const Icon(
                Icons.message,
                size: 100,
                color: Colors.green,
              ),

              const SizedBox(
                height: 100,
              ),
              //login field
              MyTextField(
                  controller: usernameController,
                  hintText: 'enter username',
                  obsecureText: false),

              //emailfield
              MyTextField(
                  controller: emailController,
                  hintText: 'enter email',
                  obsecureText: false),

              //password field
              MyTextField(
                  controller: passwordController,
                  hintText: 'enter password',
                  obsecureText: true),

              //confirm password field
              MyTextField(
                  controller: confirmPasswordController,
                  hintText: 'confirm password',
                  obsecureText: true),

              const SizedBox(
                height: 50,
              ),

              //button Sign Up
              MyButton(onTap: signUp, btnText: 'Sign Up'),

              const SizedBox(
                height: 50,
              ),

              //go to Sign In screen
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('have an account? '),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      'Login now',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
