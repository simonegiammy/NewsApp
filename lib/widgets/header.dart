import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String title;
  final Widget? action;
  const Header({super.key, required this.title, this.action});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 24, right: 24),
      child: Row(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Expanded(child: Container()),
          action ?? Container()
        ],
      ),
    );
  }
}
