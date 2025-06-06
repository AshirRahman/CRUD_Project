import 'package:flutter/material.dart';

class AddNewTodoScreen extends StatefulWidget {
  const AddNewTodoScreen({super.key});

  @override
  State<AddNewTodoScreen> createState() =>
      _AddNewTodoScreenState();
}

class _AddNewTodoScreenState
    extends State<AddNewTodoScreen> {
  final TextEditingController _titleTEController =
      TextEditingController();
  final TextEditingController
  _descriptionController =
      TextEditingController();
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('add new todo screen'),
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
                    decoration: InputDecoration(
                      labelText: 'title',
                      hintText:
                          'write your todo title',
                    ),
                    validator: (String? value) {
                      if (value == null ||
                          value.trim().isEmpty) {
                        return 'enter you title';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    controller: _descriptionController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    minLines: 1,
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: 'description',
                      hintText:
                          'write your todo description',
                    ),
                    validator: (String? value) {
                      if (value == null ||
                          value.trim().isEmpty) {
                        return 'enter your description';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // print(
                      //   'clicked submit button',
                      // );
                      if (_formKey.currentState!.validate()){

                      }
                    },
                    child: Text('submit'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
