import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news_app/screens/main_screen.dart';
import 'package:news_app/screens/saved_news_screen.dart';
import 'package:news_app/screens/search_screen.dart';
import 'package:news_app/widgets/animated_carousel.dart';
import 'package:news_app/widgets/custom_navbar.dart';
import 'package:news_app/widgets/news_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  PageController controller = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    var t = AppLocalizations.of(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: const Text("NEWS"),
          actions: const [
            Icon(Icons.settings),
            SizedBox(
              width: 24,
            )
          ],
        ),
        body: SizedBox.expand(
          child: Stack(
            children: [
              Expanded(
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: controller,
                  children: const [
                    MainScreen(),
                    SearchScreen(),
                    SavedNewsScreen()
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                    child: CustomNavBar(
                        index: currentIndex,
                        onItemSelected: (index) {
                          setState(() {
                            currentIndex = index;
                          });
                          controller.animateToPage(currentIndex,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.bounceIn);
                        })),
              )
            ],
          ),
        ));
  }
}
