import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final void Function()? onTap;
  final String btnText;

  const MyButton({super.key, required this.onTap, required this.btnText});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(MediaQuery.sizeOf(context).height / 90),
        margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.sizeOf(context).width / 5),
        decoration: BoxDecoration(
            color: Colors.green, borderRadius: BorderRadius.circular(12)),
        child: Center(
          child: Text(
            btnText,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
