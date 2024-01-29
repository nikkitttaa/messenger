import 'package:flutter/material.dart';
import 'package:messanger_test/components/my_button.dart';
import 'package:messanger_test/components/my_text_field.dart';
import 'package:messanger_test/services/auth/auth_service.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  final void Function()? onTap;
  const LoginScreen({super.key, required this.onTap});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void signIn() async {
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.signInWithEmailAndPawword(
          emailController.text, passwordController.text);
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
              MyButton(onTap: signIn, btnText: 'Sign In'),

              const SizedBox(
                height: 50,
              ),
              //go to Sign Up screen
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('no accaunt? '),
                  GestureDetector(
                    onTap: widget.onTap,
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
