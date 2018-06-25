import '../game/game.dart';
import 'dart:async';

import 'package:flutter/material.dart';

class Launcher extends StatefulWidget {
  @override
  LauncherState createState() => new LauncherState();
}
class LauncherState extends State<Launcher>{
//  final FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();
/*  @override
  void initState(){
    super.initState();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) {
        print("onMessage: $message");
        _showItemDialog(context,message);
      },
      onLaunch: (Map<String, dynamic> message){
        print("onLaunch: $message");
        Navigator.pushNamed(context,'singelGame');
      },
      onResume: (Map<String, dynamic> message){
        print("onResume: $message");
      },
    );
  } */

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar( 
        title: Text("Tic Tac Toe"),
        backgroundColor: Colors.deepOrange,
      ),
      body: new Container(
        
        color: Colors.orange[50],
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new RaisedButton(
                elevation: 15.0,
                
                shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(23.0)),
                color: Colors.deepOrange,
                onPressed: (){
                 Navigator.of(context).pushNamed('singleGame'); 
                },
                padding: EdgeInsets.all(8.0),
                child: new Text(
                  'Single mode',
                  style: new TextStyle(fontSize: 32.0,color: Colors.white70)
                  ),
              ),
              new RaisedButton(
                elevation: 15.0,
                shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(23.0)),
                color: Colors.deepOrange,
                onPressed: (){
                 Navigator.of(context).pushNamed('multiplayerGame'); 
                },
                padding: EdgeInsets.all(8.0),
                child: new Text(
                  'Multiplayer mode',
                  style: new TextStyle(fontSize: 32.0,color: Colors.white70),
                  ),
              )
            ],
          ),
        ),
      ),
    );
  }
}