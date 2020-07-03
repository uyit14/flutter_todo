import 'package:flutter_test/flutter_test.dart';
import 'package:todoapp/data/home/repositories/home_repository_impl.dart';
import 'package:todoapp/domain/common/entities/todo.dart';

//should run "flutter run test/data/home/repositories/home_repository_impl_test.dart" for test local db
main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  HomeRepositoryImpl homeRepositoryImpl;

  setUp(() async {
    homeRepositoryImpl = HomeRepositoryImpl();
  });

  group("local db test", () {
    //insert
    test("should insert todo success", () async {
      final todo =
          Todo(title: "Title 1", content: "Content 1", isComplete: false);
      final result = await homeRepositoryImpl.createTodo(todo);
      expect(result, 1);
    });
    //list all
    test("should return todo list", () async {
      final result = await homeRepositoryImpl.getTodoList();
      expect(result.length, 1);
    });
    //complete
    test("should return complete todo list", () async {
      final result = await homeRepositoryImpl.getCompleteTodoList();
      expect(result.length, 0);
    });
    //incomplete
    test("should return incomplete todo list", () async {
      final result = await homeRepositoryImpl.getInCompleteTodoList();
      expect(result.length, 1);
    });
  });
}
