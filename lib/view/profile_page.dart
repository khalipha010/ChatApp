import 'package:flutter/material.dart';
import 'package:fud_chatapp/services/user_preferences.dart';
import 'package:fud_chatapp/services/user_profile.dart';
import 'package:fud_chatapp/view/edit_profile.dart';
import 'package:fud_chatapp/widgets/button_widget.dart';
import 'package:fud_chatapp/widgets/numbers_widget.dart';
import 'package:fud_chatapp/widgets/profile_widget.dart';
import 'package:fud_chatapp/widgets/widgets.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
   final user = UserPreferences.myUser;
    return Scaffold(
     // backgroundColor: Colors.white70,
      appBar: buildAppBar(context),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            imagePath: user.imagePath,
            onClicked: () async {
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>EditProfilePage(),),);
            },
          ),
          const SizedBox(
            height: 24,
          ),
          buildName(user),
          const SizedBox(
            height: 24,
          ),
          Center(
            child: buildUpgradeButton(),
          ),
          const SizedBox(
            height: 24,
          ),
          NumberWidget(),
          const SizedBox(height: 48,),
          buildAbout(user),
        ],
      ),
    );
  }

  Widget buildName(User user) => Column(
        children: [
          Text(
            user.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            user.email,
            style: TextStyle(color: Colors.grey),
          )
        ],
      );
  Widget buildUpgradeButton() =>
      ButtonWidget(text: 'Upgrade To PRO', onClicked: () {});
  Widget buildAbout(User user) =>Container(
    padding: EdgeInsets.symmetric(horizontal: 48,),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white,),
        ),
        const SizedBox(height: 16,),
        Text(
          user.about,
          style: TextStyle(fontSize: 16, height: 1.4, color: Colors.white,),
        ),
      ],
    ),
  );
}
