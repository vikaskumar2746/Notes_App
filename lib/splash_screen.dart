import 'dart:async';

import 'package:flutter/material.dart';
import 'package:untitled/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState(){
    super.initState();
    Timer(Duration(seconds: 2), () {
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
        backgroundColor: Colors.teal,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              CircleAvatar(
                backgroundColor: Colors.white38,
                radius: 130,
                child: Image.asset(
                  'assets/images/notes.jpg',
                  width: 200,
                  height: 200,
                ),
              ),
              SizedBox(height: 10,),
              Text("Welcome to notes app !",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
              SizedBox(height: 110),
              // Developed by text
              Text(
                'Developed by Vikas Kumar !',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
    );
  }
}

