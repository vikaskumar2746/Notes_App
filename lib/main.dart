import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/add_notes.dart';
import 'package:untitled/home_screen.dart' ;
import 'package:untitled/notes_provider.dart';
import 'package:untitled/splash_screen.dart';
import 'package:untitled/theme_changer.dart';
void main()
{
  runApp(MyApp());
}
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers:[
        ChangeNotifierProvider<NoteProvider>(
          create:(context) => NoteProvider(),
         ),
          ChangeNotifierProvider<themeChanger>(create: (context) =>  themeChanger())
        ],
        child: Consumer<themeChanger>(
          builder: (context,provider,child) {
            return MaterialApp(
              themeMode: provider.mode,
              darkTheme: ThemeData.dark(),
              debugShowCheckedModeBanner: false,
              routes: {
                '/':(context) => SplashScreen(),
                '/addNote':(context) => AddNoteScreen()
              }
            );
          }
        )
    );
  }
}