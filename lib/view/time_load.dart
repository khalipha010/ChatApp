import 'package:flutter/material.dart';
import 'package:fud_chatapp/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  void startTime() async{
    // create  object of the class WorldTime

    WorldTime instance =
    WorldTime(location: 'Lagos', flag: 'Nigeria.png', url: 'Africa/Lagos');

    //Get getTime

     await instance.getTime();

    //push data to Home screen

    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'isDayTime': instance.isDayTime,
    });
  }

  //initState function that runs as the program starts

  @override
  void initState() {
    super.initState();

    //start time as program starts

    startTime();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Center(
        child: SpinKitWanderingCubes(
          color: Colors.white,
          size: 70.0,
          duration: Duration(milliseconds: 1300),
        ),
      ),
    );
  }
}
