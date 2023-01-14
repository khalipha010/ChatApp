import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fud_chatapp/controller/language_controller.dart';
import 'package:fud_chatapp/helper/helperfunctions.dart';
import 'package:fud_chatapp/services/auth.dart';
import 'package:fud_chatapp/services/database.dart';
import 'package:fud_chatapp/services/locale_provider.dart';
import 'package:fud_chatapp/services/signin_with_google.dart';
import 'package:fud_chatapp/view/chatRoomScreen.dart';
import 'package:fud_chatapp/view/forgetpassword.dart';
import 'package:fud_chatapp/widgets/language_picker_widget.dart';
import 'package:fud_chatapp/widgets/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fud_chatapp/l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignIn extends StatefulWidget {
  final Function toggle;
  SignIn(this.toggle);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final formKey = GlobalKey<FormState>();
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController emailTextEditingController =
      new TextEditingController();
  TextEditingController passwordTextEditingController =
      new TextEditingController();

  bool isLoading = false;

  signIn() async {
    if (formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });

      await authMethods
          .signInWithEmailAndPassword(emailTextEditingController.text,
              passwordTextEditingController.text)
          .then((val) async {
        if (val != null) {
          QuerySnapshot userInfoSnapshot = await DatabaseMethods()
              .getUserByUserEmail(emailTextEditingController.text);

          HelperFunctions.saveUserLoggedInSharedPreference(true);
          HelperFunctions.saveUserNameSharedPreference(
              userInfoSnapshot.docs[0]["name"]);
          HelperFunctions.saveUserEmailSharedPreference(
              userInfoSnapshot.docs[0]["email"]);

          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => ChatRoom()));
        } else {
          setState(() {
            isLoading = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: isLoading ? null : appBarMain(),
      body: isLoading
          ? Container(
              child: Center(
                  child: SpinKitChasingDots(
              color: Colors.white,
              size: 70.0,
            )))
          : SingleChildScrollView(
              child: Container(
                child: SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height - 50,
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 150),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AnimatedTextKit(
                                animatedTexts: [
                                  TyperAnimatedText(
                                    'CHATAPP',
                                    textStyle: TextStyle(
                                      fontFamily: 'Pacifico',
                                      fontWeight: FontWeight.w200,
                                      fontSize: 50.0,
                                      color: Colors.teal,
                                    ),
                                    speed: const Duration(milliseconds: 100),
                                  ),
                                ],
                                totalRepeatCount: 1000,
                                pause: const Duration(milliseconds: 1000),
                                displayFullTextOnTap: true,
                                stopPauseOnTap: true,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Form(
                                key: formKey,
                                child: Column(
                                  children: [
                                    TextFormField(
                                        validator: (val) {
                                          if (RegExp(
                                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                              .hasMatch(val)) {
                                            return null;
                                          } else {
                                            return AppLocalizations.of(context)
                                                .email_validation;
                                          }
                                        },
                                        controller: emailTextEditingController,
                                        style: TextStyle(color: Colors.black),
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.0)),
                                            filled: true,
                                            hintText:
                                                AppLocalizations.of(context)
                                                    .email,
                                            hintStyle: TextStyle(
                                              color: Colors.teal,
                                            ),
                                            fillColor: Colors.white)),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    TextFormField(
                                      validator: (val) {
                                        if (val == null || val.length < 6) {
                                          return AppLocalizations.of(context)
                                              .password_validation;
                                        }
                                        return null;
                                      },
                                      obscureText: true,
                                      controller: passwordTextEditingController,
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                        filled: true,
                                        hintText: AppLocalizations.of(context)
                                            .password,
                                        hintStyle: TextStyle(
                                          color: Colors.teal,
                                        ),
                                        fillColor: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ResetPassword(),
                                    ),
                                  );
                                },
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  child: Text(
                                    AppLocalizations.of(context)
                                        .forgot_password,
                                    style: mediumTextStyle(),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              InkWell(
                                splashColor: Colors.teal[800],
                                onTap: () => signIn(),
                                child: Ink(
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.symmetric(vertical: 20),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        const Color(0xFF26CBDA),
                                        const Color(0xFF26CBDA)
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Text(
                                      AppLocalizations.of(context).sign_in,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 17)),
                                ),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    final provider =
                                        Provider.of<GoogleSignInProvider>(
                                      context,
                                      listen: false,
                                    );
                                    provider.googleLogIn();
                                  },
                                  style: ElevatedButton.styleFrom(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 20),
                                      primary: Colors.white,
                                      onPrimary: Colors.black,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30))),
                                  icon: FaIcon(FontAwesomeIcons.google,
                                      color: Colors.red),
                                  label: Text(
                                    AppLocalizations.of(context).login_google,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 17),
                                  ),
                                ),
                              ),
                              SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      AppLocalizations.of(context).dont_account,
                                      style: mediumTextStyle()),
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 8),
                                    child: GestureDetector(
                                      onTap: () {
                                        widget.toggle();
                                      },
                                      child: Text(
                                        AppLocalizations.of(context).register,
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
                              SizedBox(height: 50),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
