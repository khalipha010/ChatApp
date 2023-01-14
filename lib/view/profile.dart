import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fud_chatapp/helper/constants.dart';
import 'package:fud_chatapp/helper/user_simple_preferences.dart';
import 'package:fud_chatapp/widgets/widgets.dart';
import 'package:fud_chatapp/widgets/profile_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String name = '';
  String email = '';
  String about = '';
  PickedFile _imageFile;

  final ImagePicker _picker = ImagePicker();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    name = UserSimplePreferences.getUserName() ?? '';
    email = UserSimplePreferences.getUserEmail() ?? '';
    about = UserSimplePreferences.getUserAbout() ?? '';
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Column(
        children: [
          Center(
            child: Stack(
              children: [
                CircleAvatar(
                  backgroundImage: _imageFile == null
                      ? AssetImage('assets/images/avatar.png')
                      : FileImage(
                          File(_imageFile.path),
                        ),
                  radius: 70,
                ),
                Positioned(
                  bottom: 0,
                  right: 4,
                  child: buildCircle(
                    color: Colors.white,
                    all: 3,
                    child: buildCircle(
                      color: Colors.teal,
                      all: 8,
                      child: IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              builder: ((builder) => bottomSheet()));
                        },
                        icon: Icon(Icons.add_a_photo),
                        color: Colors.white,
                        iconSize: 30,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            margin: EdgeInsets.only(right: 200),
            child: Text(
              AppLocalizations.of(context).user_name,
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFormField(
             // controller: name,
              initialValue: name,
              onChanged: (name)=> setState(()=> this.name = name),
              style: TextStyle(
                color: Colors.black,
              ),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                // hintText: AppLocalizations.of(context).email,
                hintStyle: TextStyle(
                  color: Colors.teal,
                ),
                fillColor: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            margin: EdgeInsets.only(right: 200),
            child: Text(
              AppLocalizations.of(context).email,
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFormField(
              //controller: controller,
              initialValue: email,
              onChanged: (email)=> setState(()=> this.email = email),
              style: TextStyle(
                color: Colors.black,
              ),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                // hintText: AppLocalizations.of(context).email,
                hintStyle: TextStyle(
                  color: Colors.teal,
                ),
                fillColor: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            margin: EdgeInsets.only(right: 200),
            child: Text(
              AppLocalizations.of(context).about_profile,
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                //controller: controller,
                initialValue: about,
                onChanged: (about)=> setState(()=> this.about = about),
                maxLines: 7,
                keyboardType: TextInputType.multiline,
                style: TextStyle(
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                  // hintText: AppLocalizations.of(context).email,
                  hintStyle: TextStyle(
                    color: Colors.teal,
                  ),
                  fillColor: Colors.white,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 40),
            child: ElevatedButton(
              onPressed: () async{
                await UserSimplePreferences.setUserName(name);
                await UserSimplePreferences.setUserEmail(email);
                await UserSimplePreferences.setUserAbout(about);
              },
              child: Text(
                AppLocalizations.of(context).about_save,
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                shape: StadiumBorder(),
                minimumSize: Size(250, 50),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: [
          Text(
            'Choose profile picture',
            style: TextStyle(fontSize: 20.0),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                icon: Icon(Icons.camera),
                onPressed: () {
                  takePicture(ImageSource.camera);
                },
                label: Text(
                  'Camera',
                ),
              ),
              TextButton.icon(
                icon: Icon(Icons.image),
                onPressed: () {
                  takePicture(ImageSource.gallery);
                },
                label: Text(
                  'Gallery',
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  void takePicture(ImageSource source) async {
    final PickedFile = await _picker.getImage(
      source: source,
    );
    setState(() {
      _imageFile = PickedFile;
    });
  }
}

Widget buildCircle({
  Widget child,
  double all,
  Color color,
}) =>
    ClipOval(
      child: Container(
        padding: EdgeInsets.all(all),
        color: color,
        child: child,
      ),
    );
