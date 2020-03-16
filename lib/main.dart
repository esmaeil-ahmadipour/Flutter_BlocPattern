import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterblocsqflite/bloc/food_bloc.dart';
import 'package:flutterblocsqflite/home_page.dart';

void main() => runApp(MainPage());

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<FoodBloc>(
      create: (context) => FoodBloc(),
      child: MaterialApp(
        title: 'Sqflite Tutorial',
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
        ),
        home: HomePage(),
      ),
    );
  }
}
