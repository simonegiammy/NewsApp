import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:news_app/model/news.dart';
import 'package:news_app/repository/news_repository.dart';
import 'package:news_app/repository/storage_repository.dart';
import 'package:news_app/screens/home_screen.dart';
import 'package:news_app/widgets/buttons.dart';
import 'package:news_app/widgets/custom_textfield.dart';
import 'package:news_app/widgets/header.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news_app/widgets/news_tile.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController textController = TextEditingController();
  bool isSearching = false;
  String query = "";
  List<News> news = [];
  List<String> tags = [];
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      tags = await StorageRepository().getChronology();
      if (tags.length > 3) {
        tags = tags.sublist(0, 2);
      }
      if (mounted) {
        setState(() {});
      }
    });
    textController.addListener(() {
      query = textController.text;
      setState(() {
        if (textController.text.isEmpty) {
          isSearching = false;
        } else {
          isSearching = true;
        }
      });
    });
    super.initState();
  }

  void onSubmit() {
    if (textController.text.length > 2) {
      StorageRepository().saveTag(textController.text);
      setState(() {
        tags.add(textController.text);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var t = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Header(title: t.discover),
        Container(
          margin: const EdgeInsets.only(top: 16),
          height: 64,
          padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
          child: CustomTextField(
            onSubmit: (value) {
              onSubmit();
            },
            controller: textController,
          ),
        ),
        if (tags.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 6,
                    child: Wrap(
                      children: [
                        for (String s in tags)
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  textController.text = s;
                                });
                              },
                              child: SearchTile(text: s)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: DeleteTagsButton(onTap: () {
                      setState(() {
                        tags = [];
                      });
                      StorageRepository().removeTags();
                    }),
                  )
                ]),
          ),
        if (isSearching)
          Expanded(
              child: FutureBuilder(
            future: NewsRepository().searchNews(textController.text),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                news = snapshot.data!;
              }
              if (snapshot.connectionState == ConnectionState.waiting &&
                  news.isEmpty) {
                return Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 164),
                    child: LoadingAnimationWidget.inkDrop(
                        color: darkTheme ? Colors.white : Colors.black,
                        size: 70),
                  ),
                );
              } else {
                if (news.isNotEmpty) {
                  return ListView.builder(
                    padding: const EdgeInsets.only(
                        top: 12, left: 16, right: 16, bottom: 80),
                    itemCount: news.length,
                    itemBuilder: (context, index) {
                      return NewsTile(
                        news: news[index],
                        keyword: textController.text,
                      ).animate().slideX(begin: -1, end: 0);
                    },
                  );
                }
              }
              return Container();
            },
          ))
        else
          Padding(
            padding: const EdgeInsets.only(top: 128),
            child: Column(
              children: [
                const SizedBox(
                  height: 12,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      t.findNew,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
              ],
            ),
          )
      ],
    );
  }
}

class SearchTile extends StatelessWidget {
  final String text;
  const SearchTile({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 6, bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.withOpacity(0.3)),
          color: darkTheme ? Colors.black : Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(24))),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 20),
      ),
    );
  }
}
