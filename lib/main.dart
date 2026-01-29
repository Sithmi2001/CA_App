import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AppBody(),
    );
  }
}

class AppBody extends StatefulWidget {
  const AppBody({super.key});

  @override
  State<AppBody> createState() => _AppBodyState();
}

class _AppBodyState extends State<AppBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("App Title", style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),


      body: Center(
        child: Column(
          // Start Project

children: [
  Column(
    children: [
      Text(" hi project "),
      ElevatedButton(onPressed: null, child: Text(
        "next"
      )
      )
    ],
  )
],
        

        ),
      ),
    );
  }
}