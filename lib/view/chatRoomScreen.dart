import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fud_chatapp/conversation_screen.dart';
import 'package:fud_chatapp/helper/constants.dart';
import 'package:fud_chatapp/helper/helperfunctions.dart';
import 'package:fud_chatapp/services/auth.dart';
import 'package:fud_chatapp/services/database.dart';
import 'package:fud_chatapp/view/search.dart';
import 'package:fud_chatapp/helper/authenticate.dart';
import 'package:fud_chatapp/widgets/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  Stream chatRoomsStream;

  Widget chatRoomList() {
    return StreamBuilder(
      stream: chatRoomsStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.docs.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return ChatRoomsTile(
                  snapshot.data.docs[index]['chatroomId']
                      .toString()
                      .replaceAll("_", "")
                      .replaceAll(Constants.myName, ""),
                  snapshot.data.docs[index]['chatroomId']);
            },
          );
        } else if (snapshot.data == null) {
          return Avatar(context);
        } else {
          return Container();
        }
      },
    );
  }

  Widget Avatar(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 300),
      child: Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 0),
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                AppLocalizations.of(context).emoji_text,
                style: TextStyle(
                  fontFamily: 'Source Sans Pro',
                  color: Colors.white70,
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 100,
              child: Image.asset(
                'assets/images/emoji.png',
              ),
            ),
            SizedBox(
              height: 90,
              child: Container(
                margin: EdgeInsets.only(left: 150),
                child: Image.asset('assets/images/arrow.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    Constants.myName = await HelperFunctions.getUserUserNameSharedPreference();
    databaseMethods.getChatRooms(Constants.myName).then(
      (val) {
        setState(
          () {
            chatRoomsStream = val;
            print(
                "I got data + ${chatRoomsStream.toString()} this is name ${Constants.myName}");
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: CircleAvatar(
          backgroundImage: (user.photoURL == null)
              ? AssetImage('assets/images/avatar.png')
              : NetworkImage(user.photoURL),
          radius: 20,
        ),
        //centerTitle: true,
        backgroundColor: Colors.teal,
        centerTitle: true,
        elevation: 0,
        actions: [
          InkWell(
            onTap: () {
              authMethods.signOut();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Authenticate()));
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.exit_to_app),
            ),
          ),
        ],
      ),
      drawer: CustomDrawer(),
      body: chatRoomList(),
      floatingActionButton: FloatingActionButton(
        child: FaIcon(FontAwesomeIcons.search),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SearchScreen(),
            ),
          );
        },
      ),
    );
  }
}

class ChatRoomsTile extends StatelessWidget {
  final String userName;
  final String chatRoomId;
  ChatRoomsTile(this.userName, this.chatRoomId);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ConversationScreen(chatRoomId),
          ),
        );
      },
      child: Container(
        //color: Colors.brown,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Text(
                "${userName.substring(0, 1).toUpperCase()}",
                style: mediumTextStyle(),
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              userName,
              style: mediumTextStyle(),
            ),
            //  Text(
            //  chatRoomId,
            //   style: mediumTextStyle(),
            //  )
          ],
        ),
      ),
    );
  }
}
