import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/Edit_Screen.dart';
import 'package:untitled/home_screen.dart';
import 'package:untitled/note_model.dart';

import 'notes_provider.dart';

class DetailNoteScreen extends StatelessWidget {
 NoteModel note;
  DetailNoteScreen({required this.note});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Note detail"),
        backgroundColor: Colors.deepPurple,
        actions: [
          PopupMenuButton(
        onSelected: (value) {
         if(value=='edit') {
           Navigator.push(context, MaterialPageRoute(builder: (context)=>EditNote(note: note)));
                 }
         else{
           showDeleteDialog (context,note);
         }
    },
              itemBuilder: (BuildContext context)=><PopupMenuEntry<String>>[

            PopupMenuItem<String>(value:'edit', child: Text("Edit")),
            PopupMenuItem<String>(value: 'delete', child: Text("Delete"))
    ]
        )
        ],
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(note.title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),

              maxLines: null,),
              Text(note.desc,style: TextStyle(fontSize: 20),
              maxLines: null,)
            ],
          ),
        ),
      ),
    );
  }

 void showDeleteDialog(BuildContext context, NoteModel note) {
   showDialog(context: context, builder: (context)
   {
     return AlertDialog(
       title: Text("delete note"),
       content: Text("Are you sure You want to delete this note?"),
       actions: [
         TextButton(onPressed: ()
         {
           Navigator.pop(context);
         }, child: Text('cancel')),
         ElevatedButton(
             style: ElevatedButton.styleFrom(
               backgroundColor: Colors.red,

             ),
             onPressed: ()
             {
               Provider.of<NoteProvider>(context,listen: false).deleteNote(note);
               Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
             }, child: Text('delete'))
       ],
     );
   });
 }

}
