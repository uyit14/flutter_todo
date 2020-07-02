import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todoapp/domain/home/repositories/home_repository.dart';
import 'package:todoapp/domain/home/usecases/delete_todo.dart';

class MockHomeRepository extends Mock implements HomeRepository {}

void main() {
  DeleteTodo deleteTodo;
  MockHomeRepository mockHomeRepository;

  setUp(() {
    mockHomeRepository = MockHomeRepository();
    deleteTodo = DeleteTodo(homeRepository: mockHomeRepository);
  });

  int deleteId = 1;
  final deleteResult = true;

  test("should delete todo success", () async {
    //arrange
    when(mockHomeRepository.deleteTodo(any))
        .thenAnswer((_) async => deleteResult);
    //act
    final result = await deleteTodo(deleteId).catchError((error) {
      print('delete todo onError : ${error.toString()}');
    }).timeout(Duration(seconds: 5), onTimeout: () {
      print('delete todo onTimeout');
      return;
    });
    //assert
    expect(result, deleteResult);
  });
}