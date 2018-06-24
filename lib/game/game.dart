import 'package:flutter/material.dart';
import '../main.dart';
import 'dart:io';
import '../ai/ai.dart';
import '../constants/constants.dart';
import '../victory/victory_checker.dart';
import '../victory/victory.dart';
import '../victory/victory_line.dart';
import 'dart:async';
class Game extends StatefulWidget {
  @override
  GameState createState() => new GameState();
}

class GameState extends State<Game> {

  BuildContext _context;
  List<List<String>> field=[
    ['','','',''],
    ['','','',''],
    ['','','','']
  ];
  Color playerColor,aiColor;
  AI ai;
  String playerChar='X',aiChar='O';
  bool playersTurn = true;
  Victory victory;

  @override
  Widget build(BuildContext context){
    ai = new AI(field, playerChar, aiChar);
    //Color playerColor = Colors.indigo;
    aiColor = Colors.deepPurpleAccent;
    return new Scaffold(
      appBar:new AppBar(
        title: new Text("Tic Tac Toe"),
      ),
      body: new Builder( builder: (BuildContext context){
        _context = context;
        return new Center(
          child:new Stack(
            children: <Widget>[
              buildGrid(),
              buildField(),
              buildVictoryLine(),
            ],
          ) ,
        );
      })
    );
  }
Widget buildGrid(){
  return new AspectRatio(
    aspectRatio: 1.0,
    child: new Stack(
      children: [
        new Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            new Container(
              margin: const EdgeInsets.only(left: 16.0,right: 16.0),
              color: Colors.deepOrangeAccent,
              height: 5.0,
            ),
            new Container(
              margin: const EdgeInsets.only(left: 16.0,right: 16.0),
              color: Colors.deepOrangeAccent,
              height: 5.0,
            ),
          ],
        ),
        new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:[
            new Container(
              margin: const EdgeInsets.only(top: 16.0,bottom: 16.0),
              color: Colors.deepOrangeAccent,
              width: 5.0,
            ),
            new Container(
              margin: const EdgeInsets.only(top: 16.0,bottom: 16.0),
              color: Colors.deepOrangeAccent,
              width: 5.0,
            ),
          ],
          
        )
      ],
    ),
  );
}

Widget buildField(){
  return new AspectRatio(
    aspectRatio: 1.0,
    child: new Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        new Expanded(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            buildCell(0,0),
            buildCell(0,1),
            buildCell(0,2),
          ],
        ),
        ),
        new Expanded(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            buildCell(1,0),
            buildCell(1,1),
            buildCell(1,2),
          ],
        ),
        ),
        new Expanded(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            buildCell(2,0),
            buildCell(2,1),
            buildCell(2,2),
          ],
        ),
        ),
      ],
    ),
  );
}

Widget buildCell(int row,int column){
  Color color =Theme.of(context).primaryColor; 
  return new AspectRatio(
    aspectRatio: 1.0,
    child: new MaterialButton(
      onPressed: (){
        if(!_gameIsDone() && playersTurn){
          setState(() {
            _displayPlayersTurn(row,column);
            if(!_gameIsDone()){
              _displayAiTurn();
            }            
          });
        }
      },
      child: new Text(
        field[row][column],
        style: new TextStyle(
          fontSize: 82.0,
          fontFamily: 'Chalk',
          color: field[row][column].isNotEmpty && field[row][column]==playerChar
          ? Colors.amber
          :aiColor,
        ),
      ),
    ),
  );
  }
  Widget buildVictoryLine(){
    return new AspectRatio(
      aspectRatio: 1.0,
      child: new CustomPaint(painter: new VictoryLine(victory),),
    );
  }
  void _displayPlayersTurn(int row,int column) {
    print('clicked on row $row and column $column');
    playersTurn=false;
    if(field[row][column]==playerChar||field[row][column]==aiChar)
    {
      playersTurn=true;
      return;
    }
    field[row][column] = playerChar;
    _checkForVictory();
  }
  void _displayAiTurn(){
    if(!playersTurn){
    new Timer(const Duration(milliseconds: 600),(){
      setState(() {
       //Ai
       var aiDecision=ai.getDecision();
       field[aiDecision.row][aiDecision.column] = aiChar;
       playersTurn=true;
       _checkForVictory();       
      });
    });
    }
  }
  bool _gameIsDone(){
    return _allCellsAreTaken() || victory!=null ;
  }
  bool _allCellsAreTaken(){
    return field[0][0].isNotEmpty &&
            field[0][1].isNotEmpty &&
            field[0][2].isNotEmpty &&
            field[1][0].isNotEmpty &&
            field[1][1].isNotEmpty &&
            field[1][2].isNotEmpty &&
            field[2][0].isNotEmpty &&
            field[2][1].isNotEmpty &&
            field[2][2].isNotEmpty;
  }
  void _checkForVictory(){
    victory = VictoryChecker.checkForVictory(field,playerChar);
    if(victory != null){
      String message;
      if(victory.winner == Constants.PLAYER){
        message='You Win !';
      }else if(victory.winner==Constants.AI){
        message='You Lose !';
      }
      else if(victory.winner==Constants.DRAFT){
        message = 'Draft';
      }
      print('$message');
       new Timer(const Duration(milliseconds: 100), () {
         alert(message);
        });
      
    }
  }
  Future<Null> alert(var msg) async {
  return showDialog<Null>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return new AlertDialog(
        title: new Text(msg=='Draft'?'Draw':msg),
        content: new SingleChildScrollView(
          child: new ListBody(
            children: <Widget>[
              new Text(msg=='Draft'?'Draw !':msg),
            ],
          ),
        ),
        actions: <Widget>[
          new FlatButton(
            child: new Text('Play Again'),
            onPressed: () {
              setState(() {
                victory=null;
                field = [
                  ['','',''],
                  ['','',''],
                  ['','','']
                ];
                playersTurn =true;              
              });
              Navigator.of(context).pop();
            },
          ),
          new FlatButton(
            child: new Text('Exit'),
            onPressed: () {
              exit(0);
            },
          ),
        ],
      );
    },
  );
}
}
