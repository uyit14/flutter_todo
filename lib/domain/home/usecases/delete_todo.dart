import 'package:flutter/foundation.dart';
import 'package:todoapp/domain/home/repositories/home_repository.dart';

import '../../common/usecases/base_usecase.dart';

class DeleteTodo implements BaseUseCase<bool, int> {
  final HomeRepository _homeRepository;

  DeleteTodo({@required HomeRepository homeRepository})
      : assert(homeRepository != null),
        _homeRepository = homeRepository;

  @override
  Future<bool> call([int params]) async {
    return await _homeRepository.deleteTodo(params);
  }
}
