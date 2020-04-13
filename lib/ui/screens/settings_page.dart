import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterblocsqflite/enums/app_themes.dart';
import 'package:flutterblocsqflite/blocs/themes/theme_bloc.dart';

class SettingsPage extends StatelessWidget {
  final String title;
  SettingsPage({this.title});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('$title > Settings'),
        actions: <Widget>[],
      ),
      body: ListView.builder(
        itemCount: AppTheme.values.length,
        padding: EdgeInsets.all(8.0),
        itemBuilder: (context, index) {
          final itemAppTheme = AppTheme.values[index];
          return Card(
            color: appThemeData[itemAppTheme].primaryColor,
            child: ListTile(
                title: Text(
                  '${itemAppTheme.index} - ${itemAppTheme.toString()}',
                  style: appThemeData[itemAppTheme].textTheme.body1,
                ),
                onTap: () {
                  BlocProvider.of<ThemeBloc>(context)
                      .add(ThemeChanged(theme: itemAppTheme));
                }),
          );
        },
      ),
    );
  }
}
