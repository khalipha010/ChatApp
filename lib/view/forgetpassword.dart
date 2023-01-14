import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fud_chatapp/helper/authenticate.dart';
import 'package:fud_chatapp/view/pop_email_succesful.dart';
import 'package:fud_chatapp/view/signin.dart';
import 'package:fud_chatapp/widgets/language_picker_widget.dart';
import 'package:fud_chatapp/widgets/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ResetPassword extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(
          AppLocalizations.of(context).reset_appbar,
        ),
        centerTitle: true,
        actions: [LanguagePickerWidget()],
        elevation: 0.0,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                AppLocalizations.of(context).reset_body_text,
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Source Sans Pro',
                    fontSize: 20.0),
              ),
            ),
            TextFormField(
              controller: controller,
              style: TextStyle(
                color: Colors.black,
              ),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                hintText: AppLocalizations.of(context).email,
                hintStyle: TextStyle(
                  color: Colors.teal,
                ),
                fillColor: Colors.white,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () async {
                  await FirebaseAuth.instance
                      .sendPasswordResetEmail(
                    email: controller.text,
                  )
                      .then(
                    (value) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PasswordPopSucces(),
                        ),
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  primary: Colors.teal,
                  onPrimary: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  AppLocalizations.of(context).reset_button,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(AppLocalizations.of(context).reset_cont_login,
                    style: mediumTextStyle()),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Authenticate()));
                    },
                    child: Text(
                      AppLocalizations.of(context).sign_in,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
