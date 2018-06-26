import '../game/game.dart';
import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class Launcher extends StatefulWidget {
  @override
  LauncherState createState() => new LauncherState();
}
class LauncherState extends State<Launcher>{
  final FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();
  @override
  void initState(){
    super.initState();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) {
        print("onMessage: $message");
        _showItemDialog(context,message);
      },
      onLaunch: (Map<String, dynamic> message){
        print("onLaunch: $message");
        Navigator.pushNamed(context,'singleGame');
      },
      onResume: (Map<String, dynamic> message){
        print("onResume: $message");
      },
    );
    _firebaseMessaging.getToken().then((token){
      print(token);
    });
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true,badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
    .listen((IosNotificationSettings settings){
      print("Settings registered: $settings");
    });
  } 

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
  void _showItemDialog(BuildContext context, Map<String, dynamic> message) {
    print(context == null);
    print('show dialog ');
    new Timer(const Duration(milliseconds: 200), (){
      showDialog<bool>(
        context: context,
        builder: (context) {
          return new AlertDialog(
      content: new Text(message.toString()),
      actions: <Widget>[
        new FlatButton(
          child: const Text('CLOSE'),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
        new FlatButton(
          child: const Text('SHOW'),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
      ],
    );
        },
      );
    });
  }
  /*
  Widget _buildDialog(BuildContext context) {
    return new AlertDialog(
      content: new Text("hello"),
      actions: <Widget>[
        new FlatButton(
          child: const Text('CLOSE'),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
        new FlatButton(
          child: const Text('SHOW'),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
      ],
    );
  } */
}