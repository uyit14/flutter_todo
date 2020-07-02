import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/domain/common/entities/todo.dart';
import 'package:todoapp/ui/home/blocs/home_bloc.dart';
import 'package:todoapp/ui/home/widgets/list_todo_widget.dart';

class AllTodoPage extends StatefulWidget {
  @override
  _AllTodoPageState createState() => _AllTodoPageState();
}

class _AllTodoPageState extends State<AllTodoPage> {
  HomeBloc _homeBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _homeBloc = Provider.of<HomeBloc>(context);
    _homeBloc.requestGetTodoList(TodoType.all);
  }

  final todoList = List.generate(
      10,
      (index) => Todo(
          id: index,
          title: 'Title $index',
          content: 'Content $index',
          isComplete: index % 2 == 0 ? true : false));

  void updateStatus() {}

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Todo>>(
        stream: _homeBloc.getTodoList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListTodoWidget(
                todoList: snapshot.data,
                key: UniqueKey(),
                onChangeStatus: updateStatus);
          } else if(snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }else{
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}