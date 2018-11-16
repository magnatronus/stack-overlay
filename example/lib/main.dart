/// Demo of StackOverlay showing a dismissable Login Screen
/// the login screen can be forced to show on start up or displayed using a button.
///
/// In the demo this uses a bool called [showOverlay] but this could come
/// from a stored shared_preference to indicate if the user needs to login
/// before continuing with the app
///
/// The example has been modified to show 3 different ways of adding the (optional) [wallpaper]
/// - as a Linear Gradient
/// - as a tiled image
/// - as a background image
///
/// Please Note: To allow the Wallpaper to show through you should set (in this example) the Scaffold background color to transparent
///

import 'package:flutter/material.dart';
import 'package:stack_overlay/stack_overlay.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "Stack Overlay Example", home: OverlayApp());
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

      /*
      // 1. Add a wallpaper - in this example we use a linear gradient and  
      // Remember to set the foreground scaffold background color to transparent to allow the wallpaper to show through
      wallpaper: BoxDecoration(
          gradient: _ShadedBackground(),
      ),
      */

      /*
      // 2. Add a wallpaper - in this example we use a single image as a background tile
      // Remember to set the foreground scaffold background color to transparent to allow the wallpaper to show through
      wallpaper: BoxDecoration(
        image: new DecorationImage(
          image: new AssetImage("images/tile.png"), 
          fit: BoxFit.none,
          repeat: ImageRepeat.repeat
        ),  
      ),
      */

      // Add a wallpaper - in this example we use a single image as a background
      // Remember to set the foreground scaffold background color to transparent to allow the wallpaper to show through
      wallpaper: BoxDecoration(
        image: new DecorationImage(
          image: new AssetImage("images/background.jpg"),
          fit: BoxFit.fitHeight,
        ),
      ),

      // our dismissible foreground widget
      foreground: _LoginScreen(onFinish: () {
        // TODO:: do login stuff here
        setState(() {
          // dismiss the login overlay
          showOverlay = false;
        });
      }),

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

  @override
  build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
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
        color: Colors.purple,
        padding: EdgeInsets.fromLTRB(30.0, 100.0, 30.0, 100.0),
        child: SafeArea(
            child: Scaffold(
                backgroundColor: Colors.transparent,
                body: ListView(
                  children: <Widget>[
                    Text("Dummy User Login",
                        style: TextStyle(color: Colors.white, fontSize: 20.0)),
                    SizedBox(height: 20.0),
                    TextField(
                      decoration:
                          InputDecoration(hintText: "username or email"),
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
                ))));
  }
}

// Create a Linear Gradient
class _ShadedBackground extends LinearGradient {
  final AlignmentGeometry begin = Alignment.topCenter;
  final AlignmentGeometry end = Alignment.bottomCenter;
  final List<double> stops = [0.1, 0.4, 0.9];
  static List<Color> _colors = [
    Color(0xFFFC6FCF),
    Color(0xFFFB0280),
    Color(0xFF800040)
  ];

  _ShadedBackground() : super(colors: _colors);
}
