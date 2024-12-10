import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:todo/themeprovader.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  TextEditingController _text = TextEditingController();
  TextEditingController _edit = TextEditingController();
  static ThemeMode _themeMode = ThemeMode.light;

  bool chek = false;
  List<dynamic> todos = [];

  @override
  void initState() {
    super.initState();
    Gettodo();
  }

  Future<void> Edit(int cnt) async {
    var editt = await http.put(
        Uri.parse("https://to-dos-api.softclub.tj/api/categories"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'id': cnt,
          'name': _edit.text,
        }));
    if (editt.statusCode == 200) {
      Gettodo();
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.info(
          icon: Icon(Icons.edit,
              color: Color.fromARGB(144, 252, 252, 252), size: 120),
          backgroundColor: Colors.blue,
          message: 'Edit To-Do',
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Something went Wrong !!!!",
            style: TextStyle(
              color: Colors.red,
            ),
          ),
        ),
      );
    }
  }

  Future<void> Gettodo() async {
    try {
      var response = await http
          .get(Uri.parse("https://to-dos-api.softclub.tj/api/categories"));
      if (response.statusCode == 200) {
        setState(() {
          todos = jsonDecode(response.body)['data'];
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Error"),
        ));
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
          'name': _text.text,
        }));

    if (respon.statusCode == 200) {
      _text.clear();
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.info(
          icon: Icon(Icons.clear,
              color: Color.fromARGB(144, 252, 252, 252), size: 120),
          backgroundColor: Colors.green,
          message: 'ADD To-Do',
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Something went Wrong !!!!",
            style: TextStyle(
              color: Colors.red,
            ),
          ),
        ),
      );
    }
  }

  Future<void> delete({required id}) async {
    try {
      var res = await http.delete(
        Uri.parse("https://to-dos-api.softclub.tj/api/categories?id=${id}"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
      );
      if (res.statusCode == 200) {
        Gettodo();
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.info(
            icon: Icon(Icons.delete,
                color: Color.fromARGB(144, 252, 252, 252), size: 120),
            backgroundColor: Colors.red,
            message: 'Delete To-Do',
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Error"),
        ));
      }
    } catch (e) {}
  }

  bool st1 = false;
  bool st2 = false;
  bool st3 = false;
  bool st4 = false;
  bool st5 = false;
  Function(BuildContext)? deletfunction;
  bool swich = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: Builder(builder: (context) {
          return IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: Icon(Icons.menu, color: Colors.white, size: 34),
          );
        }),
        centerTitle: true,
        title: Text(
          "To-Do  ",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),
        ),
      ),
      drawer: Drawer(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  Icons.bubble_chart_outlined,
                  color: Colors.white,
                  size: 30,
                ),
                Text(
                  "To-do",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.white),
                )
              ],
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Column(
              children: [
                Row(
                  children: [
                    Switch(
                      activeColor: Colors.blue,
                      value: swich,
                      onChanged: (value) {
                        Provider.of<Themeprovader>(context, listen: false)
                            .toggleTheme;
                        {}
                      },
                    ),
                    Text(
                      "  Dark mode",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.blue),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.blue,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "To evaluate",
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: () {
                            setState(() {
                              st1 = !st1;
                            });
                          },
                          child: st1 == false
                              ? Icon(
                                  Icons.star_border_outlined,
                                  size: 30,
                                  color: Colors.blue,
                                )
                              : Icon(
                                  Icons.star,
                                  size: 30,
                                  color: Colors.blue,
                                )),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                          onTap: () {
                            setState(() {
                              if (st1 == true) {
                                st2 = !st2;
                              }
                            });
                          },
                          child: st2 == false
                              ? Icon(
                                  Icons.star_border_outlined,
                                  size: 30,
                                  color: Colors.blue,
                                )
                              : Icon(
                                  Icons.star,
                                  size: 30,
                                  color: Colors.blue,
                                )),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                          onTap: () {
                            setState(() {
                              if (st2 == true) {
                                st3 = !st3;
                              }
                            });
                          },
                          child: st3 == false
                              ? Icon(
                                  Icons.star_border_outlined,
                                  size: 30,
                                  color: Colors.blue,
                                )
                              : Icon(
                                  Icons.star,
                                  size: 30,
                                  color: Colors.blue,
                                )),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                          onTap: () {
                            setState(() {
                              if (st3 == true) {
                                st4 = !st4;
                              }
                            });
                          },
                          child: st4 == false
                              ? Icon(
                                  Icons.star_border_outlined,
                                  size: 30,
                                  color: Colors.blue,
                                )
                              : Icon(
                                  Icons.star,
                                  size: 30,
                                  color: Colors.blue,
                                )),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                          onTap: () {
                            setState(() {
                              if (st4 == true) {
                                st5 = !st5;
                              }
                            });
                          },
                          child: st5 == false
                              ? Icon(
                                  Icons.star_border_outlined,
                                  size: 30,
                                  color: Colors.blue,
                                )
                              : Icon(
                                  Icons.star,
                                  size: 30,
                                  color: Colors.blue,
                                )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      body: todos.isEmpty
          ? Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 660,
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            return Slidable(
                              startActionPane: ActionPane(
                                  motion: StretchMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (context) {
                                        setState(() {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: TextField(
                                                    decoration: InputDecoration(
                                                        border: OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15)),
                                                        hintText: "name To-Do",
                                                        hintStyle: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 20,
                                                            color: const Color
                                                                .fromARGB(97,
                                                                33, 149, 243))),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20,
                                                        color: Colors.blue),
                                                    controller: _edit,
                                                  ),
                                                  actions: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                            setState(() {
                                                              Edit(todos[index]
                                                                  ['id']);
                                                              Gettodo();
                                                              _edit.clear();
                                                            });
                                                          },
                                                          child: Text(
                                                            "save",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 20,
                                                                color: Colors
                                                                    .blue),
                                                          ),
                                                        ),
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text(
                                                            "cancel",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 20,
                                                                color: Colors
                                                                    .blue),
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                );
                                              });
                                        });
                                      },
                                      icon: Icons.edit,
                                      backgroundColor: Colors.blue,
                                      borderRadius: BorderRadius.circular(50),
                                    )
                                  ]),
                              endActionPane: ActionPane(
                                  motion: StretchMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (context) {
                                        setState(() {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: Text(
                                                    textAlign: TextAlign.center,
                                                    "You have definitely agreed ??? ",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20,
                                                        color: Colors.red),
                                                  ),
                                                  actions: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                            setState(() {
                                                              delete(
                                                                  id: todos[
                                                                          index]
                                                                      ['id']);
                                                              Gettodo();
                                                            });
                                                          },
                                                          child: Text(
                                                            "oky",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 20,
                                                                color: Colors
                                                                    .blue),
                                                          ),
                                                        ),
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text(
                                                            "cancel",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 20,
                                                                color: Colors
                                                                    .blue),
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                );
                                              });
                                        });
                                      },
                                      icon: Icons.delete,
                                      backgroundColor: Colors.red.shade400,
                                      borderRadius: BorderRadius.circular(50),
                                    )
                                  ]),
                              child: Container(
                                child: Card(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: ListTile(
                                      leading: RoundCheckBox(
                                        size: 26,
                                        onTap: (p0) {},
                                      ),
                                      title: Text(
                                        todos[index]['name'],
                                        style: TextStyle(
                                            // decoration:
                                            //     TextDecoration.lineThrough,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            {
                              return SizedBox(
                                height: 10,
                              );
                            }
                          },
                          itemCount: todos.length),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Container(
                            width: 270,
                            height: 70,
                            child: TextField(
                              controller: _text,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                hintText: "Add a new todo items",
                                hintStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: const Color.fromARGB(74, 33, 149, 243),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        FloatingActionButton(
                          backgroundColor: Colors.blue,
                          onPressed: () {
                            addTodo();
                            Gettodo();
                          },
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
