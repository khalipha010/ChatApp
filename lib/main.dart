import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fud_chatapp/controller/language_controller.dart';
import 'package:fud_chatapp/helper/authenticate.dart';
import 'package:fud_chatapp/helper/helperfunctions.dart';
import 'package:fud_chatapp/helper/user_simple_preferences.dart';
import 'package:fud_chatapp/l10n/l10n.dart';
import 'package:fud_chatapp/services/locale_provider.dart';
import 'package:fud_chatapp/services/signin_with_google.dart';
import 'package:fud_chatapp/view/choose_location_time.dart';
import 'package:fud_chatapp/view/home_time.dart';
import 'package:fud_chatapp/view/signin.dart';
import 'package:fud_chatapp/view/splashscreen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(apiKey: 
'AIzaSyDpuJWIoPwFJiXdSGIbwQRoGpR9K3M2d6E', appId: 
'1:838153318377:android:56259592046ff2ef0ee578', messagingSenderId: '838153318377',projectId: 'chatapp-6c2b3')
  );
  (BuildContext context, AsyncSnapshot snapshot) {
    return;
  };
  await UserSimplePreferences.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool userIsLoggedIn;

  @override
  void initState() {
    getLoggedInState();
    super.initState();
  }

  getLoggedInState() async {
    await HelperFunctions.getUserLoggedInSharedPreference().then((val) {
      setState(() {
        userIsLoggedIn = val;
      });
    });
  }

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => LocaleProvider(),
        builder: (context, child) {
          final provider = Provider.of<LocaleProvider>(context);
          return ChangeNotifierProvider(
            create: (context) => GoogleSignInProvider(),
            child: MaterialApp(
              routes: {
                '/home': (context) => HomeTime(),
                '/location': (context) => ChooseLocationTime(),
              },
              locale: provider.locale,
              supportedLocales: L10n.all,
              localizationsDelegates: [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primaryColor: Colors.teal,
                scaffoldBackgroundColor: Color(0xFF404040),
                dividerColor: Colors.teal,
                primarySwatch: Colors.teal,
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              home: SplashScreen(),
            ),
          );
        },
  );
}
