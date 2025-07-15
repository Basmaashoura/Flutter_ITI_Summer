import 'package:flutter/material.dart';
import 'package:task_manager/tasks_screen.dart';
import 'package:task_manager/notes_screen.dart';

class home_screen extends StatelessWidget {
  const home_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.blueGrey)),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          // mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MaterialButton(
              color: Colors.blueGrey,
              textColor: Colors.white,
              padding: EdgeInsets.all(20),
              minWidth: 250,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => tasks_screen(title: "Tasks Screen")));
              }, child: Text("To Tasks", style: TextStyle(fontSize: 40),),
            ), SizedBox(height: 20,),
            MaterialButton(
              color: Colors.blueGrey,
              textColor: Colors.white,
              padding: EdgeInsets.all(20),
              minWidth: 250,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => notes_screen(title: "Notes Screen")));
              }, child: Text("To Notes", style: TextStyle(fontSize: 40),),
            )
          ]
        ),
      ),
    );
  }
}
