import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:news_app/model/news.dart';
import 'package:news_app/repository/news_repository.dart';
import 'package:news_app/screens/home_screen.dart';
import 'package:news_app/widgets/animated_carousel.dart';
import 'package:news_app/widgets/header.dart';
import 'package:news_app/widgets/modal_menu.dart';
import 'package:news_app/widgets/news_card.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedTab = 0;
  List<Widget> cards = [];
  List<News> news = [];
  List<String> pages = [
    "For you",
    "Technology",
    "Science",
    "Business",
    "Sports"
  ];
  Map<int, List<News>> cachedNews = {};

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      news = await NewsRepository().getTopNews(null);
      cachedNews[0] = news;
      setState(() {});
    });
    super.initState();
  }

  void _refresh() async {
    if (selectedTab == 0) {
      cachedNews[selectedTab] = await NewsRepository().getTopNews(null);
    } else {
      cachedNews[selectedTab] =
          await NewsRepository().getTopNews(pages[selectedTab]);
    }
    setState(() {
      news = cachedNews[selectedTab]!;
    });
  }

  void _openModalMenu() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return const ModalMenu();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Colors.black.withOpacity(0.7),
      onRefresh: () async {
        _refresh();
      },
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Header(
              title: "Breaking News",
              action: GestureDetector(
                  onTap: _openModalMenu, child: const Icon(Icons.settings)),
            ),
            SizedBox(
              height: 48,
              child: ListView.builder(
                padding: const EdgeInsets.only(left: 24, top: 8),
                itemCount: 5,
                scrollDirection: Axis.horizontal,
                //physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () async {
                      selectedTab = index;

                      if ((cachedNews[selectedTab] ?? []).isEmpty) {
                        setState(() {
                          news = [];
                        });
                        news = await NewsRepository()
                            .getTopNews(pages[selectedTab]);
                        cachedNews[selectedTab] = news;
                      } else {
                        setState(() {
                          news = cachedNews[selectedTab]!;
                        });
                        return;
                      }

                      setState(() {});
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 16),
                      child: Text(
                        pages[index],
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                fontWeight: selectedTab == index
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: selectedTab == index
                                    ? Colors.black
                                    : Colors.grey.withOpacity(0.7)),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              height: currentLanguage == "us"
                  ? MediaQuery.of(context).size.height * 0.9
                  : MediaQuery.of(context).size.height * 0.5,
              padding: const EdgeInsets.only(left: 20, right: 20, top: 8),
              child: news.isNotEmpty
                  ? AnimatedCarousel(
                      news: news,
                    )
                  : Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 164),
                        child: LoadingAnimationWidget.inkDrop(
                            color: Colors.black, size: 70),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
