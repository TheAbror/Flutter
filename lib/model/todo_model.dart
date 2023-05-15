class TodoModel {
  String? id;
  String? todoText;
  bool isDone;

  TodoModel({
    this.id,
    this.todoText,
    this.isDone = false,
  });

  static List<TodoModel> todoList() {
    return [
      TodoModel(id: '01', todoText: 'Morning Exercise'),
      TodoModel(id: '02', todoText: 'Morning Exercise2'),
      TodoModel(id: '03', todoText: 'Morning Exercise3'),
      TodoModel(id: '04', todoText: 'Morning Exercise4'),
      TodoModel(id: '05', todoText: 'Morning Exercise5'),
      TodoModel(id: '06', todoText: 'Morning Exercise6'),
    ];
  }
}
