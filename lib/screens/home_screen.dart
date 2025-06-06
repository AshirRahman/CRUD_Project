import 'package:android_projects/screens/add_new_todo_screen.dart';
import 'package:android_projects/screens/update_home_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('todo list')),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('title of todo'),
            subtitle: Text('description'),
            trailing: Wrap(
              children: [
                IconButton(
                  onPressed:
                      _showChangeStatusDialog,
                  icon: Icon(Icons.delete),
                ),
                IconButton(
                  onPressed:
                      _showChangeStatusDialog,
                  icon: Icon(Icons.edit),
                ),
              ],
            ),
            leading: Icon(Icons.person),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const UpdateHomeScreen(),
                ),
              );
            }, // s
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  const AddNewTodoScreen(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showChangeStatusDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('change status'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(title: Text('idle')),
              Divider(
                height: 0,
                color: Colors.black,
                thickness: 1,
              ),
              ListTile(
                title: Text('in progress'),
              ),
              Divider(
                height: 0,
                color: Colors.black,
                thickness: 1,
              ),
              ListTile(title: Text('done')),
            ],
          ),
        );
      },
    );
  }
}
