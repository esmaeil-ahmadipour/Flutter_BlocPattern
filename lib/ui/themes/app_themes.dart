import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum AppTheme { GreenLight, GreenDark, BlueLight, BlueDark }

final appThemeData = {
  AppTheme.BlueLight: ThemeData( brightness: Brightness.light , primaryColor: Colors.blue),
  AppTheme.BlueDark: ThemeData( brightness: Brightness.dark , primaryColor: Colors.blue[700]),
  AppTheme.GreenLight: ThemeData( brightness: Brightness.light , primaryColor: Colors.green),
  AppTheme.GreenDark: ThemeData( brightness: Brightness.dark , primaryColor: Colors.green[700]),
};
