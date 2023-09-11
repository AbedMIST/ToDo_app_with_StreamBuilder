
class ToDo{
  String? id;
  String? todoText;
  bool isDone;

  ToDo({                  //Constructor
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  // static List<todo> todoList(){  //func return the whole list
  //   return [
  //     todo(id: "1", todoText: "Morning walk", isDone: true),
  //     todo(id: "2", todoText: "Breakfast", isDone: true),
  //     todo(id: "3", todoText: "Check mail"),
  //     todo(id: "4", todoText: "Team morning"),
  //     todo(id: "5", todoText: "Work on mobile app"),
  //     todo(id: "6", todoText: "Lunch with SBU Head."),
  //   ];
  // }

}