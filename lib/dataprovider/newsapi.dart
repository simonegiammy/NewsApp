import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news_app/dataprovider/dioconfig.dart';

class NewsAPI {
  final String apiKey = "1b672db31dbf4dc590082690ff78d3e1";
  final Dio _dio = Dio(dioBaseConfig);

  Future<List<dynamic>> getTopNews(String? tag) async {
    String url = "/top-headlines?country=us&apiKey=$apiKey";
    if (tag != null) {
      url += "&category=${tag.toLowerCase()}";
    }
    var value = await _dio.get(url);

    return value.data['articles'];
  }
}
