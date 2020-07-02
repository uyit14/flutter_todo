import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todoapp/domain/common/entities/todo.dart';
import 'package:todoapp/ui/common/config.dart';

class TodoItemWidget extends StatelessWidget {
  final Todo todo;
  final Key key;
  final Function onChangeStatus;
  final Function onDeleteTodo;

  TodoItemWidget(
      {@required this.todo,
      @required this.key,
      @required this.onChangeStatus,
      @required this.onDeleteTodo});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () => onDeleteTodo,
        ),
      ],
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.5),
            borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(todo.title, style: AppTextStyle.title),
                  SizedBox(height: 6),
                  Text(todo.content, style: AppTextStyle.content)
                ],
              ),
            ),
            IconButton(
              icon: Icon(todo.isComplete ? Icons.done : Icons.not_interested),
              color: todo.isComplete ? Colors.green : Colors.red,
              onPressed: onChangeStatus,
            ),
          ],
        ),
      ),
    );
  }
}
