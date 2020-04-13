part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
}

class ThemeChanged extends ThemeEvent {
  final AppTheme theme;

  ThemeChanged({@required this.theme});

  @override
  // TODO: implement props
  List<Object> get props => [theme];

}
