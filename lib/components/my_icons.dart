import 'package:flutter/material.dart';
import 'package:messanger_test/components/colors.dart';

class MyIcons extends StatelessWidget {
  final dynamic icon;
  final void Function()? onTap;

  const MyIcons({super.key, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          padding: EdgeInsets.all(MediaQuery.sizeOf(context).width / 30),
          decoration: BoxDecoration(
              color: searchBGColor, borderRadius: BorderRadius.circular(15)),
          child: icon),
    );
  }
}
