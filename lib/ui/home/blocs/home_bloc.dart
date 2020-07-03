import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:todoapp/domain/common/entities/todo.dart';
import 'package:todoapp/domain/home/usecases/create_todo.dart';
import 'package:todoapp/domain/home/usecases/delete_todo.dart';
import 'package:todoapp/domain/home/usecases/get_complete_todo_list.dart';
import 'package:todoapp/domain/home/usecases/get_todo_list.dart';
import 'package:todoapp/domain/home/usecases/get_incomplete_todo_list.dart';
import 'package:todoapp/domain/home/usecases/update_todo.dart';

enum TodoType { all, complete, incomplete }

class HomeBloc {
  //usecases
  final GetTodoList _getTodoList;
  final GetCompleteTodoList _getCompleteTodoList;
  final GetInCompleteTodoList _getInCompleteTodoList;
  final CreateTodo _createTodo;
  final DeleteTodo _deleteTodo;
  final UpdateTodo _updateTodo;

  HomeBloc(
      {@required GetTodoList getTodoList,
      @required GetCompleteTodoList getCompleteTodoList,
      @required GetInCompleteTodoList getInCompleteTodoList,
      @required CreateTodo createTodo,
      @required DeleteTodo deleteTodo,
      @required UpdateTodo updateTodo})
      : assert(getTodoList != null),
        assert(getCompleteTodoList != null),
        assert(getInCompleteTodoList != null),
        assert(createTodo != null),
        assert(deleteTodo != null),
        assert(updateTodo != null),
        _getTodoList = getTodoList,
        _getCompleteTodoList = getCompleteTodoList,
        _getInCompleteTodoList = getInCompleteTodoList,
        _createTodo = createTodo,
        _deleteTodo = deleteTodo,
        _updateTodo = updateTodo;

  final StreamController<List<Todo>> _todoListController =
      StreamController.broadcast();
  final StreamController<List<Todo>> _todoCompleteListController =
      StreamController.broadcast();
  final StreamController<List<Todo>> _todoInCompleteListController =
      StreamController.broadcast();

  Stream<List<Todo>> get getTodoList => _todoListController.stream;
  List<Todo> _todoList = List<Todo>();

  Stream<List<Todo>> get getCompleteTodoList =>
      _todoCompleteListController.stream;
  List<Todo> _completeTodoList = List<Todo>();

  Stream<List<Todo>> get getInCompleteTodoList =>
      _todoInCompleteListController.stream;
  List<Todo> _inCompleteTodoList = List<Todo>();

  void requestGetTodoList() async {
    try {
      _todoList = await _getTodoList();
      _todoListController.sink.add(_todoList);
    } catch (e) {
      _todoListController.addError(e);
    }
  }

  void requestGetCompleteTodoList() async {
    try {
      _completeTodoList = await _getCompleteTodoList();
      _todoCompleteListController.sink.add(_completeTodoList);
    } catch (e) {
      _todoCompleteListController.addError(e);
    }
  }

  void requestGetInCompleteTodoList() async {
    try {
      _inCompleteTodoList = await _getInCompleteTodoList();
      _todoInCompleteListController.sink.add(_inCompleteTodoList);
    } catch (e) {
      _todoInCompleteListController.addError(e);
    }
  }

  Future<bool> requestInsertTodo(Todo todo) async {
    final result = await _createTodo(todo);
    if (result) {
      _todoList.add(todo);
      _inCompleteTodoList.add(todo);
      _todoListController.sink.add(_todoList);
      _todoInCompleteListController.sink.add(_inCompleteTodoList);
    }
    return result;
  }

  Future<bool> requestUpdateTodo(Todo todo, TodoType type) async {
    //based on requirement, i just update status of task
    final todoUpdated = Todo(
        id: todo.id,
        title: todo.title,
        content: todo.content,
        isComplete: !todo.isComplete);
    final result = await _updateTodo(todoUpdated);
    if (result) {
      switch (type) {
        case TodoType.all:
          var index = _todoList.indexOf(todo);
          _todoList[index] = todoUpdated;
          _todoListController.sink.add(_todoList);
          break;
        case TodoType.complete: //at complete tab
          _completeTodoList.removeWhere((element) => element.id == todo.id);
          _todoCompleteListController.sink.add(_completeTodoList);
          break;
        case TodoType.incomplete: //at incomplete tab
          _inCompleteTodoList.removeWhere((element) => element.id == todo.id);
          _todoInCompleteListController.sink.add(_inCompleteTodoList);
          break;
        default:
          break;
      }
    }
    return result;
  }

  Future<bool> requestDeleteTodo(int id, TodoType type) async {
    final result = await _deleteTodo(id);
    //update list
    if (result) {
      switch (type) {
        case TodoType.all: //at all tab
          _todoList.removeWhere((element) => element.id == id);
          _todoListController.sink.add(_todoList);
          break;
        case TodoType.complete: //at complete tab
          _completeTodoList.removeWhere((element) => element.id == id);
          _todoCompleteListController.sink.add(_completeTodoList);
          break;
        case TodoType.incomplete: //at complete tab
          _inCompleteTodoList.removeWhere((element) => element.id == id);
          _todoInCompleteListController.sink.add(_inCompleteTodoList);
          break;
        default:
          break;
      }
    }
    return result;
  }

  void dispose() {
    _todoListController.close();
    _todoCompleteListController.close();
    _todoInCompleteListController.close();
  }
}
