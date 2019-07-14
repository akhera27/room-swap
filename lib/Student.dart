 class Student {
  String name;
  String phoneNumber;
  String currentHostel;
  int current;
  String desiredHostel;
  int desired;
  static Student newentry = Student("", "", "", "");
  List<String> rooms = ["M2WAT", "M2WST", "M1WAT","M1WST" , "J1","A1"];
  Student(this.name, this.phoneNumber,this.currentHostel,this.desiredHostel):assert(name!=null),assert(phoneNumber!=null),assert(currentHostel!=null),assert(desiredHostel!=null);
  static int counter=0;
}

