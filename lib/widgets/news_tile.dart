import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:news_app/main.dart';
import 'package:news_app/model/news.dart';
import 'package:news_app/screens/home_screen.dart';
import 'package:news_app/screens/news_details_screen.dart';
import 'package:news_app/theme.dart';
import 'package:news_app/widgets/highlight_text.dart';
import 'package:news_app/widgets/news_card.dart';

class NewsTile extends StatelessWidget {
  final News news;
  String? keyword;
  NewsTile({super.key, required this.news, this.keyword});

  @override
  Widget build(BuildContext context) {
    String description = news.description ?? news.content ?? getLorem();
    if (description.length > 60) {
      description = description.substring(0, 60);
    }
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return NewsDetailsScreen(news: news);
          },
        ));
      },
      child: Container(
        decoration: BoxDecoration(
          color: darkTheme ? const Color(0xff1c1c1c) : Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          boxShadow: AppThemeData.getShadow(),
        ),
        margin: const EdgeInsets.only(bottom: 12),
        height: 150,
        width: MediaQuery.of(context).size.width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (news.urlToImage != null)
              Expanded(
                  flex: 3,
                  child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      height: 150,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(16))),
                      child: CachedNetworkImage(
                        imageUrl: news.urlToImage!,
                        fit: BoxFit.fitHeight,
                      ))),
            Expanded(
                flex: 7,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TagTile(title: news.source!.name ?? "N/D"),
                          const Icon(
                            Icons.arrow_forward_ios_outlined,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      HighlightedText(
                          text: news.title!,
                          maxLines: 3,
                          highlightStyle: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  height: 1.2,
                                  backgroundColor: darkTheme
                                      ? tagPalette[0]
                                      : tagPalette[3]),
                          textStyle: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(height: 1.2),
                          keyword: keyword ?? ""),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
