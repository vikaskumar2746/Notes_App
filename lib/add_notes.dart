import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/note_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/notes_provider.dart';
class AddNoteScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    TextEditingController title = TextEditingController();
    TextEditingController desc = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Add note '),
        backgroundColor:Colors.red
       ),
      body: Form(
        key: formKey,
          child:SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 15,
                  children: [
                    SizedBox(
                      height:60,
                    ),
                    TextFormField(
                      autofocus: true,
                      validator: (value) {
                            if(value==null||value.isEmpty){
                            return ' enter title ';
                            }
                            return null;
                            },
                   controller: title,
                      keyboardType: TextInputType.text,
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
                            style:TextStyle(fontWeight: FontWeight.bold) ,             ),
                    TextFormField(

                      controller: desc,
                      keyboardType: TextInputType.text,
                      maxLines: null,
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
                   ElevatedButton(
                       style: ElevatedButton.styleFrom(
                         fixedSize: Size(MediaQuery.of(context).size.width*0.5, 40),
                         backgroundColor: Colors.lightBlue
                       ),
                       onPressed:(){
                   if(formKey.currentState!.validate())
                      {
                        NoteModel xyz = NoteModel(title.text, desc.text);
                        Provider.of<NoteProvider>(context,listen: false).addNote(xyz);
                        Navigator.pop(context);
                      }
                    }, child: Center(child: Text('Save',style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),))
                   ) ],
                ),
              ),
            ),
          )),
    );
  }
}