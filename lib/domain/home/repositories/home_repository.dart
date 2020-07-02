import 'package:todoapp/domain/common/entities/todo.dart';

abstract class HomeRepository{
  Future<List<Todo>> getTodoList();
  Future<bool> createTodo(Todo todo);
  Future<bool> deleteTodo(int id);
  Future<bool> updateTodo(Todo todo);
}