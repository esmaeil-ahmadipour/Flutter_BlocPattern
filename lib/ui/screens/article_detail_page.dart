import 'package:flutter/material.dart';
import 'package:flutterblocsqflite/model/api_result_model.dart';

class ArticleDetailPage extends StatelessWidget {
 Articles article;

  ArticleDetailPage(this.article);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Health"),
      ),
      body: ListView(
        padding: EdgeInsets.all(4.0),
        children: <Widget>[
          Hero(
            tag: article.urlToImage,
            child: Image.network(article.urlToImage),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(4.0),
            child: Text(
              article.title,
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          Container(
            alignment: Alignment.topRight,
            margin: EdgeInsets.all(4.0),
            child: Text(article.publishedAt),
          ),
          Text(article.content),
        ],
      ),
    );
  }
}
