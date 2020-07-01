import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todoapp/domain/detail/repositories/detail_repository.dart';
import 'package:todoapp/domain/detail/usecases/update_todo.dart';
import 'package:todoapp/domain/common/entities/todo.dart';

class MockDetailRepository extends Mock implements DetailRepository {}

void main() {
  UpdateTodo updateTodo;
  MockDetailRepository mockDetailRepository;

  setUp(() {
    mockDetailRepository = MockDetailRepository();
    updateTodo = UpdateTodo(detailRepository: mockDetailRepository);
  });

  final todo = Todo(id: "1", title: "Title 1 updated", content: "Content 1 updated");
  final updateResult = true;

  test("should update todo success", () async {
    //arrange
    when(mockDetailRepository.updateTodo(any))
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
