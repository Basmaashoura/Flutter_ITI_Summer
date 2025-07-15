import 'package:flutter/material.dart';

class TaskTracker extends StatelessWidget {
  TaskTracker({super.key});

  final List tasks = [
    {"task": "eat", "time": "5:30pm"},
    {"task": "drink", "time": "7:30pm"},
    {"task": "sleep", "time": "9:30pm"},
    {"task": "eat", "time": "5:30pm"},
    {"task": "drink", "time": "7:30pm"},
    {"task": "sleep", "time": "9:30pm"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Tracker'),
        titleTextStyle: TextStyle(
          fontFamily: 'mahameru',
          color: Colors.blueGrey,
          fontSize: 30,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add_circle_outline_rounded),
            iconSize: 40,
            padding: EdgeInsets.only(bottom: 10, right: 20),
            color: Colors.blueGrey,
          ),
        ],
      ),
      body: Container(
        height: 800,
        width: 500,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            return Container(
              height: 70,
              color: Colors.blueGrey,
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      '${tasks[index]['task']} - ${tasks[index]['time']}',
                        style: TextStyle(
                        fontFamily: "mahameru",
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.check_box_outline_blank_outlined),
                    color: Colors.white,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.delete_outline),
                    color: Colors.white,)
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}