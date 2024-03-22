import 'package:dio/dio.dart';
import 'package:news_app/dataprovider/dioconfig.dart';
import 'package:news_app/screens/home_screen.dart';

class NewsAPI {
  final String apiKey = "[INSERT HERE YOU API KEY]";
  final Dio _dio = Dio(dioBaseConfig);

  Future<List<dynamic>> getTopNews(String? tag) async {
    String url = "/top-headlines?country=$currentLanguage&apiKey=$apiKey";
    if (tag != null) {
      url += "&category=${tag.toLowerCase()}";
    }

    try {
      var value = await _dio.get(url);
      return value.data['articles'];
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<dynamic>> searchNews(String? q) async {
    String locale = currentLanguage == "us" ? "en" : "it";
    String url = "/everything?language=$locale&apiKey=$apiKey&q=$q";

    var value = await _dio.get(url);

    return value.data['articles'];
  }
}
