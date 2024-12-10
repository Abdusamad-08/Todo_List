import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ToDoApp extends StatefulWidget {
  const ToDoApp({super.key});

  @override
  State<ToDoApp> createState() => _ToDoAppState();
}

class _ToDoAppState extends State<ToDoApp> {
  TextEditingController nameController = TextEditingController();
  List<dynamic> todos = [];

  @override
  void initState() {
    super.initState();
    getAllToDos();
  }

  Future<void> getAllToDos() async {
    try {
      var resp = await http.get(
        Uri.parse("https://to-dos-api.softclub.tj/api/categories"),
      );

      if (resp.statusCode == 200) {
        setState(() {
          todos = jsonDecode(resp.body)['data'];
        });
      } else {
        throw Exception();
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> addTodo() async {
    var respon = await http.post(
        Uri.parse("https://to-dos-api.softclub.tj/api/categories"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'name': nameController.text,
        }));

    Navigator.pop(context);
    if (respon.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.lightGreen,
          content: Text(
            "Successifully addded!!!!",
            style: TextStyle(
              color: Colors.green,
            ),
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Somwthing went Wrong !!!!",
            style: TextStyle(
              color: Colors.red,
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My To Do App"),
      ),
      body: //todos.isNotEmpty
          //     ? Center(
          //         child: CircularProgressIndicator.adaptive(),
          //       )
          //     :
          Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: Checkbox(
                        value: false,
                        onChanged: (newValue) {},
                      ),
                      title:
                          Text("Flutter Exammm"), //Text(todos[index]['name']),
                      subtitle:
                          const Text("Very good description for all todos"),
                      trailing: Container(
                        width: 90,
                        //height: 1000,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.edit,
                                color: Colors.blue,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (contex, index) => const SizedBox(height: 10),
                itemCount: 4, //todos.length,
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (builder) {
                      return AlertDialog(
                        title: TextField(
                          controller: nameController,
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              addTodo();
                            },
                            child: Text(
                              "Add",
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                        // insetPadding: EdgeInsets.all(150),
                        // actionsPadding: EdgeInsets.all(100),
                        // iconPadding: EdgeInsets.all(100),
                        // titlePadding: EdgeInsets.all(100),
                        // buttonPadding: EdgeInsets.all(100),
                        // contentPadding: EdgeInsets.all(100),
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue,
                ),
                child: Text(
                  "Add new ToDo",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
