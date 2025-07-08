import 'package:flutter/material.dart';

class Chats extends StatelessWidget {
  const Chats({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Whatsapp'),
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 30
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add_comment_outlined),
            iconSize: 35,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert_outlined),
            iconSize: 35,
          )
        ],
      ),

      body:Padding(
        // padding: EdgeInsets.only(left: 30, right: 30, top: 10),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              // spacing: 3,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage("asset/images/person.png"),
                      radius: 30,
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Layla', style: TextStyle(fontSize: 20)),
                          Text('Hello!', style: TextStyle(color: Colors.grey, fontSize: 15)),
                        ],
                      ),
                    ),
                    Text('5:30 pm', style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage("asset/images/person.png"),
                        radius: 30,
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Layla', style: TextStyle(fontSize: 20)),
                            Text('Hello!', style: TextStyle(color: Colors.grey, fontSize: 15)),
                          ],
                        ),
                      ),
                      Text('5:30 pm', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage("asset/images/person.png"),
                        radius: 30,
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Layla', style: TextStyle(fontSize: 20)),
                            Text('Hello!', style: TextStyle(color: Colors.grey, fontSize: 15)),
                          ],
                        ),
                      ),
                      Text('5:30 pm', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage("asset/images/person.png"),
                        radius: 30,
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Layla', style: TextStyle(fontSize: 20)),
                            Text('Hello!', style: TextStyle(color: Colors.grey, fontSize: 15)),
                          ],
                        ),
                      ),
                      Text('5:30 pm', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage("asset/images/person.png"),
                        radius: 30,
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Layla', style: TextStyle(fontSize: 20)),
                            Text('Hello!', style: TextStyle(color: Colors.grey, fontSize: 15)),
                          ],
                        ),
                      ),
                      Text('5:30 pm', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage("asset/images/person.png"),
                        radius: 30,
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Layla', style: TextStyle(fontSize: 20)),
                            Text('Hello!', style: TextStyle(color: Colors.grey, fontSize: 15)),
                          ],
                        ),
                      ),
                      Text('5:30 pm', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage("asset/images/person.png"),
                        radius: 30,
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Layla', style: TextStyle(fontSize: 20)),
                            Text('Hello!', style: TextStyle(color: Colors.grey, fontSize: 15)),
                          ],
                        ),
                      ),
                      Text('5:30 pm', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage("asset/images/person.png"),
                        radius: 30,
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Layla', style: TextStyle(fontSize: 20)),
                            Text('Hello!', style: TextStyle(color: Colors.grey, fontSize: 15)),
                          ],
                        ),
                      ),
                      Text('5:30 pm', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage("asset/images/person.png"),
                        radius: 30,
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Layla', style: TextStyle(fontSize: 20)),
                            Text('Hello!', style: TextStyle(color: Colors.grey, fontSize: 15)),
                          ],
                        ),
                      ),
                      Text('5:30 pm', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage("asset/images/person.png"),
                        radius: 30,
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Layla', style: TextStyle(fontSize: 20)),
                            Text('Hello!', style: TextStyle(color: Colors.grey, fontSize: 15)),
                          ],
                        ),
                      ),
                      Text('5:30 pm', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage("asset/images/person.png"),
                        radius: 30,
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Layla', style: TextStyle(fontSize: 20)),
                            Text('Hello!', style: TextStyle(color: Colors.grey, fontSize: 15)),
                          ],
                        ),
                      ),
                      Text('5:30 pm', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage("asset/images/person.png"),
                        radius: 30,
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Layla', style: TextStyle(fontSize: 20)),
                            Text('Hello!', style: TextStyle(color: Colors.grey, fontSize: 15)),
                          ],
                        ),
                      ),
                      Text('5:30 pm', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage("asset/images/person.png"),
                        radius: 30,
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Layla', style: TextStyle(fontSize: 20)),
                            Text('Hello!', style: TextStyle(color: Colors.grey, fontSize: 15)),
                          ],
                        ),
                      ),
                      Text('5:30 pm', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }
}