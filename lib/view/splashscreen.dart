import 'dart:async';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:fud_chatapp/services/world_time.dart';
import 'package:fud_chatapp/view/landing.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    startTime();
    super.initState();
  }

  startTime() async {
    var duration = new Duration(seconds: 6);

  return new Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Landing(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Center(
        child: SpinKitCubeGrid(
          color: Colors.white,
          size: 70.0,
          duration: Duration(milliseconds: 1300),
        ),
      ),
    );
  }
}
