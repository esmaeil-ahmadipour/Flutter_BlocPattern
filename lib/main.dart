import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterblocsqflite/blocs/api/article_bloc.dart';
import 'package:flutterblocsqflite/blocs/main_database/food_bloc.dart';
import 'package:flutterblocsqflite/blocs/themes/theme_bloc.dart';
import 'package:flutterblocsqflite/repository/article_repository.dart';
import 'package:flutterblocsqflite/ui/screens/home_page.dart';
import 'package:flutterblocsqflite/ui/screens/online_page.dart';

void main() => runApp(MainPage());

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<FoodBloc>(
      create: (context) => FoodBloc(),
      child: BlocProvider(
        create: (context) => ThemeBloc(),
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: _buildWithTheme,
        ),
      ),
    );
  }

  Widget _buildWithTheme(BuildContext context, ThemeState state) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: state.themeData,
      home:HomePage(),
//      BlocProvider(
//        create: (context) => ArticleBloc(repository: ArticleRepositoryImpl()),
//        child: OnlinePage(),
      );
  }
}
