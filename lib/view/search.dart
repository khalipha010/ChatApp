import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fud_chatapp/conversation_screen.dart';
import 'package:fud_chatapp/helper/constants.dart';
import 'package:fud_chatapp/services/database.dart';
import 'package:fud_chatapp/widgets/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController searchTextEditingController =
      new TextEditingController();

  QuerySnapshot<Map<String, dynamic>> searchSnapshot;
  bool isLoading = false;
  bool haveUserSearched = false;

  initiateSearch() async {
    if (searchTextEditingController.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      await databaseMethods
          .getUserByUserName(searchTextEditingController.text)
          .then((val) {
        setState(() {
          searchSnapshot = val;
          isLoading = false;
          haveUserSearched = true;
        });
      });
    }
  }

  Widget searchList() {
    return searchSnapshot != null
        ? ListView.builder(
            itemCount: searchSnapshot.docs.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return SearchTile(
                userName: searchSnapshot.docs[index].data()['name'],
                userEmail: searchSnapshot.docs[index].data()['email'],
              );
            })
        : Container();
  }

  /// create chatroom,send user to conversation screen,pushReplacement
  sendMessage(String userName) {
    if (userName != Constants.myName) {
      List<String> users = [Constants.myName, userName];
      String chatRoomId = getChatRoomId(Constants.myName, userName);

      Map<String, dynamic> chatRoomMap = {
        "users": users,
        "chatroomId": chatRoomId,
      };
      DatabaseMethods().createChatRoom(chatRoomId, chatRoomMap);

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ConversationScreen(chatRoomId)));
    } else {
      print("you cannot send message to yourself");
    }
  }

  Widget SearchTile({String userName, String userEmail}) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName,
                  style: mediumTextStyle(),
                ),
                Text(
                  userEmail,
                  style: mediumTextStyle(),
                ),
              ],
            ),
            Spacer(),
            InkWell(
              onTap: () {
                sendMessage(userName);
              },
              child: Ink(
                decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(30)),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Text(
                  "Message",
                  style: mediumTextStyle(),
                ),
              ),
            )
          ],
        ));
  }

  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isLoading ? null : MainAppBar(),
      body: isLoading
          ? Container(
              child: Center(
                child: SpinKitChasingDots(
                  color: Colors.white,
                  size: 70.0,
                ),
              ),
            )
          : Container(
              child: Column(
                children: [
                  Container(
                    color: Color(0x54FFFFFF),
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: searchTextEditingController,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              hintText: "search username...",
                              hintStyle: TextStyle(
                                color: Colors.white,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            initiateSearch();
                          },
                          child: Ink(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                    const Color(0x36FFFFFF),
                                    const Color(0X0FFFFFFF),
                                  ]),
                                  borderRadius: BorderRadius.circular(40)),
                              padding: EdgeInsets.all(12),
                              child: Image.asset(
                                  "assets/images/search_white.png")),
                        ),
                      ],
                    ),
                  ),
                  searchList(),
                ],
              ),
            ),
    );
  }
}
