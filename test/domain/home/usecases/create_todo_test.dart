import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todoapp/domain/common/entities/todo.dart';
import 'package:todoapp/domain/home/repositories/home_repository.dart';
import 'package:todoapp/domain/home/usecases/create_todo.dart';

class MockHomeRepository extends Mock implements HomeRepository {}

void main() {
  CreateTodo createTodo;
  MockHomeRepository mockHomeRepository;

  setUp(() {
    mockHomeRepository = MockHomeRepository();
    createTodo = CreateTodo(homeRepository: mockHomeRepository);
  });

  final todo = Todo(id: 1, title: "Title 1", content: "Content 1", isComplete: true);
  final createResult = true;

  test("should create todo success", () async {
    //
    when(mockHomeRepository.createTodo(any))
        .thenAnswer((_) async => true);
    //act
    final result = await createTodo(todo).catchError((error) {
      print('create todo onError : ${error.toString()}');
    }).timeout(Duration(seconds: 5), onTimeout: () {
      print('create todo onTimeout');
      return;
    });
    //assert
    expect(result, createResult);
  });
}
