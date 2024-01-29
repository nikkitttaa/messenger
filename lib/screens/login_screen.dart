import 'package:flutter/material.dart';
import 'package:messanger_test/components/my_button.dart';
import 'package:messanger_test/components/my_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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

              const SizedBox(
                height: 50,
              ),
              //button Sign In
              MyButton(onTap: () {}, btnText: 'Sign In'),

              const SizedBox(
                height: 50,
              ),
              //go to Sign Up screen
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('no accaunt? '),
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      'Register now',
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
