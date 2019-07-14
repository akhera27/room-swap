import 'package:flutter/material.dart';
import 'ResultsPageDirectSearch.dart';
import 'package:flutter/cupertino.dart';
import 'package:room_swap/Student.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Database.dart';
import 'ContactPage.dart';

class RoomPageRoute extends CupertinoPageRoute {
  RoomPageRoute()
      : super(builder: (BuildContext context) => new RoomPage());



  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return new FadeTransition(opacity: animation, child: new RoomPage());
  }
}

class RoomPage extends StatefulWidget {
  @override
  _RoomPageState createState() => new _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("ROOM INFO",style: TextStyle(color: Colors.purple)),backgroundColor: Colors.white,elevation: 0.0,),
        body: roomPage());
  }
}

class roomPage extends StatefulWidget {
  @override
  _roomPageState createState() => _roomPageState();
}

class _roomPageState extends State<roomPage> {
  List<String> rooms = ["M2WAT", "M2WST", "M1WAT","M1WST" , "J1","A1"];
  String currentitemSelected = "M2WAT";
  String DesireditemSelected = "M1WAT";

  @override
  Widget build(BuildContext context) {

    return  WillPopScope(onWillPop: (){
      return new Future((){ Navigator.of(context).push(ContactPageRoute());
      return false;});
    },

    child: Container(
      margin: EdgeInsets.all(20.0),
      child: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        Row(mainAxisAlignment:MainAxisAlignment.center , children: <Widget>[Text("Select the room you're", style: TextStyle(fontSize: 16.0),),Text(" currently allocated", style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 16.0),)],),
          SizedBox(height: 10.0,),
          DropdownButton<String>(items: rooms.map((String dropDownStringItem){
            return DropdownMenuItem<String>(
              value: dropDownStringItem,
              child: Text(dropDownStringItem),
            );
          }).toList(),
            onChanged: (String newValueSelected){
            setState(() {
              currentitemSelected= newValueSelected;
            });
            },
            value: currentitemSelected,
          ),
        SizedBox(height: 16.0,),
        Row(mainAxisAlignment:MainAxisAlignment.center , children: <Widget>[Text("Select the room you", style: TextStyle(fontSize: 16.0),),Text(" want", style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 16.0),)],),

        SizedBox(height: 10.0,),
         DropdownButton<String>(items: rooms.map((String dropDownStringItem){
           return DropdownMenuItem<String>(
             value: dropDownStringItem,
             child: Text(dropDownStringItem),
           );
         }).toList(),
           onChanged: (String newValueSelected){
             setState(() {
               DesireditemSelected= newValueSelected;
             });
           },
           value: DesireditemSelected,
           elevation: 2,

         ),
        SizedBox(height: 16.0,),
         RaisedButton(
          color: Colors.black,
          elevation: 4.0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(45.0)),
          onPressed: ()  {
            Student.counter=0;
            bool flag;
            Student.newentry.desiredHostel=DesireditemSelected;
            Student.newentry.currentHostel=currentitemSelected;
            Database.database.clear();
            Database().getNewData(Student.newentry.phoneNumber).then((QuerySnapshot docs){
              if(docs.documents.isEmpty)
                Firestore.instance.collection('students').add({
                  'name': Student.newentry.name,
                  'phoneNumber': Student.newentry.phoneNumber,
                  'current': Student.newentry.currentHostel,
                  'desired': Student.newentry.desiredHostel,
                });
            });

            Navigator.of(context).push(new ResultsPageDirectSearchRoute());
          },
          child: Padding(
            padding: EdgeInsets.all(5.0),
            child: Text("Search",style: TextStyle(color: Colors.white, fontSize: 16.0),),
          ),
        ),])
      ) ),
    );
  }
}
