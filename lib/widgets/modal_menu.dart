import 'package:flutter/material.dart';
import 'package:news_app/locale_provider.dart';
import 'package:news_app/screens/home_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news_app/screens/main_screen.dart';
import 'package:provider/provider.dart';

class ModalMenu extends StatefulWidget {
  const ModalMenu({super.key});

  @override
  State<ModalMenu> createState() => _ModalMenuState();
}

class _ModalMenuState extends State<ModalMenu> {
  @override
  Widget build(BuildContext context) {
    var t = AppLocalizations.of(context)!;
    String text =
        darkTheme ? "Imposta modalità chiara" : "Imposta modalità scura";
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {
            Locale? locale;
            Navigator.pop(context);
            setState(() {
              cachedNews = {};
              if (currentLanguage == "us") {
                currentLanguage = "it";
                locale = const Locale('it');
              } else {
                currentLanguage = "us";
                locale = const Locale('en');
              }
            });
            context.read<LocaleProvider>().setLocale(locale!);
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
            margin: const EdgeInsets.only(bottom: 8, left: 20, right: 20),
            decoration: BoxDecoration(
                color: darkTheme ? Colors.black : Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(16))),
            child: Center(
              child: Text(
                currentLanguage == "us"
                    ? "${t.switchLanguage} 🇮🇹"
                    : "${t.switchLanguage} 🇺🇸",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
            setState(() {
              darkTheme = !darkTheme;
            });
            context.read<LocaleProvider>().notifyListeners();
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
            margin: const EdgeInsets.only(bottom: 8, left: 20, right: 20),
            decoration: BoxDecoration(
                color: darkTheme ? Colors.black : Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(16))),
            child: Center(
              child: Text(
                text,
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
            decoration: BoxDecoration(
                color: darkTheme ? Colors.black : Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(16))),
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
