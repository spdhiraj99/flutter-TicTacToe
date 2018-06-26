import 'package:flutter/material.dart';
import './game/game.dart';
import './launcher/launcher.dart';
void main() => runApp(new TicTacToe());

class TicTacToe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Tic Tac Toe',
      theme: new ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: new Launcher(),
      routes: <String, WidgetBuilder> {
        'singleGame' : (BuildContext context) => new Game(),
        'multiplayerGame' : (BuildContext context) => new Game(),       
      },
    );
  }
}
