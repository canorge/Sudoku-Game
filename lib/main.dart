import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sudoku_oyunu/sudoku.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Sudoku Oyunu'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Random random=Random();
  int emptySquares=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(widget.title),
      ),
      body: Center(
        child:Container(
          margin: EdgeInsets.all(50),
        child: Column(
          children: [
            Text("Zorluk seçiniz",style: TextStyle(fontSize: 20),),
            SizedBox(height: 50,),
            ElevatedButton(onPressed: (){
               emptySquares=random.nextInt(6)+30;
               Navigator.push(context, MaterialPageRoute(builder: (context)=> Sudoku(emptySquares: emptySquares)));
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 50.0,vertical: 10.0),
                backgroundColor: Colors.grey,
                shadowColor: Colors.black, // gölge rengi
                elevation: 8, // gölge mesafesi
              ), 
              child: Text("Kolay",style: TextStyle(fontSize: 25,color: Colors.white))),
            SizedBox(height: 30,),
            ElevatedButton(onPressed: (){
               emptySquares=random.nextInt(6)+30;
               Navigator.push(context, MaterialPageRoute(builder: (context)=> Sudoku(emptySquares: emptySquares)));
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 50.0,vertical: 10.0),
                backgroundColor: Colors.grey,
                shadowColor: Colors.black, // gölge rengi
                elevation: 8, // gölge mesafesi
              ), 
              child: Text("Orta",style: TextStyle(fontSize: 25,color: Colors.white))),
            SizedBox(height: 30,),
          ElevatedButton(onPressed: (){
               emptySquares=random.nextInt(6)+30;
               Navigator.push(context, MaterialPageRoute(builder: (context)=> Sudoku(emptySquares: emptySquares)));
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 50.0,vertical: 10.0),
                backgroundColor: Colors.grey,
                shadowColor: Colors.black, // gölge rengi
                elevation: 8, // gölge mesafesi
              ), 
              child: Text("Zor",style: TextStyle(fontSize: 25,color: Colors.white))),
          ],
        ),
      )
    )
    );
  }
}