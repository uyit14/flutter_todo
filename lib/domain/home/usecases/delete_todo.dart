import 'package:flutter/foundation.dart';
import 'file:///F:/FLUTTER/flutter_todo/lib/domain/common/usecases/base_usecase.dart';
import 'package:todoapp/domain/home/repositories/home_repository.dart';

class DeleteTodo implements BaseUseCase<bool, String> {
  final HomeRepository _homeRepository;

  DeleteTodo({@required HomeRepository homeRepository})
      : assert(homeRepository != null),
        _homeRepository = homeRepository;

  @override
  Future<bool> call([String params]) async {
    return await _homeRepository.deleteTodo(params);
  }
}
