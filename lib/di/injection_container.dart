import 'package:get_it/get_it.dart';
import 'package:todoapp/data/home/repositories/home_repository_impl.dart';
import 'package:todoapp/domain/home/repositories/home_repository.dart';
import 'package:todoapp/domain/home/usecases/create_todo.dart';
import 'package:todoapp/domain/home/usecases/delete_todo.dart';
import 'package:todoapp/domain/home/usecases/get_complete_todo_list.dart';
import 'package:todoapp/domain/home/usecases/get_todo_list.dart';
import 'package:todoapp/domain/home/usecases/get_incomplete_todo_list.dart';
import 'package:todoapp/domain/home/usecases/update_todo.dart';
import 'package:todoapp/ui/home/blocs/home_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //repositories
  sl.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl());
  //usecases
  sl.registerLazySingleton(() => GetTodoList(homeRepository: sl()));
  sl.registerLazySingleton(() => GetCompleteTodoList(homeRepository: sl()));
  sl.registerLazySingleton(() => GetInCompleteTodoList(homeRepository: sl()));
  sl.registerLazySingleton(() => CreateTodo(homeRepository: sl()));
  sl.registerLazySingleton(() => DeleteTodo(homeRepository: sl()));
  sl.registerLazySingleton(() => UpdateTodo(homeRepository: sl()));
  //bloc
  sl.registerLazySingleton(() => HomeBloc(
      getTodoList: sl(),
      getCompleteTodoList: sl(),
      getInCompleteTodoList: sl(),
      createTodo: sl(),
      deleteTodo: sl(),
      updateTodo: sl()));
}
