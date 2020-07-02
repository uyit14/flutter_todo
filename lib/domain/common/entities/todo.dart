import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Todo extends Equatable{
  final int id;
  final String title;
  final String content;
  final bool isComplete;

  Todo({this.id, @required this.title, @required this.content, @required this.isComplete});

  @override
  List<Object> get props => [id, title, content, isComplete];

}