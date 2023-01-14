import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fud_chatapp/helper/constants.dart';
import 'package:fud_chatapp/services/database.dart';
import 'package:fud_chatapp/widgets/widgets.dart';
import 'package:translator/translator.dart';

class ConversationScreen extends StatefulWidget {
  final String chatRoomId;
  //final Stream chatMessagesStream;
  ConversationScreen(this.chatRoomId);

  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  DatabaseMethods databaseMethods = new DatabaseMethods();

  Stream<QuerySnapshot> chatMessagesStream;
  TextEditingController messageController = new TextEditingController();

  Widget ChatMessageList() {
    return Container(
      margin: EdgeInsets.only(bottom: 80.0),
      child: StreamBuilder(
        stream: chatMessagesStream,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? Container(
                  padding: EdgeInsets.only(bottom: 10),
                  height: MediaQuery.of(context).size.height - 80,
                  child: ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      return MessageTile(
                          snapshot.data.docs[index]['message'],
                          snapshot.data.docs[index]['sendBy'] ==
                              Constants.myName);
                    },
                  ),
                )
              : Container();
        },
      ),
    );
  }

  sendMessage() {
    if (messageController.text.isNotEmpty) {
      Map<String, dynamic> messageMap = {
        "message": messageController.text,
        "sendBy": Constants.myName,
        "time": DateTime.now().millisecondsSinceEpoch,
      };
      databaseMethods.addConversationMessages(widget.chatRoomId, messageMap);
      setState(() {
        messageController.text = "";
      });
    }
  }

  @override
  void initState() {
    databaseMethods.getConversationMessages(widget.chatRoomId).then((val) {
      setState(() {
        chatMessagesStream = val;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MainAppBar(),
        endDrawer: CustomEndDrawer(),
        body: Container(
          child: Stack(
            children: [
              ChatMessageList(),
              Container(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: Color(0x54FFFFFF),
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: messageController,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            hintText: "Message...",
                            hintStyle: TextStyle(
                              color: Colors.white,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          sendMessage();
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
                            child: Image.asset("assets/images/send.png")),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool sendByMe;

  MessageTile(this.message, this.sendByMe);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(left: sendByMe ? 0 : 24, right: sendByMe ? 24 : 0),
      margin: EdgeInsets.symmetric(vertical: 8),
      width: MediaQuery.of(context).size.width,
      alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
            color: sendByMe ? Colors.teal : Colors.white10,
            borderRadius: sendByMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomRight: Radius.circular(23))
                : BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomRight: Radius.circular(23))),
        child: Text(
          message,
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
          ),
        ),
      ),
    );
  }

  void Translate() async {
    final translator = GoogleTranslator();

    var translation = await translator.translate(message, from: 'en', to: 'ha');
    

    translator.baseUrl = 'translate.google.cn';
    translator.translateAndPrint('The translation from database is:');
    print('translation:$translation');
  }
}
