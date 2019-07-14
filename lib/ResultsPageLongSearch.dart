import 'package:flutter/material.dart';
import 'package:room_swap/Student.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'DataStructure.dart';



class ResultsPageLongSearchRoute extends CupertinoPageRoute {
  ResultsPageLongSearchRoute()
      : super(builder: (BuildContext context) => new ResultsPageLongSearch());



  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return new FadeTransition(opacity: animation, child: new ResultsPageLongSearch());
  }
}

class ResultsPageLongSearch extends StatefulWidget {
  @override
  _ResultsPageLongSearchState createState() => new _ResultsPageLongSearchState();
}

class _ResultsPageLongSearchState extends State<ResultsPageLongSearch> {

  @override
  Widget build(BuildContext context) {
    Student newentry =Student.newentry;
  DataStructure dataStructure = new DataStructure();
  List<Student> results = dataStructure.longSearch(newentry);
  if(results.isEmpty||results == null)
    print("Empty List");

    return Scaffold(
        appBar: AppBar(title: Text("Multiple Swaps",style: TextStyle(color: Colors.purple)),backgroundColor: Colors.white,elevation: 0.0,),
        body: Container(
          margin: EdgeInsets.all(20.0),
          child:Center(child:Column(children: <Widget>[
            Container(height: MediaQuery.of(context).size.height/2.5,
              child: results.isEmpty||results == null ?Text("No results found Try long search",style: TextStyle(fontSize: 24.0),):
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
                  Icon(Icons.swap_vert)],)),
                );
              },
               ),),
            SizedBox(height: 16.0,),
            Text("Share the app to increase the database and check back again",style: TextStyle(color: Colors.deepOrange, fontSize: 24.0),),
            SizedBox(height: 16.0,),
            Text("Current enteries in database: ",style: TextStyle(color: Colors.purple, fontSize: 18.0),),
          ],) ,) ,
        ));
  }
}








//Widget build(BuildContext context) {
//  Student newentry =Student.newentry;
//  DataStructure dataStructure = new DataStructure();
//  List<Student> results = dataStructure.longSearch(newentry);
//  if(results.isEmpty||results == null)
//    print("Empty List");
//
//  return Scaffold(
//      appBar: AppBar(title: Text("Multiple Swaps",style: TextStyle(color: Colors.purple)),backgroundColor: Colors.white,elevation: 0.0,),
//      body: Container(
//        margin: EdgeInsets.all(20.0),
//        child:Center(child:Column(children: <Widget>[
//          Container(height: MediaQuery.of(context).size.height/2.5,
//            child: results.isEmpty||results == null ?Text("No results found Try long search",style: TextStyle(fontSize: 24.0),):
//            ListView.builder(
//              shrinkWrap: true,
//
//              itemCount: results.length,
//              itemBuilder: (context, index){
//                return ListTile(
//                  onTap:(){
//                    Clipboard.setData(new ClipboardData(text: results[index].phoneNumber));
//                    Scaffold.of(context).showSnackBar(SnackBar(content: Text("Phone Number: ${results[index].phoneNumber} Copied")));
//                  } ,
//                  trailing: IconButton(icon: Icon(Icons.content_copy),onPressed:  ()  {
//                    Clipboard.setData(new ClipboardData(text: results[index].phoneNumber));
//                    Scaffold.of(context).showSnackBar(SnackBar(content: Text("Phone Number: ${results[index].phoneNumber} Copied")));
//
//                  }
//                    ,),
//                  title: Text('${results[index].name}'),
//                  contentPadding: EdgeInsets.all(5.0),
//                  leading: Icon(Icons.account_circle),
//                  subtitle: (Column(children: <Widget>[
//                    Text('Current Room: ${results[index].currentHostel}', softWrap: true,)
//                    ,Text('Desired Room: ${results[index].desiredHostel}', softWrap: true),
//                    Text('Phone Number: ${results[index].phoneNumber}', softWrap: true),
//                    Icon(Icons.swap_vert)],)),
//                );
//              },
//            ),),
//          SizedBox(height: 16.0,),
//          Text("Share the app to increase the database and check back again",style: TextStyle(color: Colors.deepOrange, fontSize: 24.0),),
//          SizedBox(height: 16.0,),
//          Text("Current enteries in database: ${dataStructure.possibleSwaps.length}",style: TextStyle(color: Colors.purple, fontSize: 18.0),),
//        ],) ,) ,
//      ));
//}