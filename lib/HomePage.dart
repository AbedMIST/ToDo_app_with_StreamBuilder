
import 'package:flutter/material.dart';
import 'package:to_do_app/ToDoItems.dart';
import 'package:to_do_app/todo.dart';

import 'ToDoController.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:avatar_glow/avatar_glow.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late final ToDoController todoController;

  @override
  void initState() {
    todoController=ToDoController();  //instance created lately
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final textController = TextEditingController();

    return Scaffold(
      backgroundColor: Color(0xFF7cded6),
      appBar: AppBar(
        backgroundColor: Color(0xFF0ec3e3) ,
        title: Text("ToDo App(StreamBuilder)"),
        centerTitle: true,
      ),

      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Column(

              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextField(
                    onChanged: (value){

                    },
                    decoration: InputDecoration(

                      contentPadding: EdgeInsets.all(0),
                      prefixIcon: Icon(
                        Icons.search,
                        size: 21,
                      ),
                      prefixIconConstraints: BoxConstraints(
                        maxHeight: 20,
                        minWidth: 25
                      ),
                      border: InputBorder.none,
                      hintText: "Search",
                      hintStyle: TextStyle(color: Colors.grey),

                    ),
                  ),
                ),

                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: EdgeInsets.only(
                      top: 35,
                      bottom: 20,
                    ),
                    child: StreamBuilder(                     //1st stream builder
                      stream: todoController.stream,
                      builder: (context, snap) {
                        return Text(
                            "All ToDos: ${todoController.size()}",
                            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
                        );
                      }
                    ),
                  ),
                ),

                StreamBuilder(                         //second stream builder
                  stream: todoController.stream,    // listen to your stream
                  initialData: [ToDo(id: "1", todoText: "Morning walk", isDone: true),],
                  builder: (BuildContext context,snapshot) {

                    if (snapshot.hasData) {  // Stream has emitted data
                      var values = snapshot.data!;
                      // Build your UI based on the data
                      return Column(
                        children: values.map((e) => ToDoItems(
                            onToDoChanged: updateToDo,  //callback func send
                            onDelete: deleteToDo,
                            todo: e,
                          ),
                        ).toList(),

                      ); //Update UI

                    }
                    else if (snapshot.hasError) {  // Stream has encountered an error
                      return Text('Error: ${snapshot.error}');
                    }
                    else {      // Stream is still loading
                      return const SizedBox.shrink();
                    }
                  },
                ),

              ],
            )
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    bottom: 20,
                    left: 10,
                  ),
                  child: AvatarGlow(
                    endRadius: 30.0,
                    animate: true,
                    duration: Duration(microseconds: 2000),
                    glowColor: Colors.blue,
                    repeat: true,
                    repeatPauseDuration: Duration(milliseconds: 100),
                    showTwoGlows: true,
                    child: CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: IconButton(
                        icon: Icon(Icons.mic, size: 25, color: Colors.white),
                        onPressed: (){
                          textController.text = "Abed";
                        },
                      ),
                    ),
                  ),

                ),
                Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(
                        bottom: 20,
                        right: 20,
                        left: 20,
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 0.0),
                          blurRadius: 10.0,
                          spreadRadius: 0.0,
                        ),],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: textController,
                        decoration: InputDecoration(
                          hintText: "Add a new ToDo item",
                          border: InputBorder.none,
                        ),
                      ),
                    )
                ),
                Container(
                  margin: EdgeInsets.only(
                    bottom: 20,
                    right: 20,
                  ),
                  child: ElevatedButton(
                    child: Text("+", style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),),
                    onPressed: (){
                      print(textController.text);
                      print(DateTime.now().millisecondsSinceEpoch.toString());
                      todoController.addItem(ToDo(
                          id: DateTime.now().millisecondsSinceEpoch.toString(),
                          todoText: textController.text),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blueAccent,
                      minimumSize: Size(60, 60),
                      elevation: 10,
                    ),
                  ),
                )
              ],
            ),
          )

        ],
      ),
    );
  }

  //callback methods
  void updateToDo(ToDo item){
    todoController.updateItem(item);
  }
  void deleteToDo(String id){
    todoController.deleteItem(id);
  }
}
