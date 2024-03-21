import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:news_app/main.dart';
import 'package:news_app/model/news.dart';
import 'package:news_app/repository/storage_repository.dart';
import 'package:news_app/widgets/buttons.dart';
import 'package:news_app/widgets/news_card.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetailsScreen extends StatefulWidget {
  final News news;
  const NewsDetailsScreen({super.key, required this.news});

  @override
  State<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {
  bool isSaved = false;

  Future<void> _launchUrl() async {
    if (!await launchUrl(Uri.parse(widget.news.url!))) {
      throw Exception('Could not launch ${widget.news.url}');
    }
  }

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
            top: hasImage ? 0 : -180,
            child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: NewsCard(
                    news: widget.news, id: widget.news.title!, extend: true)),
          ),
          Positioned(
                  top: hasImage ? 520 : 350,
                  left: 0,
                  right: 0,
                  child: NewsDetails(news: widget.news))
              .animate()
              .slideY(begin: 1, end: 0),
          Positioned(
              top: hasImage ? 500 : 330,
              right: 48,
              child: SaveButton(
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
                  })),
          if (widget.news.url != null)
            Positioned(
                top: hasImage ? 500 : 330,
                right: 120,
                child: ForwardButton(onTap: _shareUrl)),
          const Positioned(top: 48, left: 20, child: GoBackButton()),
          if (widget.news.url != null)
            Positioned(
                bottom: 48,
                right: 36,
                child: ReadMoreButton(onTap: _launchUrl)),
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
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 48),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          color: Colors.white),
      child: Column(
        children: [
          Text(
            news.description ?? getLorem().substring(0, 100),
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            news.content ?? getLorem().substring(0, 500),
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w500,
                color: Colors.black.withOpacity(0.6)),
          ),
        ],
      ),
    );
  }
}
