import 'package:room_swap/Student.dart';
import 'package:room_swap/Database.dart';

class DataStructure{
  Map<String,List<Student>> allotedMap = new Map();
  List<String> rooms = ["M2WAT", "M2WST", "M1WAT","M1WST" , "J1","A1"];
  DataStructure(){
    allot();
  }
  List<Student> possibleSwaps = Database.database;


  void allot(){
    rooms.forEach((String str){
      allotedMap[str]= new List();
    });


    possibleSwaps.forEach((Student student){

      allotedMap[student.currentHostel].add(student);
    });
  }

  List<Student> directSearch(Student nentry){
    List<Student> results = new List() ;
    if(allotedMap.containsKey(nentry.desiredHostel)== false)
      return null;
    else {
      allotedMap[nentry.desiredHostel].forEach((e) {
        if (e.desiredHostel == nentry.currentHostel)
          results.add(e);
      });
    }

    return results;
  }

  List<Student> longSearch(Student nentry){
    List<Student> results = new List() ;
    if(allotedMap.containsKey(nentry.desiredHostel)== false)
      return null;
    else {
      allotedMap[nentry.desiredHostel].forEach((e) {
        if (e.desiredHostel == nentry.currentHostel)
          results.add(e);
      });
    }
    return results;
  }

}


//[
//Student("Aryan", "4663464", "M1WAT", "J1"),
//Student("Aryan", "4663464", "M2WAT", "M1WST"),
//Student("Aryan", "4663464", "M1WAT", "A1"),
//Student("Aryan", "4663464", "A1", "M1WST"),
//Student("Aryan", "56533", "A1", "M2WAT"),
//Student("Aryan", "4663464", "M2WST", "J1"),
//Student("Aryan", "4663464", "M1WAT", "J1"),
//Student("Aryan", "4663464", "M2WAT", "M1WST"),
//Student("Aryan", "4663464", "M1WAT", "A1"),
//Student("Aryan", "4663464", "A1", "M1WST"),
//Student("Aryan", "4663464", "A1", "M2WAT"),
//Student("Aryan", "4663464", "M2WST", "J1"),
//Student("Aryan", "4663464", "M1WAT", "J1"),
//Student("Aryan", "4663464", "M2WAT", "M1WST"),
//Student("Aryan", "4663464", "M1WAT", "A1"),
//Student("Aryan", "4663464", "A1", "M1WST"),
//Student("Aryan", "4663464", "A1", "M2WAT"),
//Student("Aryan", "4663464", "M2WST", "J1"),
//Student("Aryan", "4663464", "M1WAT", "J1"),
//Student("Aryan", "4663464", "M2WAT", "M1WST"),
//Student("Aryan", "4663464", "M1WAT", "A1"),
//Student("Aryan", "4663464", "J1", "M1WST"),
//Student("Aryan", "4663464", "A1", "M2WAT"),
//Student("Aryan", "4663464", "M2WST", "J1"),
//];