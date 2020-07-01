import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Todo extends Equatable{
  final String id;
  final String title;
  final String content;

  Todo({@required this.id, @required this.title, @required this.content});

  @override
  List<Object> get props => [id, title, content];

}