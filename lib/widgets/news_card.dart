import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import 'package:news_app/model/news.dart';
import 'package:news_app/screens/home_screen.dart';
import 'package:news_app/theme.dart';

class NewsCard extends StatefulWidget {
  final String id;
  final News news;
  bool extend = false;

  NewsCard(
      {super.key, required this.news, required this.id, this.extend = false});

  @override
  State<NewsCard> createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.8;
    bool hasImage = widget.news.urlToImage != null;

    return Hero(
      tag: 'news-card${widget.id}',
      child: Container(
        width: width,
        height: hasImage || widget.extend ? width * 1.6 : width,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
            boxShadow: AppThemeData.getShadow(),
            color: backgroundPalette[
                widget.news.title!.length % backgroundPalette.length],
            borderRadius: const BorderRadius.all(Radius.circular(48))),
        child: Stack(
          children: [
            if (hasImage)
              SizedBox.expand(child: Builder(builder: (context) {
                try {
                  return CachedNetworkImage(
                    errorWidget: (context, url, error) {
                      return Container();
                    },
                    imageUrl: widget.news.urlToImage!,
                    placeholder: (context, url) {
                      return Animate(
                        effects: const [ShimmerEffect()],
                        child: Container(
                          color: Colors.white,
                        ),
                      );
                    },
                    fit: BoxFit.fitHeight,
                  );
                } catch (e) {
                  print(e);
                  return Container();
                }
              })),
            Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  padding: EdgeInsets.only(
                      left: 24, right: 30, bottom: widget.extend ? 100 : 18),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.7)
                      ], // Da trasparente a nero
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TagTile(
                        title: widget.news.source?.name ?? "No Source",
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Animate(
                        onComplete: (controller) {
                          // controller.repeat();
                        },
                        effects: const [
                          ShimmerEffect(duration: Duration(seconds: 2))
                        ],
                        child: Text(
                          widget.news.title!,
                          maxLines: hasImage ? 3 : 4,
                          overflow: TextOverflow.ellipsis,
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Colors.white,
                            fontSize: 24,
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(
                                    1), // Colore dell'ombra con opacità
                                offset: const Offset(
                                    2.0, 2.0), // Distanza dell'ombra dal testo
                                blurRadius:
                                    3.0, // Raggio di sfocatura dell'ombra
                              ),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          widget.news.author ?? "Anonymous",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  fontStyle: FontStyle.italic,
                                  color: Colors.grey),
                          maxLines: 1,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          DateFormat("dd/MM/yyyy  hh:mm").format(DateTime.parse(
                            widget.news.publishedAt!,
                          )),
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(color: Colors.grey),
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

class TagTile extends StatelessWidget {
  final String title;

  const TagTile({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      decoration: BoxDecoration(
          color: backgroundPalette[title.length % backgroundPalette.length],
          borderRadius: const BorderRadius.all(Radius.circular(100))),
      child: Text(
        title.toUpperCase(),
        style: Theme.of(context)
            .textTheme
            .titleSmall!
            .copyWith(color: Colors.white),
      ),
    );
  }
}
