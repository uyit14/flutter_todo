
import 'package:flutter_test/flutter_test.dart';
import 'package:todoapp/data/home/repositories/home_repository_impl.dart';

main(){
  TestWidgetsFlutterBinding.ensureInitialized();
  HomeRepositoryImpl homeRepositoryImpl;

  setUp(() async{
    homeRepositoryImpl = HomeRepositoryImpl();
  });

  test("should return todo list", () async{
    final result = await homeRepositoryImpl.getTodoList();
    expect(result.length, 2);
  });
}