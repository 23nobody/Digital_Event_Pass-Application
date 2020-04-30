import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digitaleventpass/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:digitaleventpass/pages/person_class.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'enums.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:digitaleventpass/sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:digitaleventpass/constants.dart';
class CreateOrganizerProfile extends StatefulWidget {
  @override
  _CreateOrganizerProfileState createState() => _CreateOrganizerProfileState();
}

final _firestore = Firestore.instance;

class _CreateOrganizerProfileState extends State<CreateOrganizerProfile> {
  bool savingData=false;
  Person _person;
  File _image = null;
  String _imageUrl;
  String _name;
  String _contactNumber;
  String _emailId;
  Gender _gender;
  DateTime _dob;

  void takedate(DateTime value){
    print("takedate working prroperly");
    _dob = value;
    print(_dob);
  }


  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  Widget BlankIcon(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.add_a_photo,
          size: 30.0,
        ),
        Text("Upload photo"),
      ],
    );
  }

  String dropdownValue = 'GENDER';

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if(index==0)
    {
      Navigator.pop(context);
    }
    else if(index==1)
    {
      //Navigator.popAndPushNamed(context, '/');
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: savingData,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Set profile"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: <Widget>[

                  Center(
                    child: GestureDetector(
                      onTap: () {
                        getImage();
                        print("$_image");
                      },
                      child: Container(
                        height: 180.0,
                        width: 140.0,
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: _image==null ? BlankIcon() : ClipRRect(child: Image.file(_image,fit: BoxFit.cover,),borderRadius: BorderRadius.circular(15.0),),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0,),
              Text("Shreyansh Sahu",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              SizedBox(height: 20.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[

                  Text('email:',style: TextStyle(fontSize: 18,color: Colors.black),),
                  Text("iit2018073@iiita.ac.in", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                ],
              ),
              SizedBox(height: 20.0,),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text('Gender:',style: TextStyle(fontSize: 18,color: Colors.black),),
                    DropdownButton<String>(
                      value: dropdownValue,
                      icon: Icon(Icons.arrow_downward),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(
                          color: Colors.black
                      ),
                      underline: Container(
                        height: 2,
                        color: Colors.black,
                      ),
                      onChanged: (String newValue) {
                        setState(() {
                          dropdownValue = newValue;
                          switch(newValue){
                            case "MALE":
                              _gender = Gender.male;
                              break;
                            case "FEMALE":
                              _gender = Gender.female;
                              break;
                            case "OTHERS":
                              _gender = Gender.other;
                              break;
                            default:
                              _gender = Gender.other;
                          }

                        });
                      },
                      items: <String>['GENDER', 'MALE', 'FEMALE', 'OTHERS']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),]
              ),

              SizedBox(height: 20.0,),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Contact Number',
                ),
                keyboardType: TextInputType.number,
                onChanged: (text) {
                  _contactNumber= text;
                },
              ),

//              TextField(
//                decoration: InputDecoration(
//                  border: OutlineInputBorder(),
//                  labelText: 'Email-ID',
//                ),
//                onChanged: (text) {
//                  _emailId= text;
//                },
//              ),

              BasicDateField(
                onChng: takedate,
              ),
              SizedBox(height: 20.0,),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: RaisedButton(
                  onPressed: (){
                    //here we write a function to instantiate the guest class using Guest() callback
                  },
                  color: Theme.of(context).accentColor,
                  child: Text("SUBMIT"),
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Theme.of(context).accentColor,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.arrow_back),
              title: Text("Back"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text("Home"),
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.indigo,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
  void registerUserInDatabase() async {
    bool isNewUser = true;
    try {
      await _firestore.collection('users').document(uid).get().then((value) {
        if (value.data['email']!=null){
          setState(() {
            isNewUser=false;
          });
          _firestore.collection('users').document(uid).updateData({
            'phoneNumber': _contactNumber,
            'gender': _gender,
          });
        }
      });
    }
    catch(e){
      print('NEW USER');
    }
    if(isNewUser) {
      _firestore.collection('users').document(uid).setData({
        'imageUrl': imageUrl,
        'fullName': name,
        'phoneNumber': _contactNumber,
        'email': email,
        'gender': _gender,

      });
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(kSPuid, uid);
    preferences.setBool(kSPfirstLogIn, false);

    Fluttertoast.showToast(msg: 'Profile Saved Successfully',toastLength: Toast.LENGTH_SHORT);
//    Navigator.push(context, MaterialPageRoute(
//      builder: (context) => JourneyPlanScreen(mUid: uid,),));
  }
}

