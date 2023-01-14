import 'package:flutter/material.dart';
import 'package:fud_chatapp/services/icon_add.dart';
import 'package:fud_chatapp/services/question_brain.dart';

class Quizzler extends StatefulWidget {
  @override
  _QuizzlerState createState() => _QuizzlerState();
}

class _QuizzlerState extends State<Quizzler> {
  AddIcon addIcon = AddIcon();

  QuestionBrain questionBrain = QuestionBrain();

  int questionNumber = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: Colors.teal,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: 200),
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                questionBrain.questionAnswers[questionNumber].questions,
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 220,
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  bool boolAnswers =
                      questionBrain.questionAnswers[questionNumber].answers;
                  if (boolAnswers == true) {
                    addIcon.iconList.add(
                      Icon(
                        Icons.check,
                        color: Colors.green[400],
                      ),
                    );
                  } else {
                    addIcon.iconList.add(
                      Icon(
                        Icons.close,
                        color: Colors.red,
                      ),
                    );
                  }
                  questionNumber++;
                });
              },
              child: Text('True'),
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                onPrimary: Colors.white,
                minimumSize: Size(300, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  bool boolAnswers =
                      questionBrain.questionAnswers[questionNumber].answers;
                  if (boolAnswers == false) {
                    addIcon.iconList.add(
                      Icon(
                        Icons.check,
                        color: Colors.green,
                      ),
                    );
                  } else {
                    addIcon.iconList.add(
                      Icon(
                        Icons.close,
                        color: Colors.red,
                      ),
                    );
                  }
                  questionNumber++;
                });
              },
              child: Text('False'),
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                onPrimary: Colors.white,
                minimumSize: Size(300, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30),
                  ),
                ),
              ),
            ),
            Container(),
            SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: addIcon.iconList,
              ),
            )
          ],
        ),
      ),
    );
  }
}
