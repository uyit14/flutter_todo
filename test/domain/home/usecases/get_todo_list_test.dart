import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todoapp/domain/common/entities/todo.dart';
import 'package:todoapp/domain/home/repositories/home_repository.dart';
import 'package:todoapp/domain/home/usecases/get_todo_list.dart';

class MockHomeRepository extends Mock implements HomeRepository {}

void main() {
  GetTodoList getTodoList;
  MockHomeRepository mockHomeRepository;

  setUp(() {
    mockHomeRepository = MockHomeRepository();
    getTodoList = GetTodoList(homeRepository: mockHomeRepository);
  });

  final todoList = List<Todo>.generate(
      5,
      (index) => Todo(
          id: index,
          title: 'Title $index',
          content: 'Content $index', isComplete: true));

  test('should get todo list success', () async {
    //arrange
    when(mockHomeRepository.getTodoList()).thenAnswer((_) async => todoList);
    //act
    final result = await getTodoList().catchError((error) {
      print('get todo list onError : ${error.toString()}');
    }).timeout(Duration(seconds: 5), onTimeout: () {
      print('get todo list onTimeout');
      return;
    });
    //assert
    expect(result, todoList);
  });
}
