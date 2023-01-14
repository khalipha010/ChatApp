// ignore_for_file: deprecated_member_use

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:fud_chatapp/controller/language_controller.dart';
import 'package:fud_chatapp/view/chatRoomScreen.dart';
import 'package:fud_chatapp/view/quizzler.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class QuizPop extends StatefulWidget {
  @override
  _QuizPopState createState() => _QuizPopState();
}

class _QuizPopState extends State<QuizPop> {
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
                      child: Expanded(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 50,
                            ),
                            AnimatedTextKit(
                              animatedTexts: [
                                TypewriterAnimatedText(
                                  AppLocalizations.of(context).welcome_quizzler,
                                  textStyle: TextStyle(
                                      fontFamily: 'Pacifico',
                                      fontWeight: FontWeight.w200,
                                      fontSize: 20.0,
                                      color: Colors.black),
                                  speed: const Duration(milliseconds: 100),
                                ),
                              ],
                              totalRepeatCount: 1000,
                              pause: const Duration(milliseconds: 100),
                              displayFullTextOnTap: true,
                              stopPauseOnTap: true,
                            ),
                            Center(
                              child: Padding(
                                padding: EdgeInsets.all(60),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Quizzler(),
                                        ));
                                  },
                                  child: Text(
                                    AppLocalizations.of(context)
                                        .continue_quizzler,
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.black,
                                    onPrimary: Colors.white,
                                    minimumSize: Size(10, 50),
                                  ),
                                ),
                              ),
                            ),
                            Center(
                              child: IconButton(
                                iconSize: 50,
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ChatRoom(),
                                      ));
                                },
                                icon: Icon(
                                  Icons.arrow_back,
                                ),
                              ),
                            ),
                          ],
                        ),
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
