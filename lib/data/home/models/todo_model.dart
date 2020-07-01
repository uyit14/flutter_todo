import 'package:flutter/foundation.dart';
import 'package:todoapp/domain/common/entities/todo.dart';

class TodoModel extends Todo {
  final String id;
  final String title;
  final String content;

  TodoModel({@required this.id, @required this.title, @required this.content});
}
