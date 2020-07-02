import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todoapp/domain/common/entities/todo.dart';
import 'package:todoapp/ui/common/config.dart';
typedef CustomCallBack = Function(String value);
class ListTodoWidget extends StatefulWidget {
  final List<Todo> todoList;
  final Key key;
  final Function onChangeStatus;
  final CustomCallBack onDeleteTodo;

  ListTodoWidget({@required this.todoList, @required this.key, @required this.onChangeStatus, @required this.onDeleteTodo});

  @override
  _ListTodoWidgetState createState() => _ListTodoWidgetState();
}

class _ListTodoWidgetState extends State<ListTodoWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.todoList.length,
        itemBuilder: (context, index) {
          return Slidable(
            actionPane: SlidableDrawerActionPane(),
            secondaryActions: <Widget>[
              IconSlideAction(
                caption: 'Delete',
                color: Colors.red,
                icon: Icons.delete,
                onTap: () => widget.onDeleteTodo,
              ),
            ],
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10)
              ),
              margin: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(widget.todoList[index].title, style: AppTextStyle.title),
                        SizedBox(height: 6),
                        Text(widget.todoList[index].content, style: AppTextStyle.content)
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(widget.todoList[index].isComplete
                        ? Icons.done
                        : Icons.not_interested),
                    color: widget.todoList[index].isComplete
                        ? Colors.green
                        : Colors.red,
                    onPressed: widget.onChangeStatus,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
