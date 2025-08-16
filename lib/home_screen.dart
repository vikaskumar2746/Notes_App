import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/Detail_screen.dart';
import 'package:untitled/Edit_Screen.dart';
import 'package:untitled/note_model.dart';
import 'package:untitled/notes_provider.dart';
import 'package:untitled/theme_changer.dart';
class HomeScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
     appBar: AppBar(
       automaticallyImplyLeading: false,
       title: Center(child: Text('Notes App',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)),

       backgroundColor: Colors.red,
   actions: [
     Consumer<themeChanger>(
         builder: (context,provider,child) {
           return DropdownButton<ThemeMode>(
             value: provider.mode,
             icon: Icon(Icons.color_lens, color: Colors.white),
             dropdownColor: Colors.orange,
             onChanged: (value) {
               provider.changeTheme(value!);
             },
             items:[
               DropdownMenuItem<ThemeMode>(
                   value: ThemeMode.system,
                   child: Text('System')),
               DropdownMenuItem<ThemeMode>(
                   value: ThemeMode.dark,
                   child: Text('Dark')),
               DropdownMenuItem<ThemeMode>(
                   value: ThemeMode.light,
                   child: Text('Light')),
             ],
           );
         }
     ),
   ],
     ),


      body:Consumer<NoteProvider>(
        builder: (context,provider,child) {
          return provider.notes.isEmpty ? Center(
              child: Text('No notes yet!\nClick + to add one.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.grey),),) : ListView
              .builder(
            itemCount: provider.notes.length,
            itemBuilder: (context, index) {
              final note = provider.notes[index];
              return ListTile(
                leading: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text("${index+1}",style: TextStyle(
                      color: Colors.white),),
                  ),
                ),
                title: Text(
                  note.title, style: TextStyle(fontWeight: FontWeight.bold),),
                subtitle: Text(note.desc, overflow: TextOverflow.ellipsis,),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(onPressed: () {
                      showDeleteDialog (context,note);
                    }, icon: Icon(Icons.delete)),
                    IconButton(onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>EditNote(note: note,)));
                    }, icon: Icon(Icons.edit,color: Colors.blue ,))
                  ],
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailNoteScreen(note: note,)));
                },
              );

            },
          );
        }
    ),
      floatingActionButton:FloatingActionButton(
          onPressed: (){
            Navigator.pushNamed(context,'/addNote');
          },
        child:Icon(Icons.add),
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
              Navigator.pop(context);
            }, child: Text('delete'))
      ],
      );
    });
  }
}