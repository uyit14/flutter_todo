import 'package:flutter/foundation.dart';
import 'package:todoapp/domain/common/usecases/base_usecase.dart';
import 'package:todoapp/domain/detail/repositories/detail_repository.dart';
import 'package:todoapp/domain/common/entities/todo.dart';

class UpdateTodo implements BaseUseCase<bool, Todo> {
  final DetailRepository _detailRepository;

  UpdateTodo({@required DetailRepository detailRepository})
      : assert(detailRepository != null),
        _detailRepository = detailRepository;

  @override
  Future<bool> call([Todo params]) async {
    return await _detailRepository.updateTodo(params);
  }
}
