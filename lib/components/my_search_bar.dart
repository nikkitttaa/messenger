import 'package:flutter/material.dart';
import 'package:messanger_test/components/colors.dart';

class MySearchBar extends StatefulWidget {
  const MySearchBar({super.key});

  @override
  State<MySearchBar> createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          color: searchBGColor, borderRadius: BorderRadius.circular(15)),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: "Поиск",
          prefixIcon: Image.asset('assets/icons/search.png'),
          prefixIconColor: searchTxtColor,
          border: InputBorder.none,
          hintStyle: TextStyle(color: searchTxtColor),
        ),
        style: const TextStyle(fontWeight: FontWeight.bold),
        onChanged: (value) {},
      ),
    );
  }
}
