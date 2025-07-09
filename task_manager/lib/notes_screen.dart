import 'package:flutter/material.dart';

class notes_screen extends StatefulWidget {
  const notes_screen({super.key, required this.title});

  final String title;

  @override
  State<notes_screen> createState() => _notes_screen();
}

class Note {
  String title;
  String description;

  Note({required this.title, required this.description});
}

class _notes_screen extends State<notes_screen> {
  final List<Note> notes = [];

  final TextEditingController note_title = TextEditingController();
  final TextEditingController note_description = TextEditingController();

  void _addNoteDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Add New Note',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
              ),
              TextFormField(
                controller: note_title,
                decoration: InputDecoration(hintText: 'Enter note title'),
              ),
              TextFormField(
                controller: note_description,
                decoration: InputDecoration(hintText: 'Enter note description'),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MaterialButton(
                    onPressed: () {
                      if (note_title.text.isNotEmpty &&
                          note_description.text.isNotEmpty) {
                        setState(() {
                          notes.add(Note(
                            title: note_title.text,
                            description: note_description.text,
                          ));
                        });
                        Navigator.of(context).pop();
                      }
                    },
                    color: Colors.blueGrey,
                    textColor: Colors.white,
                    child: Text("Add Note"),
                  ),
                  MaterialButton(
                    onPressed: () => Navigator.of(context).pop(),
                    color: Colors.redAccent,
                    textColor: Colors.white,
                    child: Text("Cancel"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _deleteNote(int index) {
    setState(() {
      notes.removeAt(index);
    });
  }
  void _noteDetailsDialog(Note note) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(note.title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        content: Text(note.description, style: TextStyle(fontSize: 18)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("Close"),
          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notes Page",
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey,
          ),
        ),
        centerTitle: true,
      ),
      body: notes.isEmpty
          ? Center(child: Text("No notes yet. Tap + to add one."))
          : ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];
                return ListTile(
                  title: Text(
                    note.title,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey,
                    ),
                  ),
                  subtitle: Text(
                    note.description,
                    style: TextStyle(fontSize: 18),
                  ),
                  leading: IconButton(
                    icon: Icon(Icons.note, size: 30, color: Colors.blueGrey),
                    onPressed: () {},
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.black),
                    onPressed: () => _deleteNote(index),
                  ),
                  onTap: () {
                    _noteDetailsDialog(note);
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNoteDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}
