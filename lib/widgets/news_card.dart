import 'package:flutter/material.dart';

class NewsCard extends StatefulWidget {
  final String id;
  final Color color;
  const NewsCard({super.key, required this.color, required this.id});

  @override
  State<NewsCard> createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.width * 0.8 * 1.7,
      decoration: BoxDecoration(
          color: widget.color,
          borderRadius: const BorderRadius.all(Radius.elliptical(16, 8))),
    );
  }
}
