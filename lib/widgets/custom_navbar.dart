import 'package:flutter/material.dart';

class CustomNavBar extends StatefulWidget {
  final int index;
  final Function(int) onItemSelected;
  const CustomNavBar(
      {super.key, required this.index, required this.onItemSelected});

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: const BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.all(Radius.circular(64))),
      child: Row(
        children: [
          GestureDetector(
              onTap: () {
                widget.onItemSelected(0);
              },
              child: const Icon(Icons.home)),
          GestureDetector(
              onTap: () {
                widget.onItemSelected(1);
              },
              child: const Icon(Icons.search)),
          GestureDetector(
              onTap: () {
                widget.onItemSelected(2);
              },
              child: const Icon(Icons.bookmark)),
        ],
      ),
    );
  }
}
