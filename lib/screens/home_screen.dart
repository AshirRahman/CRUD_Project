import 'package:android_projects/screens/add_new_todo_screen.dart';
import 'package:android_projects/screens/todo.dart';
import 'package:android_projects/screens/update_home_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Todo> listOfTodo = [];

  void _addTodo(Todo todo) {
    listOfTodo.add(todo);
    setState(() {});
  }

  void _deleteTodo(int index) {
    listOfTodo.removeAt(index);
    setState(() {});
  }

  void _updateTodo(int index, Todo todo) {
    listOfTodo[index] = todo;
    setState(() {});
  }

  void _updateTodoStatus(int index, TodoStatus status) {
    listOfTodo[index].status = status;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('todo list')),
      body: Visibility(
        visible: listOfTodo.isNotEmpty,
        replacement: Center(child: Text('Empty List')),
        child: ListView.builder(
          itemCount: listOfTodo.length,
          itemBuilder: (context, index) {
            Todo todo = listOfTodo[index];
            return ListTile(
              title: Text(todo.title),
              subtitle: Text(todo.description),
              trailing: Wrap(
                children: [
                  IconButton(
                    onPressed: () {
                      _deleteTodo(index);
                    },
                    // onPressed: _showChangeStatusDialog,
                    icon: Icon(Icons.delete),
                  ),
                  IconButton(
                    onPressed: () => _showChangeStatusDialog(index),
                    icon: Icon(Icons.edit),
                  ),
                ],
              ),
              leading: Text(todo.status.name),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UpdateHomeScreen(),
                  ),
                );
              }, // s
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Todo? todo = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddNewTodoScreen()),
          );
          if (todo != null) {
            _addTodo(todo);
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showChangeStatusDialog(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('change status'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('idle'),
                onTap: () {
                  _updateTodoStatus(index, TodoStatus.idle);
                },
              ),
              Divider(height: 0, color: Colors.black, thickness: 1),
              ListTile(
                title: Text('in progress'),
                onTap: () {
                  _updateTodoStatus(index, TodoStatus.inProgress);
                },
              ),
              Divider(height: 0, color: Colors.black, thickness: 1),
              ListTile(
                title: Text('done'),
                onTap: () {
                  _updateTodoStatus(index, TodoStatus.done);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
