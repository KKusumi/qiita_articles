import 'package:dio/dio.dart';
import 'package:flutter_qiita_retrofit/data/client/api_client.dart';
import 'package:flutter_qiita_retrofit/data/model/article.dart';
import 'package:flutter_qiita_retrofit/data/response/result.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final articleRepositoryProvider = Provider((ref) => ArticleRepositoryImpl());

abstract class ArticleRepository {
  Future<Result<List<Article>>> fetchArticles();
}

class ArticleRepositoryImpl with ArticleRepository {
  final ApiClient _client;

  //:でコンストラクタのリダイレクトをしている。
  ArticleRepositoryImpl([ApiClient? client]) // []: オプション引数。渡さなくてもよくなる。(Nullableなのにオプションにしているのは、呼び出し側でnullを渡す必要をなくすため。)
      : _client = client ?? ApiClient(Dio()); // ??: clientがnullじゃなかったらclientを、nullだったらApiClient(Dio())を使う。

  @override
  Future<Result<List<Article>>> fetchArticles() {
    return _client
        .fetchArticles()
        .then((articles) => Result<List<Article>>.success(articles))
        .catchError((error) => Result<List<Article>>.failure(error));
  }
}
