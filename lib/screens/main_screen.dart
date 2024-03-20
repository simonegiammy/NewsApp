import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:news_app/model/news.dart';
import 'package:news_app/repository/news_repository.dart';
import 'package:news_app/widgets/animated_carousel.dart';
import 'package:news_app/widgets/header.dart';
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
  Map<int, List<News>> cachedNews = {};
  void _undo() {
    Widget? card;
    setState(() {
      card = cards.removeLast();
    });
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        cards.insert(0, card!);
      });
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      news = await NewsRepository().getTopNews(null);
      cachedNews[0] = news;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Header(
          title: "Breaking News",
          action: GestureDetector(onTap: _undo, child: const Icon(Icons.undo)),
        ),
        SizedBox(
          height: 48,
          child: ListView.builder(
            padding: const EdgeInsets.only(left: 24, top: 8),
            itemCount: 5,
            scrollDirection: Axis.horizontal,
            //physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              List<String> pages = [
                "For you",
                "Technology",
                "Science",
                "Business",
                "Sports"
              ];
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () async {
                  selectedTab = index;

                  if ((cachedNews[selectedTab] ?? []).isEmpty) {
                    setState(() {
                      news = [];
                    });
                    news =
                        await NewsRepository().getTopNews(pages[selectedTab]);
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
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
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
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 8),
            child: news.isNotEmpty
                ? AnimatedCarousel(
                    news: news,
                  )
                : Center(
                    child: LoadingAnimationWidget.inkDrop(
                        color: Colors.black, size: 70),
                  ),
          ),
        ),
      ],
    );
  }
}
