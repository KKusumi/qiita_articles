import 'package:flutter/material.dart';
import 'package:flutter_qiita_retrofit/data/model/article.dart';
import 'package:flutter_qiita_retrofit/data/repository/article_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final homeViewModelNotifierProvider =
    ChangeNotifierProvider((ref) => HomeViewModel(ref.read));

class HomeViewModel extends ChangeNotifier {
  HomeViewModel(this._reader);

  final Reader _reader;
  late final ArticleRepository _repository = _reader(articleRepositoryProvider);

  List<Article>? _articles;

  List<Article>? get articles => _articles;

  Future<void> fetchArticles() async {
    return _repository.fetchArticles().then((value) {
      value.when(success: (data) {
        _articles = data;
      }, failure: (error) {
        // Todo
      });
    }).whenComplete(() {
      notifyListeners();
    });
  }
}
