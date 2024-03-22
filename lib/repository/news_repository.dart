import 'package:flutter/material.dart';
import 'package:news_app/dataprovider/newsapi.dart';
import 'package:news_app/model/news.dart';

class NewsRepository {
  final NewsAPI newsEndpoint = NewsAPI();
  NewsRepository();

  Future<List<News>> getTopNews(String? tag) async {
    List<News> news = await newsEndpoint.getTopNews(tag).then(
          (rawData) => rawData
              .map(
                (el) => News.fromJson(el),
              )
              .toList(growable: true),
          onError: (err) => debugPrint(err.toString()),
        );
    news.removeWhere((element) => element.title == "[Removed]");
    return news;
  }

  Future<List<News>> searchNews(String? q) async {
    List<News> news = await newsEndpoint.searchNews(q).then(
          (rawData) => rawData
              .map(
                (el) => News.fromJson(el),
              )
              .toList(growable: true),
          onError: (err) => debugPrint(err.toString()),
        );
    news.removeWhere((element) => element.title == "[Removed]");
    return news;
  }
}
