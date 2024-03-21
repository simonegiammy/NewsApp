import 'package:flutter/material.dart';
import 'package:news_app/model/news.dart';
import 'package:news_app/screens/news_details_screen.dart';
import 'package:news_app/widgets/news_card.dart';

class AnimatedCarousel extends StatefulWidget {
  final List<News> news;
  final Function()? onSwipeLeft;
  final Function()? onSwipeRight;
  const AnimatedCarousel(
      {super.key, required this.news, this.onSwipeLeft, this.onSwipeRight});

  @override
  State<AnimatedCarousel> createState() => _AnimatedCarouselState();
}

class _AnimatedCarouselState extends State<AnimatedCarousel> {
  void _removeCard(int index, List<News> news) {
    News? n;
    setState(() {
      n = news.removeAt(0);
    });

    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        news.add(n!);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: widget.news
            .sublist(0, 3)
            .map((e) {
              int index = widget.news.indexOf(e);
              Widget w = GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return NewsDetailsScreen(news: e);
                      },
                    ));
                  },
                  child: NewsCard(news: e, id: e.title!));
              if (index != 0) {
                w = ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    Colors.grey.withOpacity(
                        index * 0.15), // Colore rosso con opacità al 50%
                    BlendMode.srcATop, // Modalità di fusione
                  ),
                  child: w,
                );
              }
              if (index == 0) {
                w = Dismissible(
                    crossAxisEndOffset: 0,
                    confirmDismiss: (direction) async {
                      if (direction == DismissDirection.endToStart &&
                          widget.onSwipeLeft != null) {
                        widget.onSwipeLeft!();
                      } else if (direction == DismissDirection.startToEnd &&
                          widget.onSwipeRight != null) {
                        widget.onSwipeRight!();
                      }
                      _removeCard(index, widget.news);
                      return true;
                    },
                    key: UniqueKey(),
                    child: w);
              }

              w = AnimatedPositioned(
                  key: ValueKey(widget.news[index]),
                  top: index <= 2 ? index * 20 : 40,
                  right: 0,
                  left: index <= 2 ? index * 20 : 40,
                  duration: const Duration(milliseconds: 300),
                  child: w);

              return w;
            })
            .toList()
            .reversed
            .toList());
  }
}
