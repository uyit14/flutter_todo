import 'package:flutter_test/flutter_test.dart';
import 'package:todoapp/data/home/models/todo_model.dart';
import 'package:todoapp/domain/common/entities/todo.dart';

void main() {
  final todoModel = TodoModel(id: "1", title: "Title 1", content: "Content 1");
  test("should be a subclass of Todo entity", () async {
    expect(todoModel, isA<Todo>());
  });
}
