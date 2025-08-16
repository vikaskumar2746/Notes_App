import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/note_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
class NoteProvider with ChangeNotifier{
  List<NoteModel> notes = [];
  static const String storageKey="notes_list";
  NoteProvider()
  {
    loadNotes();
  }
 Future<void> addNote ( NoteModel note) async{
    notes.add(note);
  await saveNotes();
    notifyListeners();
  }
  Future<void> deleteNote (NoteModel note) async{
    notes.remove(note);
    await saveNotes();
    notifyListeners();
  }
   Future<void> saveNotes () async{
    final prefs=await SharedPreferences.getInstance();
    List<String> notesJsonList = notes.map((n)=>jsonEncode({"title":n.title,"desc":n.desc}))
    .toList();
   await prefs.setStringList(storageKey,notesJsonList);
   }
   Future<void> loadNotes () async{
    final prefs = await SharedPreferences.getInstance();
    List<String>? notesJsonList = prefs.getStringList(storageKey);
     if(notesJsonList!=null) {
       notes = notesJsonList.map((notesJson) {
         var data= jsonDecode(notesJson);
         return NoteModel(data["title"], data["desc"]);
       }).toList();
       notifyListeners();
     }
   }
   Future<void> updateNote ( NoteModel oldNote,String newTitle, String newDesc ) async{
    int index = notes.indexOf(oldNote);
    if(index!=-1)
      {
        notes[index]= NoteModel(newTitle, newDesc);
        await saveNotes();
        notifyListeners();
      }
   }
}