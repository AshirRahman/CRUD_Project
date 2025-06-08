import 'package:android_projects/screens/add_new_todo_screen.dart';
import 'package:flutter/material.dart';

class UpdateHomeScreen extends StatefulWidget {
  const UpdateHomeScreen({super.key});

  @override
  State<UpdateHomeScreen> createState() => _UpdateHomeScreenState();
}

class _UpdateHomeScreenState extends State<UpdateHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('update todo list')),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('title of todo'),
            subtitle: Text('description'),
            trailing: Wrap(
              children: [
                IconButton(
                  onPressed: _showChangeStatusDialog,
                  icon: Icon(Icons.delete),
                ),
                IconButton(
                  onPressed: _showChangeStatusDialog,
                  icon: Icon(Icons.edit),
                ),
              ],
            ),
            leading: Text('status'),
            // s
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddNewTodoScreen()),
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
              Divider(color: Colors.black, thickness: 1),
              ListTile(title: Text('in progress')),
              Divider(color: Colors.black, thickness: 1),
              ListTile(title: Text('done')),
            ],
          ),
        );
      },
    );
  }
}
