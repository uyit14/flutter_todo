import 'package:flutter_test/flutter_test.dart';
import 'package:todoapp/data/home/repositories/home_repository_impl.dart';

//should run "flutter run test/data/home/repositories/home_repository_impl_test.dart" for test local db
main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  HomeRepositoryImpl homeRepositoryImpl;

  setUp(() async {
    homeRepositoryImpl = HomeRepositoryImpl();
  });

  group("local db test", () {
    //list all
    test("should return todo list", () async {
      final result = await homeRepositoryImpl.getTodoList();
      expect(result.length, 2);
    });
    //complete
    test("should return complete todo list", () async {
      final result = await homeRepositoryImpl.getCompleteTodoList();
      expect(result.length, 1);
    });
    //incomplete
    test("should return incomplete todo list", () async {
      final result = await homeRepositoryImpl.getInCompleteTodoList();
      expect(result.length, 1);
    });
  });
}
