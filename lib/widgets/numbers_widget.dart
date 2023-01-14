import 'package:flutter/material.dart';

class NumberWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildButton(context, '4.2', 'Ranking'),
            buildDivider(),
            buildButton(context, '0', 'Following'),
            buildDivider(),
            buildButton(context, '0', 'Followers'),
          ],
        ),
      );
  Widget buildDivider() => Container(
    height: 24,
        child: VerticalDivider(),
      );

  Widget buildButton(BuildContext context, String value, String text) =>
      MaterialButton(
        padding: EdgeInsets.symmetric(vertical: 4),
        onPressed: () {},
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              value,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
            ),
            Text(
              text,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
            )
          ],
        ),
      );
}
