/// Demo of StackOverlay showing a dismissable Login Screen 
/// the login screen can be forced to show on start up or displayed using a button.
/// 
/// In the demo this uses a bool called [showOverlay] but this could come
/// from a stored shared_preference to indicate if the user needs to login 
/// before continuing with the app

import 'package:flutter/material.dart';
import 'package:stack_overlay/stack_overlay.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: "Stack Overlay Example",
      home: OverlayApp()
    );
  }
}

/// A demo of the StackOverlay Widget
class OverlayApp extends StatefulWidget {
  @override
  _OverlayAppState createState() => _OverlayAppState();
}

class _OverlayAppState extends State<OverlayApp> {

  // initial state of the foreground overlay 
  // this will force the login screen to be displayed - change to false to hide by default
  bool showOverlay = true; 

  @override
  Widget build(BuildContext context) {
    return StackOverlay(

      // determine if foreground should be shown
      showForeground: showOverlay,

      // our dismissible foreground widget
      foreground: _LoginScreen(
        onFinish: () {
          // TODO:: do login stuff here
          setState(() {
            // dismiss the login overlay
            showOverlay = false;
          });
          }
      ),

      // our background widget
      background: _BackgroundScreen(
        onLogin: () {
          setState(() {
            // show the login screen
            showOverlay = true;
          });       
        },
      ),

    );
  }

}


/// demo [background] widget
class _BackgroundScreen extends StatelessWidget {

  final Function onLogin;

  _BackgroundScreen({@required this.onLogin});

  @override build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("StackOverlay Demo"),
        actions: <Widget>[
          IconButton(
          onPressed: onLogin,
          icon: Icon(Icons.person),
        )

        ],
      ),
    );
  }

}


/// demo login screen used for our [foreground] widget
class _LoginScreen extends StatelessWidget {

  final Function onFinish;

  _LoginScreen({@required this.onFinish});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.blueAccent,
        padding: EdgeInsets.fromLTRB(30.0, 100.0, 30.0, 100.0),
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.blueAccent,
            body: ListView(
              children: <Widget>[
                Text(
                  "Dummy User Login",
                  style: TextStyle( color: Colors.white, fontSize: 20.0)
                ),
                SizedBox(height: 20.0),
                TextField(
                  decoration: InputDecoration(hintText: "username or email"),
                ),
                TextField(
                  decoration: InputDecoration(hintText: "password"),
                ),  
                SizedBox(height: 20.0),
                RaisedButton(
                  onPressed: onFinish,
                  child: Text("Login"),
                )
              ],
            )
          )
        )
    );
  }

}
