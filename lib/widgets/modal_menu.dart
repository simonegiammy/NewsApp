import 'package:flutter/material.dart';
import 'package:news_app/screens/home_screen.dart';

class ModalMenu extends StatefulWidget {
  const ModalMenu({super.key});

  @override
  State<ModalMenu> createState() => _ModalMenuState();
}

class _ModalMenuState extends State<ModalMenu> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
            setState(() {
              if (currentLanguage == "us") {
                currentLanguage = "it";
              } else {
                currentLanguage = "us";
              }
            });
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
            margin: const EdgeInsets.only(bottom: 8, left: 20, right: 20),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(16))),
            child: Center(
              child: Text(
                currentLanguage == "us"
                    ? "Switch to Italian 🇮🇹"
                    : "Passa all'inglese 🇺🇸",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
            margin: const EdgeInsets.only(bottom: 24, left: 20, right: 20),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(16))),
            child: Center(
              child: Text(
                "Annulla",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
        )
      ],
    );
  }
}
