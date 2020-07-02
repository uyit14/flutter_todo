import 'package:flutter/foundation.dart';
import 'package:todoapp/domain/common/usecases/base_usecase.dart';
import 'package:todoapp/domain/common/entities/todo.dart';
import 'package:todoapp/domain/home/repositories/home_repository.dart';

class UpdateTodo implements BaseUseCase<bool, Todo> {
  final HomeRepository _homeRepository;

  UpdateTodo({@required HomeRepository homeRepository})
      : assert(homeRepository != null),
        _homeRepository = homeRepository;

  @override
  Future<bool> call([Todo params]) async {
    return await _homeRepository.updateTodo(params);
  }
}
