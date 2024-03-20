import 'package:flutter/material.dart';
import 'package:news_app/widgets/animated_carousel.dart';
import 'package:news_app/widgets/news_card.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<NewsCard> cards = [
    const NewsCard(
      id: "1",
      color: Colors.deepOrange,
    ),
    const NewsCard(
      id: "2",
      color: Colors.deepPurple,
    ),
    const NewsCard(
      id: "3",
      color: Colors.teal,
    ),
    const NewsCard(
      id: "4",
      color: Colors.yellow,
    ),
    const NewsCard(
      id: "5",
      color: Colors.green,
    ),
    const NewsCard(
      id: "6",
      color: Colors.black,
    )
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 64,
          color: Colors.red,
          child: ListView.separated(
            padding: const EdgeInsets.only(left: 24),
            itemCount: 3,
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              List<String> pages = ["Trending", "Related", "Sport"];
              return Text(pages[index]);
            },
            separatorBuilder: (context, index) {
              return const VerticalDivider();
            },
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.black,
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: AnimatedCarousel(
              items: cards,
            ),
          ),
        ),
      ],
    );
  }
}
