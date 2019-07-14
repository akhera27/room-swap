import 'package:cloud_firestore/cloud_firestore.dart';
import 'Student.dart';

import 'dart:async';

class Database {

  static List<Student> database = new List();


  Future<QuerySnapshot> getCollectionData() {
    return Firestore.instance
        .collection('students').getDocuments();
  }

  getData(String alr) {

    return Firestore.instance
        .collection('students').where('desired',isEqualTo : alr).getDocuments();
  }

  getNewData(String alr) {

    return Firestore.instance
        .collection('students').where('phoneNumber',isEqualTo : alr).getDocuments();
  }
}


//Future<int> sizeOflist = Firestore.instance
//    .collection('students')
//    .snapshots()
//    .length;
//int size;
//
//List<Student> getData() {
//  sizeOflist.then((int i) => size = i);
//  for (int index = 0; index < size; index++) {
//    Firestore.instance.collection('students').document('student$index')
//        .get().then((DocumentSnapshot) {
//      database.add(
//          new Student(
//              DocumentSnapshot.data['name'].toString(),
//              DocumentSnapshot.data['phoneNumber'].toString(),
//              DocumentSnapshot.data['current'].toString(),
//              DocumentSnapshot.data['desired'].toString()
//          )
//      );
//    }
//    );
//  }
//  print(database[0].currentHostel);
//  return database;
//}