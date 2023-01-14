import 'package:flutter/material.dart';
import 'package:fud_chatapp/services/world_time.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChooseLocationTime extends StatefulWidget {
  @override
  _ChooseLocationTimeState createState() => _ChooseLocationTimeState();
}

class _ChooseLocationTimeState extends State<ChooseLocationTime> {
  List<WorldTime> locations = [
    WorldTime(url: 'Africa/Lagos', location: 'Nigeria', flag: 'nigeria.jpg'),
    WorldTime(url: 'Africa/Nairobi', location: 'Nairobi', flag: 'kenya.jpg'),
    WorldTime(url: 'Africa/Cairo', location: 'Cairo', flag: 'egypt.jpeg'),
    WorldTime(url: 'Europe/London', location: 'London', flag: 'uk.jpeg'),
    WorldTime(url: 'Europe/Berlin', location: 'Athens', flag: 'greece.jpeg'),
    WorldTime(url: 'America/Chicago', location: 'Chicago', flag: 'us.jpeg'),
    WorldTime(url: 'America/New_York', location: 'New York', flag: 'us.jpeg'),
    WorldTime(url: 'Asia/Seoul', location: 'Seoul', flag: 'south_korea.jpeg'),
    WorldTime(url: 'Asia/Jakarta', location: 'Jakarta', flag: 'indonesia.jpeg'),
  ];

  void updateTime(index) async {
    WorldTime instance = locations[index];

    await instance.getTime();

    Navigator.pop(
      context,
      {
        'location': instance.location,
        'flag': instance.flag,
        'time': instance.time,
        'isDayTime': instance.isDayTime,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        centerTitle: true,
        // elevation: 0,
        title: Text(
          AppLocalizations.of(context).choose_location,
        ),
      ),
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
            child: Card(
              child: ListTile(
                onTap: () {
                  updateTime(index);
                },
                title: Text(locations[index].location),
                leading: CircleAvatar(
                  backgroundImage:
                      AssetImage('assets/images/${locations[index].flag}'),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
