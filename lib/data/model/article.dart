import 'package:flutter_qiita_retrofit/data/model/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'article.g.dart';

@JsonSerializable(explicitToJson: true)
class Article {
  String id;
  String title;
  String url;
  User user;

  // {}: 名前付き引数。
  Article(
      {required this.id, // required: コンストラクタ引数を必須にする。プロパティをnullableにする必要がなくなる。
      required this.title,
      required this.url,
      required this.user});

  // factory: Factory Method Pattern
  // Creatorを作る手間が省ける。
  // クラス名.関数名()でコンストラクタのオーバーロード
  factory Article.fromJson(Map<String, dynamic> json) => // dynamic: 動的型付けを行う。(Object型だと変換が必要になるから？)
      _$ArticleFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleToJson(this);
}
