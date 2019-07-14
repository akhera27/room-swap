import 'package:flutter/material.dart';
import 'Database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';

class showChartRoute extends CupertinoPageRoute {
  showChartRoute()
      : super(builder: (BuildContext context) => new showChart());



  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return new FadeTransition(opacity: animation, child: new showChart());
  }
}


class showChart extends StatefulWidget {

  @override
  _showChartState createState() => _showChartState();
}


class _showChartState extends State<showChart> {
  Map<String, double> dataMap = new Map();
  int totalEnteries=0;
  int nom1wat=0;
  int nom1wst=0;
  int nom2wat=0;
  int nom2wst=0;
  int noj1=0;
  int noa1=0;


  @override
  void initState() {


    Database().getData('M1WAT').then((QuerySnapshot docs){
      nom1wat =docs.documents.length;
    });
    print(nom1wat);
    Database().getData("M1WST").then((QuerySnapshot docs){
      nom1wst =docs.documents.length;
    });
    Database().getData('M2WAT').then((QuerySnapshot docs){
      nom2wat =docs.documents.length;
    });
    Database().getData('M2WST').then((QuerySnapshot docs){
      nom2wst =docs.documents.length;
    });
    Database().getData('J1').then((QuerySnapshot docs){
      noj1 =docs.documents.length;
      print(docs.documents[1]['name']);
      print(docs.documents[1]['phoneNumber']);
      print("desired: "+docs.documents[1]['desired']);
      print("current: "+docs.documents[1]['current']);
    });
    Database().getData('A1').then((QuerySnapshot docs){
      noa1 =docs.documents.length;
    });


    super.initState();
  }

  writeCounter(String keyv, String value ) async {

      final path = await getApplicationDocumentsDirectory();
      var file = File('${path.path}/my_file.txt');
      await file.writeAsString('$keyv: ' + '$value');
      print(path.path);

  }
  Future _incrementCounter() async{
    await Future.delayed(Duration(seconds: 1));
    String value= "";

    Database().getCollectionData().then((QuerySnapshot docs){
      totalEnteries = docs.documents.length;
      try {
        docs.documents.forEach((snapshot) {
          value = snapshot['name'];
          writeCounter('name', value);
          value = snapshot['phoneNumber'];
          writeCounter('phoneNumber', value);
          value = snapshot['current'];
          writeCounter('current room', value);
          value = snapshot['desired'];
          writeCounter('desired room', value);
        });
      }
      catch(e){
        print("Couldn't write file");
      }

    });



    print(totalEnteries);

  }

  Future ftr() async {
    await Future.delayed(Duration(milliseconds: 2200));
    dataMap.putIfAbsent("M1WAT",() =>nom1wat.toDouble());
    dataMap.putIfAbsent("M1WST", () => nom1wst.toDouble());
    dataMap.putIfAbsent("M2WAT", () => nom2wat.toDouble());
    dataMap.putIfAbsent("M2WST", () => nom2wst.toDouble());
    dataMap.putIfAbsent("J1", () => noj1.toDouble());
    print(noj1);
    dataMap.putIfAbsent("A1", () => noa1.toDouble());
    return dataMap;
  }

  @override
  Widget build(BuildContext context) {


    dataMap.putIfAbsent("M1WAT", () => 2.0);
    return Scaffold( 
        appBar: AppBar(backgroundColor: Colors.black,title: Text("CHART",style: TextStyle(color: Colors.white),),),
        body: Column(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[
          Text("Desired Hostel\nTotal Enteries: $totalEnteries",style: TextStyle(fontSize: 18.0),),
         SizedBox(height: 22.0,),
         Card(
           margin: EdgeInsets.fromLTRB(15.0,25.0,15.0,25.0),
           child:Padding(padding: EdgeInsets.fromLTRB(5.0,45.0,5.0,45.0),
             child:FutureBuilder(
                 future: ftr(),
                 initialData: dataMap,
                 builder: (context,snapshot){
             return PieChart(
             dataMap: dataMap, //Required parameter
             legendFontColor: Colors.blueGrey[900],
             legendFontSize: 14.0,
             legendFontWeight: FontWeight.w500,
             animationDuration: Duration(milliseconds: 800),
             chartLegendSpacing: 32.0,
             chartRadius: MediaQuery
                 .of(context)
                 .size
                 .width / 2.7,
             showChartValuesInPercentage: true,
             showChartValues: true,
             showChartValuesOutside: true,
             chartValuesColor: Colors.blueGrey[900].withOpacity(0.9),
             showLegends: true,
           );}),),
         elevation: 2.0,
        color: Colors.white,),
          RaisedButton(onPressed:()
          {
            Navigator.of(context).push(showChartRoute());
            _incrementCounter();

          }
          ,child: Icon(Icons.refresh,color: Colors.white,),color: Colors.black,)

    ],)
    );
  }
}




