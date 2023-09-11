

import 'dart:async';

import 'package:to_do_app/todo.dart';

class ToDoController{  //Update UI using StreamBuilder

  final todosList = [
    ToDo(id: "1", todoText: "Morning walk", isDone: true),
    // ToDo(id: "2", todoText: "Breakfast", isDone: true),
    // ToDo(id: "3", todoText: "Check mail"),
    // ToDo(id: "4", todoText: "Team working"),
    // ToDo(id: "5", todoText: "Work on mobile app"),
    // ToDo(id: "6", todoText: "Lunch with SBU Head."),
  ];
  final StreamController<List<ToDo>> _streamController = StreamController<List<ToDo>>.broadcast();

  StreamSink<List<ToDo>> get sink => _streamController.sink;

  Stream<List<ToDo>> get stream => _streamController.stream;

  ToDoController(){
    sink.add(todosList);
  }

  addItem(ToDo newItem){

    todosList.add(newItem);
    sink.add(todosList);  //always observe the list
  }

  deleteItem(String id){

    todosList.removeWhere((element) => element.id == id);
    sink.add(todosList);  //always observe the list
  }

  updateItem(ToDo item){
    item.isDone = !item.isDone;
    sink.add(todosList);  //always observe the list
  }

  int size(){
    return todosList.length;
  }

}