import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todoapp/domain/common/entities/todo.dart';
import 'package:todoapp/domain/home/repositories/home_repository.dart';
import 'package:todoapp/domain/home/usecases/update_todo.dart';

class MockHomeRepository extends Mock implements HomeRepository {}

void main() {
  UpdateTodo updateTodo;
  MockHomeRepository mockHomeRepository;

  setUp(() {
    mockHomeRepository = MockHomeRepository();
    updateTodo = UpdateTodo(homeRepository: mockHomeRepository);
  });

  final todo = Todo(id: 1, title: "Title 1 updated", content: "Content 1 updated", isComplete: true);
  final updateResult = true;

  test("should update todo success", () async {
    //arrange
    when(mockHomeRepository.updateTodo(any))
        .thenAnswer((_) async => updateResult);
    //act
    final result = await updateTodo(todo).catchError((error) {
      print('update todo onError : ${error.toString()}');
    }).timeout(Duration(seconds: 5), onTimeout: () {
      print('update todo onTimeout');
      return;
    });
    //assert
    expect(result, updateResult);
  });
}
