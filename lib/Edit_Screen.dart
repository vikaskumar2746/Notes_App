import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/Detail_screen.dart';
import 'package:untitled/home_screen.dart';
import 'package:untitled/note_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/notes_provider.dart';
class EditNote extends StatefulWidget {
  final NoteModel note;
   EditNote({required this.note});
  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
    late TextEditingController titleController;
    late TextEditingController descController;
  @override
    void initState(){
      super.initState();
      titleController= TextEditingController(text: widget.note.title);
      descController = TextEditingController(text: widget.note.desc);
    }
    @override
    void dispose(){
    titleController.dispose();
    descController.dispose();
    super.dispose();
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text("Edit Note"),
      ),
      body:  Padding(
        padding: const EdgeInsets.all(16.0),
    child: Column(
    children: [
    // Title TextField
    TextField(
    controller: titleController,
    cursorColor: Colors.teal,
    decoration: InputDecoration(
    labelText: 'Title',
    hintText: 'Enter note title',
    labelStyle: TextStyle(color: Colors.teal),
    floatingLabelStyle: TextStyle(color: Colors.tealAccent),
    focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.teal, width: 2),
    borderRadius: BorderRadius.circular(10),
    ),
    enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
    borderRadius: BorderRadius.circular(10),
    ),
    ),
    ),
    SizedBox(height: 20),
    // Description TextField
    TextField(
    controller: descController,
    cursorColor: Colors.teal,
    maxLines: null, // Multi-line text
    decoration: InputDecoration(
    labelText: 'Description',
    hintText: 'Enter note description',
    labelStyle: TextStyle(color: Colors.teal),
    floatingLabelStyle: TextStyle(color: Colors.tealAccent),
    focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.teal, width: 2),
    borderRadius: BorderRadius.circular(10),
    ),
    enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
    borderRadius: BorderRadius.circular(10),
    ),
    ),
    ),
     SizedBox(
       height: 20,
     ),
      InkWell(
        onTap: () {
          String newTitle = titleController.text.toString();
          String newDesc = descController.text.toString();
          if(newTitle.isEmpty||newDesc.isEmpty){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Title and Description can not be null")));
          }
          else {
            Provider.of<NoteProvider>(context, listen: false).updateNote(
                widget.note, newTitle, newDesc);
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
          }
        },
        child: Container(
          height: 40,
          width: MediaQuery.of(context).size.width*0.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.lightBlueAccent
          ),
          child: Center(child: Text('Save',style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),)),
        ),

      )
    ],
    ),
    ),

    );
  }
}
