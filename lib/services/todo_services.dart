import 'package:flutter/material.dart';

import '../models/todo_model.dart';

class TodoServices extends ChangeNotifier {
  List<Todo> todos = [];

  List<Todo> get getTodos => todos;

  void addTodos(String title) {
    final newTodo = Todo(title: title, createdAt: DateTime.now().toLocal());
    todos.add(newTodo);
    return;
  }

  void removeTodo(int index) {
    todos.removeAt(index);
    return;
  }

  void updateTodo(int index, String newTitle) {
    final todo = todos[index];
    todo.title = newTitle;

    return;
  }
}
