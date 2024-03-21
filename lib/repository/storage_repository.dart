import 'dart:convert';

import 'package:news_app/model/news.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageRepository {
  Future<List<News>> getSavedNews() async {
    final sp = await SharedPreferences.getInstance();
    List<String>? newsToDecode = sp.getStringList("saved-news");
    return (newsToDecode ?? [])
        .map((e) => News.fromJson(jsonDecode(e)))
        .toList();
  }

  Future<bool> isSaved(News n) async {
    List<News> news = await getSavedNews();
    if (news.where((element) => element.title == n.title).isNotEmpty) {
      return true;
    }
    return false;
  }

  Future<bool> saveNews(News n) async {
    try {
      final sp = await SharedPreferences.getInstance();

      List<News> savedNews = await getSavedNews();

      List<String> encodedNews =
          savedNews.map((e) => jsonEncode(n.toJson())).toList();
      encodedNews.add(jsonEncode(n.toJson()));
      sp.setStringList("saved-news", encodedNews);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> unSave(News n) async {
    try {
      final sp = await SharedPreferences.getInstance();

      List<News> savedNews = await getSavedNews();
      savedNews.removeWhere((element) => element.title == n.title);
      List<String> encodedNews =
          savedNews.map((e) => jsonEncode(n.toJson())).toList();

      sp.setStringList("saved-news", encodedNews);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
