import 'package:flutter/material.dart';
import 'package:sudoku_solver_generator/sudoku_solver_generator.dart';
import 'package:sudoku_oyunu/main.dart';

class Sudoku extends StatefulWidget {
  final int emptySquares;
  const Sudoku({super.key, required this.emptySquares});
  @override
  State<Sudoku> createState() => _SudokuState();
}

class _SudokuState extends State<Sudoku> {
  late SudokuGenerator generator;
  late List<List<int>> puzzle;
  late List<List<int>> solution;
  late List<List<String>> userInput;
  int yanlisSayisi=0;
  final double cellSize = 40;

  @override
  void initState() {
    super.initState();
    generateNewSudoku();
  }

  void generateNewSudoku() {
    setState(() {
      generator = SudokuGenerator(emptySquares: widget.emptySquares);
      puzzle = generator.newSudoku;
      solution = generator.newSudokuSolved;
      userInput = List.generate(9, (_) => List.generate(9, (_) => ''));
    });
  }

  void checkInput() {
    bool isCorrect = true;
    for (int i = 0; i < 9; i++) {
      for (int j = 0; j < 9; j++) {
        if (puzzle[i][j] == 0) {
          if (int.tryParse(userInput[i][j]) != solution[i][j]) {
            isCorrect = false;
          }
        }
      }
    }
    if(isCorrect == false ){
      setState(() {
        yanlisSayisi++;
      });
    } 

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(isCorrect ? 'Tebrikler!' : 'Yanlış Girişler Var' ),
        content: Text(isCorrect ? "Doğru çözdün" : "Hatalar var"),
        actions: [
          TextButton(
  onPressed: () {
    Navigator.pop(context); // Önce dialogu kapat

    if (yanlisSayisi >= 3) {
        // Yanlış sayısı 3 veya daha fazla ise ana menüye dön ve Sudoku sayfasını stack'ten kaldır
        Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => MyHomePage(title: "Sudoku Oyunu",)), // AnaMenu senin ana menü sayfan
        (route) => false,
      );
    }
    // Yanlış sayısı 3'ten küçükse hiçbir şey yapma, oyun devam eder
  },
  child: Text('Tamam'),
),

        ],
      ),
    );
  }

  Widget buildGrid() {
    return SizedBox(
      width: cellSize * 9,
      height: cellSize * 9,
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: 81,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 9,
        ),
        itemBuilder: (context, index) {
          int row = index ~/ 9;
          int col = index % 9;
          int value = puzzle[row][col];
          bool isEditable = value == 0;

          return Container(
            width: cellSize,
            height: cellSize,
            decoration: BoxDecoration(
              color: isEditable ? Colors.white : Colors.grey[300],
              border: Border(
                top: BorderSide(
                    width: (row % 3 == 0) ? 2 : 0.5, color: Colors.black),
                left: BorderSide(
                    width: (col % 3 == 0) ? 2 : 0.5, color: Colors.black),
                right: BorderSide(
                    width: (col == 8) ? 2 : 0.5, color: Colors.black),
                bottom: BorderSide(
                    width: (row == 8) ? 2 : 0.5, color: Colors.black),
              ),
            ),
            child: Center(
              child: isEditable
                  ? TextField(
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      keyboardType: TextInputType.number,
                      style: TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        counterText: '',
                        contentPadding: EdgeInsets.zero,
                      ),
                      onChanged: (val) {
                        if (val.length == 1 && int.tryParse(val) != null) {
                          userInput[row][col] = val;
                        } else {
                          userInput[row][col] = '';
                        }
                      },
                    )
                  : Text(
                      '$value',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sudoku Oyunu"),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child:Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Text("Yanlış Hakkı 3/$yanlisSayisi",style: TextStyle(fontSize: 20),),
            SizedBox(height: 30,),
            buildGrid(),
            SizedBox(height: 40),
            ElevatedButton(onPressed: (){
               checkInput();
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 50.0,vertical: 10.0),
                backgroundColor: Colors.grey,
                shadowColor: Colors.black, // gölge rengi
                elevation: 8, // gölge mesafesi
              ), 
              child: Text("Kontrol Et",style: TextStyle(fontSize: 20,color: Colors.white))),
            SizedBox(height: 20),
            ElevatedButton(onPressed: (){
               generateNewSudoku();
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 50.0,vertical: 10.0),
                backgroundColor: Colors.grey,
                shadowColor: Colors.black, // gölge rengi
                elevation: 8, // gölge mesafesi
              ), 
              child: Text("Yeni Oyun",style: TextStyle(fontSize: 20,color: Colors.white))),
          ],
        ),
      ),
    )
    );
  }
}
