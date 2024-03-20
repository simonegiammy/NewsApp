import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import 'package:news_app/model/news.dart';
import 'package:news_app/theme.dart';

class NewsCard extends StatefulWidget {
  final String id;
  final News news;

  const NewsCard({super.key, required this.news, required this.id});

  @override
  State<NewsCard> createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.8;

    return Container(
      width: width,
      height: width * 1.7,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(48))),
      child: Stack(
        children: [
          SizedBox.expand(
            child: FadeInImage.assetNetwork(
              image: widget.news.urlToImage!,
              placeholder: 'assets/asset.jpg',
              fit: BoxFit.fitHeight,
            ),
          ),
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.only(left: 24, right: 30, bottom: 18),
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
                        id: int.tryParse(widget.id)!),
                    const SizedBox(
                      height: 4,
                    ),
                    Animate(
                      /*onComplete: (controller) {
                        controller.repeat();
                      },
                      effects: const [
                        //ShimmerEffect(duration: Duration(seconds: 2)) //TODO: UNCOMMENT THIS
                      ],*/
                      child: Text(
                        widget.news.title!,
                        maxLines: 3,
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
                              blurRadius: 3.0, // Raggio di sfocatura dell'ombra
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
              )), /*
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.news.author ?? "Anonymous",
                          style: Theme.of(context).textTheme.titleMedium,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          DateFormat("dd/MM/yyyy  hh:mm").format(DateTime.parse(
                            widget.news.publishedAt!,
                          )),
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(color: Colors.grey.withOpacity(0.7)),
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )*/
        ],
      ),
    );
  }
}

String getLorem() {
  return "Reloaded 1 of 794 libraries in 275ms (compile: 25 ms, reload: 85 ms, reassemble: 150 ms).Reloaded 1 of 794 libraries in 275ms (compile: 25 ms, reload: 85 ms, reassemble: 150 ms).";
}

class TagTile extends StatelessWidget {
  final String title;
  final int id;
  const TagTile({super.key, required this.title, required this.id});
  T getRandomElement<T>(List<T> list) {
    final random = Random();
    int index = random.nextInt(list.length); // Genera un indice casuale
    return list[
        index]; // Restituisce l'elemento della lista all'indice generato
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      decoration: BoxDecoration(
          color: palette[title.length % palette.length],
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
