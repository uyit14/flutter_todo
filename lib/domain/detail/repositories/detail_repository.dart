import 'package:todoapp/domain/common/entities/todo.dart';

abstract class DetailRepository{
  Future<Todo> getTodoDetail(String todoId);
  Future<bool> updateTodo(Todo todo);
}