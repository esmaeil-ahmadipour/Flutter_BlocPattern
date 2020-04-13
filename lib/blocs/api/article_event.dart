import 'package:equatable/equatable.dart';

abstract class ArticleEvent extends Equatable {}

class FetchArticleEvent extends ArticleEvent {
  @override
  List<Object> get props => null;
}
