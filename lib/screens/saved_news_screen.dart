import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:news_app/model/news.dart';
import 'package:news_app/repository/storage_repository.dart';
import 'package:news_app/screens/search_screen.dart';
import 'package:news_app/widgets/custom_textfield.dart';
import 'package:news_app/widgets/header.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news_app/widgets/news_tile.dart';

class SavedNewsScreen extends StatefulWidget {
  const SavedNewsScreen({super.key});

  @override
  State<SavedNewsScreen> createState() => _SavedNewsScreenState();
}

class _SavedNewsScreenState extends State<SavedNewsScreen> {
  TextEditingController textController = TextEditingController();
  bool isSearching = false;
  String query = "";

  List<News> news = [];
  List<News> filteredNews = [];

  List<String> tags = [];
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      news = await StorageRepository().getSavedNews();
      if (mounted) {
        setState(() {
          filteredNews = news;
        });
      }
    });
    textController.addListener(() {
      query = textController.text;
      setState(() {
        if (textController.text.isEmpty) {
          isSearching = false;
          filteredNews = news;
        } else {
          isSearching = true;
          filteredNews = news
              .where((element) => element.title!
                  .toLowerCase()
                  .contains(textController.text.toLowerCase()))
              .toList();
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var t = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Header(title: t.bookmark),
        Container(
          margin: const EdgeInsets.only(top: 16),
          height: 64,
          padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
          child: CustomTextField(
            onSubmit: (value) {},
            controller: textController,
          ),
        ),
        Expanded(
            child: filteredNews.isNotEmpty
                ? RefreshIndicator(
                    onRefresh: () async {
                      news = await StorageRepository().getSavedNews();

                      setState(() {
                        filteredNews = news;
                      });
                    },
                    child: ListView.builder(
                      padding: const EdgeInsets.only(
                          top: 12, left: 16, right: 16, bottom: 80),
                      itemCount: filteredNews.length,
                      itemBuilder: (context, index) {
                        return NewsTile(
                                news: filteredNews[index],
                                keyword: textController.text.isNotEmpty
                                    ? textController.text
                                    : null)
                            .animate()
                            .slideX(begin: -1, end: 0);
                      },
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 128),
                    child: Column(
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Text(
                              t.findNew,
                              style: Theme.of(context).textTheme.bodyLarge,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ))
      ],
    );
  }
}
