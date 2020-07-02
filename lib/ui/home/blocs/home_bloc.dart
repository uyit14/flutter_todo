import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:todoapp/domain/common/entities/todo.dart';
import 'package:todoapp/domain/home/usecases/create_todo.dart';
import 'package:todoapp/domain/home/usecases/delete_todo.dart';
import 'package:todoapp/domain/home/usecases/get_todo_list.dart';
import 'package:todoapp/domain/home/usecases/update_todo.dart';

enum TodoType { all, complete, uncomplete }

class HomeBloc {
  //usecases
  final GetTodoList _getTodoList;
  final CreateTodo _createTodo;
  final DeleteTodo _deleteTodo;
  final UpdateTodo _updateTodo;

  HomeBloc(
      {@required GetTodoList getTodoList,
      @required CreateTodo createTodo,
      @required DeleteTodo deleteTodo,
      @required UpdateTodo updateTodo})
      : assert(getTodoList != null),
        assert(createTodo != null),
        assert(deleteTodo != null),
        assert(updateTodo != null),
        _getTodoList = getTodoList,
        _createTodo = createTodo,
        _deleteTodo = deleteTodo,
        _updateTodo = updateTodo;

  final StreamController<List<Todo>> _todoListController =
      StreamController.broadcast();
  final StreamController<List<Todo>> _todoCompleteListController =
      StreamController.broadcast();
  final StreamController<List<Todo>> _todoUnCompleteListController =
      StreamController.broadcast();

  Stream<List<Todo>> get getTodoList => _todoListController.stream;

  Stream<List<Todo>> get getCompleteTodoList =>
      _todoCompleteListController.stream;

  Stream<List<Todo>> get getUnCompleteTodoList =>
      _todoUnCompleteListController.stream;

  void requestGetTodoList(TodoType todoType) async {
    final result = await _getTodoList();
    switch (todoType) {
      //all
      case TodoType.all:
        try {
          _todoListController.sink.add(result);
        } catch (e) {
          _todoListController.addError(e);
        }
        break;
      //complete
      case TodoType.complete:
        try {
          _todoCompleteListController.sink.add(
              result.where((element) => element.isComplete == true).toList());
        } catch (e) {
          _todoCompleteListController.addError(e);
        }
        break;
      //uncomplete
      case TodoType.uncomplete:
        try {
          _todoUnCompleteListController.sink.add(
              result.where((element) => element.isComplete == false).toList());
        } catch (e) {
          _todoUnCompleteListController.addError(e);
        }
        break;
      default:
        return;
    }
  }

  Future<bool> requestInsertTodo(Todo todo) async {
    final result = await _createTodo(todo);
    return result;
  }

  Future<bool> requestUpdateTodo(Todo todo) async {
    final result = await _updateTodo(todo);
    return result;
  }

  Future<bool> requestDeleteTodo(int id) async {
    final result = await _deleteTodo(id);
    return result;
  }

  void dispose() {
    _todoListController.close();
    _todoCompleteListController.close();
    _todoUnCompleteListController.close();
  }
}
