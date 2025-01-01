import 'package:web/web.dart';
import 'dart:html';

class Todo {
  String item = '';

  Todo(String title) {
    item = title;
  }

  void completeTodo (HTMLDivElement todo) {
    todo.remove();
    print('completed todo');
  }
}

class TodoList {
  List<Todo> list = [];

  addTodo (HTMLDivElement root, Todo todo) {
    var todoElem = DivElement();
    var title = DivElement();
    var completedButton = ButtonElement();
    completedButton.text = 'complete';
    completedButton.onClick.listen((event) => todo.completeTodo(todoElem as HTMLDivElement));
    title.text = todo.item;
    todoElem.children.add(title);
    todoElem.children.add(completedButton);
    root.append(todoElem as HTMLDivElement);
    list.add(todo);
  }
}

void main() {
  final root = document.querySelector('#root') as HTMLDivElement;
  final form = document.querySelector('#todoform') as HTMLFormElement;

  String inputValue = '';
  var inputElem = InputElement();
  inputElem.onInput.listen((event) => inputValue = inputElem.value ?? '');
  form.append(inputElem as HTMLInputElement);

  final listElem = DivElement();
  TodoList list = TodoList();
  
  createTodo () {
    Todo todo = Todo(inputValue);
    inputElem.value = '';
    inputValue = '';
    list.addTodo(listElem as HTMLDivElement, todo);
  }
  
  root.append(listElem as HTMLButtonElement);
  var button = ButtonElement();
  button.text = 'create todo';
  button.onClick.listen((event) => createTodo());
  root.append(button as HTMLButtonElement);
}
