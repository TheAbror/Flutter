import 'package:flutter/material.dart';
import 'package:todoapp/model/todo_model.dart';
import 'package:todoapp/todo_item.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //
  final todoList = TodoModel.todoList();
  List<TodoModel> _foundTodo = [];
  final _todoController = TextEditingController();

  void _runFilter(String enteredKeyWord) {
    List<TodoModel> result = [];
    if (enteredKeyWord.isEmpty) {
      result = todoList;
    } else {
      result = todoList
          .where(
            (item) => item.todoText!.toLowerCase().contains(enteredKeyWord.toLowerCase()),
          )
          .toList();
    }

    setState(() {
      _foundTodo = result;
    });
  }

  @override
  void initState() {
    _foundTodo = todoList;
    super.initState();
  }

  void _handleToDoChange(TodoModel todoModel) {
    setState(() {
      todoModel.isDone = !todoModel.isDone;
    });
  }

  void _onDelete(String id) {
    setState(() {
      todoList.removeWhere((item) => item.id == id);
    });
  }

  void _addTodoItem(String todo) {
    setState(() {
      todoList.add(
        TodoModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          todoText: todo,
        ),
      );
    });
    _todoController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: _builtAppBar(),
      body: Stack(
        children: [
          _searchBox(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(
                      bottom: 40,
                      left: 20,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: _todoController,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 15),
                        hintText: 'Add a new task',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _addTodoItem(_todoController.text);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(
                      bottom: 40,
                      right: 20,
                      left: 20,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 45,
                    width: 45,
                    child: const Icon(Icons.add),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _searchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextField(
              onChanged: (value) {
                _runFilter(value);
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                prefixIcon: Icon(
                  Icons.search,
                  size: 20,
                ),
                prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 25),
                border: InputBorder.none,
                hintText: 'Search',
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _allToDosText(),
                for (TodoModel todo in _foundTodo.reversed)
                  TodoItem(
                    todoo: todo,
                    onToDoChanged: _handleToDoChange,
                    onDelete: _onDelete,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _allToDosText() {
    return Container(
      margin: const EdgeInsets.only(top: 50, bottom: 20),
      child: const Text(
        'All ToDos',
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
      ),
    );
  }

//
  AppBar _builtAppBar() {
    return AppBar(
      backgroundColor: Colors.grey.shade100,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(
            Icons.menu,
            color: Colors.black,
          ),
          CircleAvatar(
            backgroundColor: Colors.grey.shade500,
          ),
        ],
      ),
    );
  }
}
