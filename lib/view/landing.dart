import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fud_chatapp/helper/authenticate.dart';
import 'package:fud_chatapp/view/chatRoomScreen.dart';

class Landing extends StatefulWidget {
  const Landing({Key key}) : super(key: key);

  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(
            child: CircularProgressIndicator(),
          );
        else if (snapshot.hasData) {
          return ChatRoom();
        } else {
          return Authenticate();
        }
      },
    );
  }
}
