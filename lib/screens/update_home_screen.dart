import 'package:android_projects/screens/todo.dart';
import 'package:flutter/material.dart';

class UpdateHomeScreen extends StatefulWidget {
  const UpdateHomeScreen({super.key, required this.todo, required this.onUpdate});

  final Todo todo;
  final Function(Todo updatedTodo) onUpdate;

  @override
  State<UpdateHomeScreen> createState() => _UpdateHomeScreenState();
}

class _UpdateHomeScreenState extends State<UpdateHomeScreen> {
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController =
  TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState(){
    super.initState();
    _titleTEController.text = widget.todo.title;
    _descriptionTEController.text = widget.todo.description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update todo'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _titleTEController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                      labelText: 'Title', hintText: 'Write your todo title'),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Enter your title';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _descriptionTEController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  minLines: 1,
                  maxLines: 3,
                  decoration: const InputDecoration(
                      labelText: 'description',
                      hintText: 'write your description here'),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'enter your description';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Todo updatedTodo = Todo(
                        title: _titleTEController.text.trim(),
                        description: _descriptionTEController.text.trim(),
                        status: widget.todo.status,
                      );
                      widget.onUpdate(updatedTodo);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('update'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}