import 'package:flutter/material.dart';

class AboutDev extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.teal,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50.0,
                backgroundImage: AssetImage('assets/images/6190.jpg'),
              ),
              Text(
                'Khalifa Jibreel',
                style: TextStyle(
                  fontFamily: 'Pacifico',
                  color: Colors.white,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Flutter Developer',
                style: TextStyle(
                  fontFamily: 'Source Sans Pro',
                  fontSize: 20.0,
                  color: Colors.teal.shade100,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3,
                ),
              ),
              SizedBox(
                  height: 20,
                  width: 150,
                  child: Divider(
                    height: 20,
                    color: Colors.teal.shade100,
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                  child: ListTile(
                    leading: Icon(Icons.phone, color: Colors.teal),
                    title: Text(
                      '+2348066484726',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.teal,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 0.0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                  child: ListTile(
                    leading: Icon(Icons.email, color: Colors.teal),
                    title: Text(
                      'khalifajibreel@gmail.com',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.teal,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
