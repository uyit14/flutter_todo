import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/domain/common/entities/todo.dart';
import 'package:todoapp/ui/common/config.dart';
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
    _homeBloc.requestGetCompleteTodoList();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Todo>>(
        stream: _homeBloc.getCompleteTodoList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Todo> _todoList = snapshot.data;
            if(_todoList.length > 0){
              return ListView.builder(
                itemCount: _todoList.length,
                  itemBuilder: (context, index){
                    return TodoItemWidget(
                      todo: _todoList[index],
                      onChangeStatus: (){
                        _homeBloc.requestUpdateTodo(_todoList[index], TodoType.complete);
                      },
                      onDeleteTodo: (){
                        _homeBloc.requestDeleteTodo(_todoList[index].id, TodoType.complete);
                      },
                      key: ValueKey('complete$index'),
                    );
                  }
              );
            }else{
              return Center(child: Text("No complete data", style: AppTextStyle.content,));
            }
          } else if(snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }else{
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
