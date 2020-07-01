import 'package:flutter/foundation.dart';
import 'package:todoapp/domain/common/usecases/base_usecase.dart';
import 'package:todoapp/domain/detail/repositories/detail_repository.dart';
import 'package:todoapp/domain/common/entities/todo.dart';

class GetTodoDetail implements BaseUseCase<Todo, String> {
  final DetailRepository _detailRepository;

  GetTodoDetail({@required DetailRepository detailRepository})
      : assert(detailRepository != null),
        _detailRepository = detailRepository;

  @override
  Future<Todo> call([String params]) async {
    return await _detailRepository.getTodoDetail(params);
  }
}