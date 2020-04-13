import 'dart:convert';
import 'package:flutterblocsqflite/model/api_result_model.dart';
import 'package:flutterblocsqflite/resources/strings.dart';
import 'package:http/http.dart' as http;

abstract class ArticleRepository {
  Future<List<Articles>> getArticles();
}

class ArticleRepositoryImpl implements ArticleRepository {
  @override
  Future<List<Articles>> getArticles() async {
    var response = await http.get(AppStrings.newsUrl);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<Articles> articleList = ApiResultModel.fromJson(data).articles;
      return articleList;
    } else {
      throw Exception();
    }
  }
}
