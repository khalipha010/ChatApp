import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeTime extends StatefulWidget {
  @override
  _HomeTimeState createState() => _HomeTimeState();
}

class _HomeTimeState extends State<HomeTime> {
  Map data = {};
  @override
  Widget build(BuildContext context) {
   data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    print(data);
    print(data['isDayTime']);

    String bgImage = data['isDayTime'] ? 'day.png' : 'night.png';
    Color bgColor = data['isDayTime'] ? Colors.blue : Colors.indigo[700];
   // String iftar;
   // iftar = data['isDayTime'] ? 'Iftar Time' : 'Past Iftar time';

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/images/$bgImage'),
            fit: BoxFit.cover,
          )),
          child: Padding(
            padding: const EdgeInsets.only(top: 120),
            child: Center(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton.icon(
                    onPressed: (() async {
                      dynamic result =
                          await Navigator.pushNamed(context, '/location');
                      setState(() {
                        data = {
                          'location': result['location'],
                          'flag': result['flag'],
                          'time': result['time'],
                          'isDayTime': result['isDayTime'],
                        };
                      });
                    }),
                    label: Text(
                     AppLocalizations.of(context).edit_location,
                      style: TextStyle(
                        color: Colors.grey[300],
                      ),
                    ),
                    icon: Icon(
                      Icons.edit_location,
                      color: Colors.grey[300],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        data['location'],
                        style: TextStyle(
                          fontSize: 28.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    data['time'],
                    style: TextStyle(
                      fontSize: 66.0,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    '',
                    style: TextStyle(
                      color: Colors.grey[300],
                      fontSize: 30.0,
                      fontStyle: FontStyle.normal,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
