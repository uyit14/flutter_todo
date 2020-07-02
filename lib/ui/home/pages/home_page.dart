import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/domain/common/entities/todo.dart';
import 'package:todoapp/ui/home/blocs/home_bloc.dart';

import 'all_todo_page.dart';
import 'complete_todo_page.dart';
import 'uncomplete_todo_page.dart';

class HomePage extends StatefulWidget {
  final HomeBloc _homeBloc;

  const HomePage({@required HomeBloc homeBloc}) : _homeBloc = homeBloc;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, Object>> _pages = [
    {'page': AllTodoPage(), 'title': 'AllTodo'},
    {'page': CompleteTodoPage(), 'title': 'Complete'},
    {'page': UnCompleteTodoPage(), 'title': 'UnComplete'}
  ];

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Provider<HomeBloc>(
      create: (context) => widget._homeBloc,
      dispose: (context, bloc) => widget._homeBloc.dispose(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(_pages[_selectedPageIndex]['title']),
        ),
        body: _pages[_selectedPageIndex]['page'],
        bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          backgroundColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.white,
          currentIndex: _selectedPageIndex,
          type: BottomNavigationBarType.shifting,
          items: [
            BottomNavigationBarItem(
                backgroundColor: Theme.of(context).primaryColor,
                icon: Icon(Icons.format_align_left, size: 26),
                title: Text('All')),
            BottomNavigationBarItem(
                backgroundColor: Theme.of(context).primaryColor,
                icon: Icon(Icons.done, size: 26),
                title: Text('Complete')),
            BottomNavigationBarItem(
                backgroundColor: Theme.of(context).primaryColor,
                icon: Icon(Icons.not_interested, size: 26),
                title: Text('UnComplete')),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            widget._homeBloc.requestInsertTodo(Todo(
                title: "Title 2", content: "Content 2", isComplete: true));
            setState(() {

            });
          },
        ),
      ),
    );
  }
}
