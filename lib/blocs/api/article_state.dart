import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutterblocsqflite/model/api_result_model.dart';
import 'package:meta/meta.dart';

abstract class ArticleState extends Equatable {}

class ArticleInitialState extends ArticleState {
  @override
  List<Object> get props => [];
}

class ArticleLoadingState extends ArticleState {
  @override
  List<Object> get props => [];
}

class ArticleLoadedState extends ArticleState {
  List<Articles> articlesList;

  ArticleLoadedState({@required this.articlesList});

  @override
  List<Object> get props => [];
}

class ArticleErrorState extends ArticleState {
  String message;

  ArticleErrorState({@required this.message});

  @override
  List<Object> get props => null;
}
