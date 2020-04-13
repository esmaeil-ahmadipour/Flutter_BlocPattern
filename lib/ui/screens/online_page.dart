import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterblocsqflite/blocs/api/article_bloc.dart';
import 'package:flutterblocsqflite/blocs/api/article_event.dart';
import 'package:flutterblocsqflite/blocs/api/article_state.dart';
import 'package:flutterblocsqflite/model/api_result_model.dart';
import 'package:flutterblocsqflite/ui/screens/about_us_page.dart';
import 'package:flutterblocsqflite/ui/screens/article_detail_page.dart';
import 'package:flutterblocsqflite/ui/screens/home_page.dart';
import 'package:flutterblocsqflite/ui/screens/settings_page.dart';

class OnlinePage extends StatefulWidget {
  @override
  _OnlinePageState createState() => _OnlinePageState();
}

class _OnlinePageState extends State<OnlinePage> {
  ArticleBloc articleBloc;

  @override
  void initState() {
    super.initState();
    articleBloc = BlocProvider.of<ArticleBloc>(context);
    articleBloc.add(FetchArticleEvent());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (context) {
          return Material(
            child: Scaffold(
              appBar: AppBar(
                title: Text("Health News"),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.settings),
                    onPressed: () {
                      SettingsPage('Settings');
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.archive),
                    onPressed: () {
                      HomePage();
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.supervised_user_circle),
                    onPressed: () {
                      navigateToArticleAboutPage(context);
                    },
                  ),
                ],
              ),
              body: Container(
                child: BlocListener<ArticleBloc, ArticleState>(
                  listener: (context, state) {
                    if (state is ArticleErrorState) {
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                        ),
                      );
                    }
                  },
                  child: BlocBuilder<ArticleBloc, ArticleState>(
                    builder: (context, state) {
                      if (state is ArticleInitialState) {
                        return buildLoading();
                      } else if (state is ArticleLoadedState) {
                        return buildArticleList(state.articlesList);
                      } else if (state is ArticleErrorState) {
                        return buildErrorUi(state.message);
                      } else  {
                        return buildLoading();
                      }
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildErrorUi(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          message,
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }

  Widget buildArticleList(List<Articles> articles) {
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (ctx, pos) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            child: ListTile(
              leading: ClipOval(
                child: checkImage(articles[pos].urlToImage)
              ),
              title: Text(articles[pos].title),
              subtitle: Text(articles[pos].publishedAt),
            ),
            onTap: () {
              navigateToArticleDetailPage(context, articles[pos]);
            },
          ),
        );
      },
    );
  }

  void navigateToArticleDetailPage(BuildContext context, Articles articles) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ArticleDetailPage(articles);
    }));
  }

  void navigateToArticleAboutPage(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AboutPage();
    }));
  }
  Widget checkImage(String url) {
    try {
      return Image.network(url, height: 70.0, width: 70.0, fit: BoxFit.cover);
    } catch (e) {
      return Container(
        width: 70.0,
        height: 70.0,
        child: Center(
          child: Icon(Icons.image),
        ),
      );
    }
  }
}

