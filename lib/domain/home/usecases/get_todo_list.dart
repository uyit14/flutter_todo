import 'package:flutter/foundation.dart';
import 'package:todoapp/domain/common/entities/todo.dart';
import 'package:todoapp/domain/common/usecases/base_usecase.dart';
import 'package:todoapp/domain/home/repositories/home_repository.dart';

class GetTodoList implements BaseUseCase<List<Todo>, NoParams> {
  final HomeRepository _homeRepository;

  GetTodoList({@required HomeRepository homeRepository})
      : assert(homeRepository != null),
        _homeRepository = homeRepository;

  @override
  Future<List<Todo>> call([NoParams params]) async {
    return await _homeRepository.getTodoList();
  }
}
