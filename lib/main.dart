import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterblocsqflite/bloc/food_bloc.dart';
import 'package:flutterblocsqflite/home_page.dart';
import 'package:flutterblocsqflite/ui/themes/bloc/theme_bloc.dart';

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
      home: HomePage(),
    );
  }
}
