import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todoapp/domain/detail/repositories/detail_repository.dart';
import 'package:todoapp/domain/detail/usecases/get_todo_detail.dart';
import 'package:todoapp/domain/common/entities/todo.dart';

class MockDetailRepository extends Mock implements DetailRepository {}

void main() {
  GetTodoDetail getTodoDetail;
  MockDetailRepository mockDetailRepository;

  setUp(() {
    mockDetailRepository = MockDetailRepository();
    getTodoDetail = GetTodoDetail(detailRepository: mockDetailRepository);
  });

  final todoList = List<Todo>.generate(
      5,
          (index) => Todo(
          id: index.toString(),
          title: 'Title $index',
          content: 'Content $index'));
  final todoId = "1";

  test("should get todo detail success", () async {
    //arrange
    when(mockDetailRepository.getTodoDetail(any))
        .thenAnswer((_) async => todoList[0]);
    //act
    final result = await getTodoDetail(todoId).catchError((error) {
      print('get todo detail onError : ${error.toString()}');
    }).timeout(Duration(seconds: 5), onTimeout: () {
      print('get todo detail onTimeout');
      return;
    });
    //assert
    expect(result, todoList[0]);
  });
}
