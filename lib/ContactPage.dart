import 'package:flutter/material.dart';
import 'RoomPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:room_swap/Student.dart';
import 'showChart.dart';


class ContactPageRoute extends CupertinoPageRoute {
  ContactPageRoute()
      : super(builder: (BuildContext context) => new ContactPage());



  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return new FadeTransition(opacity: animation, child: new ContactPage());
  }
}

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => new _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("CONTACT INFO", style: TextStyle(color: Colors.purple),),
          backgroundColor: Colors.white,
          elevation: 0.0,),
        body: contact(),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.of(context).push(showChartRoute());
          },
          backgroundColor: Colors.black,
        child: Icon(Icons.insert_chart),),
    );
  }
}

class contact extends StatefulWidget {
  @override
  _contactState createState() => _contactState();
}

class _contactState extends State<contact> {

  String nameText;
  String phoneText;
  bool _validateName= false;
  bool _validateNum= false;
  Student st = new Student("", "", "", "");

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(20.0),
        child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              TextField(onChanged: (String str) {
                setState(() {
                  nameText = str;
                  _validateName = nameText.isEmpty;
                });
              },
                  onEditingComplete: () {},
                  decoration: InputDecoration(
                    labelText: "Name",
                    enabledBorder: OutlineInputBorder(),
                    errorText: _validateName
                        ? "Don't leave the field empty"
                        : null,

                  )
              ),
              SizedBox(height: 40.0,),
              TextField(keyboardType: TextInputType.numberWithOptions(),
                  onChanged: (String num) {
                    setState(() {
                      phoneText = num;
                      _validateNum = phoneText.length == 10? false : true;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: "Phone No.", prefixText: "+91",
                    enabledBorder: OutlineInputBorder(),
                    errorText: _validateNum ? "Enter a valid number" : null,
                  )
              ),
              SizedBox(height: 40.0,),
              RaisedButton(
                color: Colors.black,
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(45.0)),
                onPressed: () {
                  final snackbar = SnackBar(
                      content: Text("Don't leave the fields empty", style: TextStyle(fontSize: 16.0),));
                  print(phoneText);
                  print(nameText);

                  if (nameText == null || phoneText == null || nameText.isEmpty||phoneText.isEmpty) {
//                    _validateName = true;
//                    _validateNum = true;
                    Scaffold.of(context).showSnackBar(snackbar);
                  }
                  else if (_validateName == false && _validateNum == false) {
                    Student.newentry.name = nameText;
                    Student.newentry.phoneNumber= phoneText;
                    Navigator.of(context).push(new RoomPageRoute());
                  }
                },
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text("Next",
                    style: TextStyle(color: Colors.white, fontSize: 16.0),),
                ),
              ),
            ])));
  }
}
