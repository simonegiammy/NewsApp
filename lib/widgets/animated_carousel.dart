import 'package:flutter/material.dart';

class AnimatedCarousel extends StatefulWidget {
  final List<Widget> items;
  final Function()? onSwipeLeft;
  final Function()? onSwipeRight;
  const AnimatedCarousel(
      {super.key, required this.items, this.onSwipeLeft, this.onSwipeRight});

  @override
  State<AnimatedCarousel> createState() => _AnimatedCarouselState();
}

class _AnimatedCarouselState extends State<AnimatedCarousel> {
  void _removeCard(int index, List<Widget> cards) {
    Widget? card;
    setState(() {
      card = cards.removeAt(index);
    });
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        cards.add(card!);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> cards = widget.items;
    return Stack(
        children: cards
            .map((e) {
              int index = cards.indexOf(e);
              Widget w = e;

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
                      _removeCard(index, cards);
                      return true;
                    },
                    key: UniqueKey(),
                    child: w);
              }
              w = AnimatedPositioned(
                  key: ValueKey(cards[index]),
                  top: index <= 2 ? index * 20 : 40,
                  left: 0,
                  right: 0,
                  //left: index <= 2 ? index * 20 : 40,
                  duration: const Duration(milliseconds: 300),
                  child: w);

              return w;
            })
            .toList()
            .reversed
            .toList());
  }
}
