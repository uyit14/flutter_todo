import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/domain/common/entities/todo.dart';
import 'package:todoapp/ui/home/blocs/home_bloc.dart';
import 'package:todoapp/ui/home/widgets/todo_item_widget.dart';

class CompleteTodoPage extends StatefulWidget {
  @override
  _CompleteTodoPageState createState() => _CompleteTodoPageState();
}

class _CompleteTodoPageState extends State<CompleteTodoPage> {
  HomeBloc _homeBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _homeBloc = Provider.of<HomeBloc>(context);
    _homeBloc.requestGetTodoList(TodoType.complete);
  }

  void updateStatus() {}

  final todoList = List.generate(
      10,
      (index) => Todo(
          id: index,
          title: 'Title $index',
          content: 'Content $index',
          isComplete: true));

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Todo>>(
        stream: _homeBloc.getCompleteTodoList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Todo> todoList = snapshot.data;
            return ListView.builder(
                itemBuilder: (context, index){
                  return TodoItemWidget(
                    todo: todoList[index],
                    onChangeStatus: (){},
                    onDeleteTodo: (){},
                    key: ValueKey('complete$index'),
                  );
                }
            );
          } else if(snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }else{
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
