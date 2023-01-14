// ignore_for_file: deprecated_member_use


import 'package:flutter/material.dart';
import 'package:fud_chatapp/controller/language_controller.dart';
import 'package:fud_chatapp/view/chatRoomScreen.dart';
import 'package:fud_chatapp/widgets/language_picker_widget.dart';
import 'package:provider/provider.dart';


class SwitchLanguage extends StatefulWidget {
  @override
  _SwitchLanguageState createState() => _SwitchLanguageState();
}

class _SwitchLanguageState extends State<SwitchLanguage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      margin: EdgeInsets.symmetric(
                        vertical: 200,
                      ),
                      child: Column(
                        children: [
                          Center(
                            child: Padding(
                              padding: EdgeInsets.all(100),
                              child: LanguagePickerWidget(),
                            ),
                          ),
                          Center(
                            child:IconButton(
                              iconSize: 50,
                              onPressed: (){
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> ChatRoom(),));
                              },
                              icon: Icon(
                                Icons.arrow_back,
                              )
                            )
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
