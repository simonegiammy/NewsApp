import 'package:dio/dio.dart';

final dioBaseConfig = BaseOptions(
  baseUrl: 'https://newsapi.org/v2',
  receiveTimeout: const Duration(milliseconds: 30000),
  connectTimeout: const Duration(milliseconds: 30000),
);

final dioRequestConfig = Options(contentType: "application/json");
