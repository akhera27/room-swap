import 'package:flutter/material.dart';
import 'ResultsPageLongSearch.dart';
import 'package:flutter/cupertino.dart';
import 'package:room_swap/Student.dart';
import 'DataStructure.dart';
import 'package:flutter/services.dart';
import 'package:room_swap/Database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'RoomPage.dart';

class ResultsPageDirectSearchRoute extends CupertinoPageRoute {
  ResultsPageDirectSearchRoute()
      : super(builder: (BuildContext context) => new ResultsPageDirectSearch());



  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return new FadeTransition(opacity: animation, child: new ResultsPageDirectSearch());
  }
}

class ResultsPageDirectSearch extends StatefulWidget {
  @override
  _ResultsPageDirectSearchState createState() => new _ResultsPageDirectSearchState();
}

class _ResultsPageDirectSearchState extends State<ResultsPageDirectSearch> {
  bool flag= false;
  bool already=false;

  @override
  void initState() {

    super.initState(); Database().getCollectionData().then((QuerySnapshot docs){
      if(docs.documents.isNotEmpty)
      {
        flag= true;
        for(int i=0; i< docs.documents.length;i++) {
          var collection = docs.documents[i].data;
//            Database.database.forEach((Student st){
//              if((st.phoneNumber == collection['phoneNumber']))
//                already=true;
//            });
          Database.database.add(
              Student(collection['name'], collection['phoneNumber'], collection['current'], collection['desired'])
          );
        }
      }
      print(Database.database.length);
    });


  }
  @override
  void dispose() {
    super.dispose();
    Database.database.clear();
  }

   Future futr() async {
    await Future.delayed(Duration(milliseconds: 2200));
    return 1;
   }

  @override
  Widget build(BuildContext context) {

    Student newentry = Student.newentry;
    DataStructure dataStructure = new DataStructure();
    List<Student> results = dataStructure.directSearch(newentry);
    return WillPopScope(onWillPop: (){
      return new Future((){ Navigator.of(context).push(RoomPageRoute());
      return false;});
    },

        child: Scaffold(
        appBar: AppBar(title: Text("RESULTS",style: TextStyle(color: Colors.purple)),backgroundColor: Colors.white,elevation: 0.0,),
        body: Container(
          margin: EdgeInsets.all(20.0),
          child:Center(child:Column(children: <Widget>[
            FutureBuilder(future: futr() ,builder: (context,snapshot){return Container(height: MediaQuery.of(context).size.height/2.5,
              child: results.isEmpty||results == null ? Text("No results found Press Refresh button",style: TextStyle(fontSize: 24.0),):
              ListView.builder(
                shrinkWrap: true,

                itemCount: results.length,
                itemBuilder: (context, index){
                  return ListTile(
                    onTap:(){
                      Clipboard.setData(new ClipboardData(text: results[index].phoneNumber));
                      Scaffold.of(context).showSnackBar(SnackBar(content: Text("Phone Number: ${results[index].phoneNumber} Copied")));
                    } ,
                    trailing: IconButton(icon: Icon(Icons.content_copy),onPressed:  ()  {
                      Clipboard.setData(new ClipboardData(text: results[index].phoneNumber));
                      Scaffold.of(context).showSnackBar(SnackBar(content: Text("Phone Number: ${results[index].phoneNumber} Copied")));

                    }
                      ,),
                    title: Text('${results[index].name}'),
                    contentPadding: EdgeInsets.all(5.0),
                    leading: Icon(Icons.account_circle),
                    subtitle: (Column(children: <Widget>[
                      Text('Current Room: ${results[index].currentHostel}', softWrap: true,)
                      ,Text('Desired Room: ${results[index].desiredHostel}', softWrap: true),
                      Text('Phone Number: ${results[index].phoneNumber}', softWrap: true),
                      ],)),
                  );
                },
              ));}),
            SizedBox(height: 16.0,),
            RaisedButton(
              color: Colors.black,

              elevation: 4.0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(45.0)),
              onPressed:  Student.counter>0?(){print(Student.counter);}:() {
                Student.counter ++;
                  print(Student.counter);
//                await new Future.delayed(const Duration(seconds: 3));

//                Database().getNewData();
                Navigator.of(context).push(new ResultsPageDirectSearchRoute());
              },
              child: Padding(
                padding: EdgeInsets.all(5.0),
                child: Text("Refresh",style: TextStyle(color: Colors.white, fontSize: 16.0),),
              ),
            ),
            SizedBox(height: 16.0,),
            Text("Share the app to increase the database and check back again",style: TextStyle(color: Colors.deepOrange, fontSize: 24.0),),
            SizedBox(height: 16.0,),
//            Text("Current enteries in database: ${Database.database.length}",style: TextStyle(color: Colors.purple, fontSize: 18.0),),
//

          ],) ,) ,
        ),
    ));
  }

}






//return Scaffold(
//appBar: AppBar(title: Text("RESULTS",style: TextStyle(color: Colors.purple)),backgroundColor: Colors.white,elevation: 0.0,),
//body: Container(
//child: Center(
//child: RaisedButton(
//color: Colors.black,
//elevation: 4.0,
//shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(45.0)),
//onPressed: (){
//Navigator.of(context).push(new ResultsPageLongSearchRoute());
//},
//child: Padding(
//padding: EdgeInsets.all(5.0),
//child: Text("Long Search",style: TextStyle(color: Colors.white, fontSize: 16.0),),
//),
//),
//),
//));