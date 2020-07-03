import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todoapp/domain/common/entities/todo.dart';
import 'package:todoapp/domain/home/usecases/create_todo.dart';
import 'package:todoapp/domain/home/usecases/delete_todo.dart';
import 'package:todoapp/domain/home/usecases/get_complete_todo_list.dart';
import 'package:todoapp/domain/home/usecases/get_incomplete_todo_list.dart';
import 'package:todoapp/domain/home/usecases/get_todo_list.dart';
import 'package:todoapp/domain/home/usecases/update_todo.dart';
import 'package:todoapp/ui/home/blocs/home_bloc.dart';

class MockGetTodoList extends Mock implements GetTodoList {}

class MockGetCompleteTodoList extends Mock implements GetCompleteTodoList {}

class MockGetInCompleteTodoList extends Mock implements GetInCompleteTodoList {}

class MockCreateTodo extends Mock implements CreateTodo {}

class MockDeleteTodo extends Mock implements DeleteTodo {}

class MockUpdateTodo extends Mock implements UpdateTodo {}

void main() {
  HomeBloc homeBloc;
  MockGetTodoList mockGetTodoList;
  MockGetCompleteTodoList mockGetCompleteTodoList;
  MockGetInCompleteTodoList mockGetInCompleteTodoList;
  MockCreateTodo mockCreateTodo;
  MockDeleteTodo mockDeleteTodo;
  MockUpdateTodo mockUpdateTodo;

  setUp(() {
    mockGetTodoList = MockGetTodoList();
    mockGetCompleteTodoList = MockGetCompleteTodoList();
    mockGetInCompleteTodoList = MockGetInCompleteTodoList();
    mockCreateTodo = MockCreateTodo();
    mockDeleteTodo = MockDeleteTodo();
    mockUpdateTodo = MockUpdateTodo();

    homeBloc = HomeBloc(
        getTodoList: mockGetTodoList,
        getCompleteTodoList: mockGetCompleteTodoList,
        getInCompleteTodoList: mockGetInCompleteTodoList,
        createTodo: mockCreateTodo,
        updateTodo: mockUpdateTodo,
        deleteTodo: mockDeleteTodo);
  });

  group("[UI] Home BLoC test", () {
    StreamController<List<Todo>> _todoListController;

    setUp(() {
      _todoListController = StreamController();
    });

    tearDown(() {
      _todoListController.close();
    });

    test("should success get todo list", () async {
      final _todo = List.generate(
          2,
          (index) => Todo(
              id: index,
              title: "Title $index",
              content: "Content $index",
              isComplete: false));
      when(mockGetTodoList()).thenAnswer((_) async => _todo);
      // act
      homeBloc.requestGetTodoList();
      //
      expect(_todoListController.stream, emits(_todo));
    });

    test("should success create todo", () async {
      when(mockCreateTodo(any)).thenAnswer((_) async => true);
      // act
      final result = await homeBloc.requestInsertTodo(
          Todo(title: "Title", content: "Content", isComplete: false));
      //
      expect(result, true);
    });
  });
}
