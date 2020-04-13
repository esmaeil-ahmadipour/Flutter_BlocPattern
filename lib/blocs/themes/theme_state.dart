part of 'theme_bloc.dart';

abstract class ThemeState extends Equatable {
  final ThemeData themeData;

  ThemeState({this.themeData});
}

class ThemeInitial extends ThemeState {
  ThemeInitial(ThemeData themeData) : super(themeData : themeData);

  @override
  List<Object> get props => [themeData];
}
