import 'package:floor/floor.dart';

@entity
class BookFlight {
  static int ID = 1;

  @primaryKey
  final int id;
  final String cusName;
  final String flight;

  BookFlight(this.id, this.cusName, this.flight){
    if(id > ID) {
      ID = id;
    }
  }
}