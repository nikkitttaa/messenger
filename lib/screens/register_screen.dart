import 'package:flutter/material.dart';
import 'package:messanger_test/components/my_button.dart';
import 'package:messanger_test/components/my_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

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

              //confirm password field
              MyTextField(
                  controller: confirmPasswordController,
                  hintText: 'confirm password',
                  obsecureText: true),

              const SizedBox(
                height: 50,
              ),
              //button Sign In
              MyButton(onTap: () {}, btnText: 'Sign Up'),

              const SizedBox(
                height: 50,
              ),


              //go to Sign In screen
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('have an account? '),
                  GestureDetector(
                    onTap: () {},
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