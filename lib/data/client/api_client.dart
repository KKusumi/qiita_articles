import 'package:dio/dio.dart';
import 'package:flutter_qiita_retrofit/data/model/article.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:retrofit/http.dart';

part 'api_client.g.dart';

final dioProvider = Provider((ref) => Dio());

final apiClientProvider = Provider((ref) => ApiClient(ref.read(dioProvider)));

@RestApi(baseUrl: "https://qiita.com/api/v2")
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET("/items")
  Future<List<Article>> fetchArticles();
}
