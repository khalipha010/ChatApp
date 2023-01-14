import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fud_chatapp/helper/constants.dart';
import 'package:fud_chatapp/helper/constants.dart';
import 'package:fud_chatapp/helper/constants.dart';
import 'package:fud_chatapp/helper/user_simple_preferences.dart';
import 'package:fud_chatapp/services/auth.dart';
import 'package:fud_chatapp/services/database.dart';
import 'package:fud_chatapp/services/signin_with_google.dart';
import 'package:fud_chatapp/view/about_dev.dart';
import 'package:fud_chatapp/view/edit_profile.dart';
import 'package:fud_chatapp/view/lang_switch.dart';
import 'package:fud_chatapp/view/profile.dart';
import 'package:fud_chatapp/view/profile_page.dart';
import 'package:fud_chatapp/view/quiz_pop.dart';
import 'package:fud_chatapp/view/world_time_pop.dart';
import 'package:fud_chatapp/widgets/language_picker_widget.dart';
import 'package:provider/provider.dart';
import 'package:fud_chatapp/helper/helperfunctions.dart';
import 'package:fud_chatapp/conversation_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class appBarMain extends StatelessWidget implements PreferredSizeWidget {
  final double barHeight = 50.0;
  final String title;
  const appBarMain({Key key, this.title}) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + barHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: SizedBox(
        height: kToolbarHeight,
        child: Image.asset(
          "assets/images/logo.png",
        ),
      ),
      toolbarHeight: kToolbarHeight,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(48.0))),
      actions: [
        LanguagePickerWidget(),

        const SizedBox(
          width: 12,
        ),
      ],
      backgroundColor: Colors.teal,
      //shape: CustomShapeBorder(),
      centerTitle: true,
      elevation: 0,
    );
  }
}

InputDecoration textFieldInputDecoration(String hintText) {
  return InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
      hintText: hintText,
      hintStyle: TextStyle(
        color: Colors.white54,
      ),
      focusedBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ));
}

TextStyle mediumTextStyle() {
  return TextStyle(
    color: Colors.white,
    fontSize: 17,
  );
}

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double barHeight = 10;

  const MainAppBar({
    Key key,
  }) : super(key: key);
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + barHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Image.asset('assets/images/logo.png', height: 60),
      backgroundColor: Colors.teal,
      //shape: CustomShapeBorder(),
      centerTitle: true,
      elevation: 0,
    );
  }
}

class CustomDrawer extends StatefulWidget {
  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  AuthMethods authMethods = new AuthMethods();

  DatabaseMethods databaseMethods = new DatabaseMethods();
  getUserInfo() async {
    Constants.myName = await HelperFunctions.getUserUserNameSharedPreference();
  }

  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    print(Constants.myName);
    return Drawer(
      child: Container(
        color: Color(0xFF404040),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: (user.displayName == null)
                  ? Text(UserSimplePreferences.getUserName())
                  : Text(user.displayName),
              accountEmail: (user.email == null) ? Text(UserSimplePreferences.getUserEmail()) : Text(user.email),
              currentAccountPicture: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.blue,
                child: CircleAvatar(
                  backgroundImage: (user.photoURL == null)
                      ? AssetImage('assets/images/avatar.png')
                      : NetworkImage(user.photoURL),
                  radius: 30,
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.teal,
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                color: Colors.green,
              ),
              title: Text(
                AppLocalizations.of(context).edit_profile,
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Profile(),),);
              },
            ),
            ListTile(
              leading: Icon(
                FontAwesomeIcons.personBooth,
                color: Colors.purple[200],
              ),
              title: Text(
                AppLocalizations.of(context).about_dev,
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AboutDev()));
              },
            ),
            ListTile(
              leading: Icon(
                FontAwesomeIcons.questionCircle,
                color: Colors.orange,
              ),
              title: Text(
                AppLocalizations.of(context).quiz_game,
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => QuizPop()));
              },
            ),
            ListTile(
              leading: Icon(
                FontAwesomeIcons.solidCalendarTimes,
                color: Colors.green,
              ),
              title: Text(
                AppLocalizations.of(context).world_time,
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => WorldTimePop()));
              },
            ),
            ListTile(
              leading: Icon(
                FontAwesomeIcons.language,
                color: Colors.deepPurpleAccent,
              ),
              title: Text(
                AppLocalizations.of(context).switch_language,
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SwitchLanguage()));
              },
            ),

            ListTile(
              leading: Icon(
                FontAwesomeIcons.github,
                color: Colors.teal[200],
              ),
              title: Text(
                AppLocalizations.of(context).git_gub,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () {
                // Navigator.pop(context);
              },
            ),
            Divider(
              color: Colors.teal,
              height: 20,
              thickness: 2,
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              leading: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  onPrimary: Colors.white,
                  shadowColor: Colors.brown[200],
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  minimumSize: Size(150, 50),
                ),
                onPressed: () {},
                child: Text(
                  AppLocalizations.of(context).donate,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              leading: Icon(
                FontAwesomeIcons.signOutAlt,
                color: Colors.teal[100],
              ),
              title: Text(
                AppLocalizations.of(context).log_out,
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                provider.logOut();
              },
            ),
            // Container(
            // )
          ],
        ),
      ),
    );
  }
}

class CustomEndDrawer extends StatefulWidget {
  @override
  State<CustomEndDrawer> createState() => _CustomEndDrawerState();
}

class _CustomEndDrawerState extends State<CustomEndDrawer> {
  String chatId;
  String chatRoomId;
  DatabaseMethods databaseMethods = DatabaseMethods();

  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Drawer(
      child: Container(
        color: Color(0xFF404040),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: (user.displayName == null)
                  ? Text(Constants.myName)
                  : Text(user.displayName),
              accountEmail: (user.email == null) ? Text('') : Text(user.email),
              currentAccountPicture: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.blue,
                child: CircleAvatar(
                  backgroundImage: (user.photoURL == null)
                      ? AssetImage('assets/images/avatar.png')
                      : NetworkImage(user.photoURL),
                  radius: 30,
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.teal,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            ListTile(
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.teal,
                  onPrimary: Colors.white,
                  shadowColor: Colors.brown[200],
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  minimumSize: Size(260, 40),
                ),
                onPressed: () {},
                child: Text(
                  AppLocalizations.of(context).delete_message,
                ),
              ),
            ),
            ListTile(
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  onPrimary: Colors.white,
                  shadowColor: Colors.brown[200],
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  minimumSize: Size(260, 40),
                ),
                onPressed: () {},
                child: Text(
                  AppLocalizations.of(context).block_user,
                ),
              ),
            ),
            SizedBox(
              height: 300,
            ),
            ListTile(
              leading: Icon(
                FontAwesomeIcons.signOutAlt,
                color: Colors.teal[100],
              ),
              title: Text(
                'LogOut',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                provider.logOut();
              },
            ),
            // Container(
            // )
          ],
        ),
      ),
    );
  }
}

AppBar buildAppBar(BuildContext context){
  final icon = CupertinoIcons.moon_stars;
  return AppBar(
    leading: BackButton(),
    backgroundColor: Colors.transparent,
    elevation: 0,
    actions: [
      LanguagePickerWidget()
    ],

  );
}
