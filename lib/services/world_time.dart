import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location;
  String time;
  String flag;
  String url;
  bool isDayTime;

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {
    // handle runtime errors
    try {
      //Get time from third party api
      Response response =
      await get(Uri.parse('https://worldtimeapi.org/api/timezone/$url'));

      // Decode json and Map through it and save result in var data

      Map data = jsonDecode(response.body);

      // Get time properties

      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);

      // parse datetime in DateTime class

      DateTime now = DateTime.parse(datetime);

      // convert offset to int and add it to datetime

      now = now.add(Duration(hours: int.parse(offset)));

      //store data in time

      time = DateFormat.jm().format(now);
      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
    } catch (e) {
      print('error occured : $e');
      time = 'loading';
    }
  }
}
