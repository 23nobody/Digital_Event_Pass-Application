import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digitaleventpass/date_time_picker.dart';
import 'package:digitaleventpass/main.dart';
import 'package:digitaleventpass/pages/enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:digitaleventpass/post_class.dart';

final _firestore = Firestore.instance;
class CreateNewEvent extends StatefulWidget {
  @override
  _CreateNewEventState createState() => _CreateNewEventState();
}

class _CreateNewEventState extends State<CreateNewEvent> {
  File _image;
  Post _event;
  String _name = "";
  String _description = "";
  String _venue = "";
  String _imageUrl = "https://d.newsweek.com/en/full/297016/mia-khalifa.jpg";
  DateTime _time;
  double _duration =0 ;
  String _organiserID = uid;
  String _eventID = "";

  EventType dropDownValue = EventType.Theatre;


  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }
  void takedate(DateTime value){
      print("takedate working prroperly");
      _time = value;
      print(_time);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
        image: DecorationImage(
        image: AssetImage("assets/backsm2.jpg"),
        fit: BoxFit.cover,
          ),
        ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ListView(
          children: <Widget>[
            Container(
              height: 220.0,
              width: 380.0,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: InkWell(
                onTap: () {
                  getImage();
                  print("$_image");
                },
                child: _image == null ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.add_a_photo,
                      size: 50.0,
                    ),
                    Text("Upload photo"),
                  ],
                ): Image.file(_image),
              )
            ),
            SizedBox(height: 10.0),
            Container(
              height: 50.0,
              decoration: BoxDecoration(
                color: Colors.orange[300],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                      "Provide Info For Event",
                       style: TextStyle(
                         letterSpacing: 3.0,
                         fontSize: 20.0,
                         fontWeight: FontWeight.bold,
                       ),
                  ),
                ],
              ),
            ),
            Form(
              autovalidate: true,
               child: Padding(
                 padding: const EdgeInsets.all(13.0),
                 child: Column(
                     children: <Widget>[
                       TextFormField(
                         decoration: const InputDecoration(
                           icon: const Icon(Icons.calendar_today),
                           hintText: 'Enter Event Name',
                           labelText: 'Event Name',
                         ),
                         onChanged: (value){
                           setState(() {
                             _name = value;
                           });
                         },
                       ),
                          DropdownButton<EventType>(
                            value: dropDownValue,
                            items: EventType.values.map((EventType value){
                              return DropdownMenuItem<EventType>(
                              value: value,
                              child: Text(value.name));
                              }).toList(),
                            onChanged: (EventType value) {
                              setState(() {
                                dropDownValue = value;
                              });
                            },

                          ),
//                       TextFormField(
//                         decoration: const InputDecoration(
//                           icon: const Icon(Icons.local_activity),
//                           hintText: 'Enter type of event to organize',
//                           labelText: 'Event Type',
//                         ),
//                         onChanged: (value){
//                           setState(() {
//                             _description = value;
//                           });
//                         },
//                       ),
//                       TextFormField(
//                         decoration: const InputDecoration(
//                           icon: const Icon(Icons.date_range),
//                           hintText: 'Enter Event Date',
//                           labelText: 'Event Date',
//                         ),
//                       ),
                     BasicDateTimeField(
                      onChng: takedate,
                     ),
                       TextFormField(
                         decoration: const InputDecoration(
                           icon: const Icon(Icons.timelapse),
                           hintText: 'Enter duration of event',
                           labelText: 'Duration in minutes',
                         ),
                         keyboardType: TextInputType.number,
                           onChanged: (value){
                             setState(() {
                               _duration = double.parse(value);
                             });
                           },
                       ),
                       TextFormField(
                         decoration: const InputDecoration(
                           icon: const Icon(Icons.location_on),
                           hintText: 'Enter venue',
                           labelText: 'Veneue',
                         ),
                         onChanged: (value){
                           setState(() {
                             _venue = value;
                           });
                         },
                       ),
                       SizedBox(height: 20.0),
                       Card(
                           color: Colors.grey[200],
                           child: Padding(
                             padding: EdgeInsets.all(8.0),
                             child: TextField(
                               maxLines: 8,
                               decoration: InputDecoration.collapsed(hintText: "Add Event Description"),
                               onChanged: (value){
                                 setState(() {
                                   _description = value;
                                 });
                               },
                             ),
                           )
                       ),
                       FlatButton(child: Text("Save"), onPressed: () {
                         saveEvent();
                       print("iski ma ka bhosda");
                       },


                       )
                     ],
                   ),
               ),
            ),
          ],
         ),
      ),
    );
  }

  void saveEvent() async {
    print("+++++++++++++++++++++++++++++++++" + _eventID);
  _event = new Post(_name, _venue, _organiserID, _time, _duration, _description, _imageUrl, dropDownValue.name);
  DocumentReference ref = await _firestore.collection('events').add({
    'duration': "bakchodi",
    'title' : "abbbbbbb",
//    'eventTime' : _event.eventTime.toString(),
//    'eventDescription' : _event.eventDescription,
//    'imageUrl' : _event.imageUrl,
//    'venue' : _event.venue,
//    'organiserID' : _event.organiserId,
//    'eventType' : _event.eventType,
  });
  print("gaanddduu");
  _eventID = ref.documentID;

  print("22222222222222222222222222222222222" + _eventID);
  _firestore.collection('events').document(_eventID).updateData({
    'eventID' : _eventID,
  });
  }
}
