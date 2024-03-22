import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:news_app/main.dart';
import 'package:news_app/model/news.dart';
import 'package:news_app/repository/storage_repository.dart';
import 'package:news_app/screens/home_screen.dart';
import 'package:news_app/widgets/buttons.dart';
import 'package:news_app/widgets/news_card.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> _launchUrl(url) async {
  if (!await launchUrl(Uri.parse(url))) {
    throw Exception('Could not launch $url');
  }
}

class NewsDetailsScreen extends StatefulWidget {
  final News news;
  const NewsDetailsScreen({super.key, required this.news});

  @override
  State<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {
  bool isSaved = false;

  Future<void> _shareUrl() async {
    try {
      Share.share(
        '${widget.news.title}: ${widget.news.url}',
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      isSaved = await StorageRepository().isSaved(widget.news);
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool hasImage = widget.news.urlToImage != null;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              height: hasImage ? 500 : 350,
              child: Stack(
                children: [
                  Positioned(
                    top: hasImage ? 0 : -100,
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: NewsCard(
                            news: widget.news,
                            id: widget.news.title!,
                            extend: true)),
                  ),
                  const Positioned(top: 48, left: 20, child: GoBackButton()),
                ],
              ),
            ),
          ),
          Positioned.fill(
            top: hasImage ? 450 : 330,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 36),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  color: darkTheme ? const Color(0xff1c1c1c) : Colors.white),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    NewsDetails(news: widget.news)
                        .animate()
                        .slideY(begin: 1, end: 0),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: hasImage ? 430 : 300,
            right: 36,
            child: Row(
              children: [
                SaveButton(
                    isSaved: isSaved,
                    onTap: () {
                      setState(() {
                        if (isSaved) {
                          StorageRepository().unSave(widget.news);
                        } else {
                          StorageRepository().saveNews(widget.news);
                        }
                        setState(() {
                          isSaved = !isSaved;
                        });
                      });
                    }),
                const SizedBox(
                  width: 12,
                ),
                if (widget.news.url != null) ForwardButton(onTap: _shareUrl),
              ],
            ),
          ),
          if (widget.news.url != null)
            Positioned(
                bottom: 48,
                right: 36,
                child: ReadMoreButton(onTap: () {
                  _launchUrl(widget.news.url!);
                })),
        ],
      ),
    );
  }
}

class NewsDetails extends StatelessWidget {
  final News news;
  const NewsDetails({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          news.description ?? getLorem().substring(0, 100),
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(
          height: 12,
        ),
        Text(
          news.content ?? getLorem().substring(0, 800),
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w500,
              color: darkTheme
                  ? Colors.white.withOpacity(0.6)
                  : Colors.black.withOpacity(0.6)),
        ),
      ],
    );
  }
}
