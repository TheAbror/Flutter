// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:todoapp/model/todo_model.dart';

class TodoItem extends StatelessWidget {
  final TodoModel todoo;
  final onToDoChanged;
  final onDelete;

  const TodoItem({
    super.key,
    required this.todoo,
    this.onToDoChanged,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          onToDoChanged(todoo);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        tileColor: Colors.white,
        leading: Icon(
          todoo.isDone ? Icons.check_box : Icons.check_box_outline_blank_outlined,
          color: Colors.blue,
        ),
        title: Text(
          todoo.todoText ?? '',
          style: TextStyle(
            fontSize: 16,
            decoration: todoo.isDone ? TextDecoration.lineThrough : null,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        trailing: Container(
          width: 35,
          height: 35,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(10),
          ),
          child: IconButton(
            onPressed: () {
              onDelete(todoo.id);
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}
