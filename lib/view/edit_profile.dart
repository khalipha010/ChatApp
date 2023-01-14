import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fud_chatapp/services/user_preferences.dart';
import 'package:fud_chatapp/services/user_profile.dart';
import 'package:fud_chatapp/widgets/profile_widget.dart';
import 'package:fud_chatapp/widgets/widgets.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {

  XFile _imageFile;

  final ImagePicker _picker = ImagePicker();

  //Get User Preference data

  User user = UserPreferences.myUser;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 32),
        physics: BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            imagePath: _imageFile == null ? user.imagePath : FileImage(File(_imageFile.path)),
            isEdit: true,
            onClicked: () {
              showModalBottomSheet(
                context: context,
                builder: ((builder)=>bottomSheet()),
              );
            },
          ),
          const SizedBox(height: 24,),
          TextFieldWidget(
            label: 'Full Name',
            text: user.name,
            onChanged: (name){},
          ),
          const SizedBox(height: 24,),
          TextFieldWidget(
            label: 'Email',
            text: user.email,
            onChanged: (email){},
          ),
          const SizedBox(height: 24,),
          TextFieldWidget(
            label: 'About',
            text: user.about,
            maxLines: 5,
            onChanged: (about){},
          ),
          SizedBox(height: 20,),
          ElevatedButton(
            onPressed: (){},
            child: Text('SAVE'),
            style: ElevatedButton.styleFrom(
              onPrimary: Colors.white,
              primary: Colors.teal,
              minimumSize: Size(100, 50),
              shape: StadiumBorder(),
            ),
          )
        ],
      ),
    );
  }
  // bottom sheet picker
  Widget bottomSheet(){
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20,),
      child: Column(
        children: [
          Text(
            'Choose profile picture',
            style: TextStyle(
              fontSize: 20.0
            ),
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                icon: Icon(Icons.camera),
                onPressed: (){
                  takePicture(ImageSource.camera);
                },
                label: Text('Camera',),
              ),
              TextButton.icon(
                icon: Icon(Icons.image),
                onPressed: (){
                  takePicture(ImageSource.gallery);
                },
                label: Text('Gallery',),
              )
            ],
          )
        ],
      ),
    );
  }
  void takePicture(ImageSource source) async{
    final XFile = await _picker.pickImage(
      source: source,
    );
    setState(() {
      _imageFile = XFile;
    });
  }
}


// textfield widget

class TextFieldWidget extends StatefulWidget {
  final int maxLines;
  final String label;
  final String text;
  final ValueChanged<String> onChanged;

  const TextFieldWidget({
    Key key,
    this.maxLines = 1,
    this.label,
    this.text,
    this.onChanged
}) : super(key: key);
  @override
  _TextFieldWidgetState createState()=> _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {

 TextEditingController  controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TextEditingController(text: widget.text);
  }

  void dispose(){
    controller.dispose();

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white),
        ),
        const SizedBox(height: 8,),
        TextField(
          controller: controller,
          maxLines: widget.maxLines,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.teal,

              ),
            ),
          ),
          style: TextStyle(
            color: Colors.white70,
          ),
        ),
      ],
    );
  }
}


