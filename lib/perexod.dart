import 'package:flutter/material.dart';
import 'package:todo/menu.dart';
import 'package:todo/menu2.dart';

class Perexod extends StatefulWidget {
  const Perexod({super.key});

  @override
  State<Perexod> createState() => _PerexodState();
}

class _PerexodState extends State<Perexod> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Menu()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 0,
            ),
            Container(
              child: Column(
                children: [
                  Text(
                    "To-do",
                    style: TextStyle(
                      fontSize: 50,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(
                    Icons.trending_up_outlined,
                    color: Colors.blue,
                    size: 60,
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.display_settings_sharp,
                    color: Colors.blue,
                  ),
                  Text(
                    " {Your daily routine}",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.blue),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
