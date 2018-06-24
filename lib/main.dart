import 'package:flutter/material.dart';
import './game/game.dart';
void main() => runApp(new TicTacToe());

class TicTacToe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Tic Tac Toe',
      theme: new ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: new Game(),
    );
  }
}
