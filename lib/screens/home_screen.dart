import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news_app/locale_provider.dart';
import 'package:news_app/screens/main_screen.dart';
import 'package:news_app/screens/saved_news_screen.dart';
import 'package:news_app/screens/search_screen.dart';
import 'package:news_app/widgets/custom_navbar.dart';
import 'package:provider/provider.dart';

String currentLanguage = "it";
bool darkTheme = false;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  PageController controller = PageController(initialPage: 0);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var t = AppLocalizations.of(context);
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          Positioned.fill(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: controller,
              children: const [MainScreen(), SearchScreen(), SavedNewsScreen()],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child:
                Consumer<LocaleProvider>(builder: (context, provider, child) {
              return Container(
                  padding: const EdgeInsets.only(left: 0, right: 0, bottom: 0),
                  child: CustomNavBar(
                      index: currentIndex,
                      onItemSelected: (index) {
                        setState(() {
                          currentIndex = index;
                        });
                        controller.jumpToPage(
                          currentIndex,
                        );
                      }));
            }),
          )
        ],
      ),
    ));
  }
}
