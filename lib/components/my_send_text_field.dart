import 'package:flutter/material.dart';
import 'package:messanger_test/components/colors.dart';

class MySendTextField extends StatelessWidget {
  final TextEditingController controller;

  const MySendTextField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      padding: EdgeInsets.only(left: MediaQuery.sizeOf(context).width / 20),
      decoration: BoxDecoration(
          color: searchBGColor, borderRadius: BorderRadius.circular(15)),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: "Сообщение",
          prefixIconColor: searchTxtColor,
          border: InputBorder.none,
          hintStyle: TextStyle(color: searchTxtColor),
        ),
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
