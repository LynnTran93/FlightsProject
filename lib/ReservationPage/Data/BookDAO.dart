import 'package:floor/floor.dart';
import 'BookFlight.dart';

@dao
abstract class BookDAO {
  @Query("SELECT * FROM BookFlight")
  Future<List<BookFlight>> getBookFlight();

  @insert
  Future<void> bookInsert(BookFlight reserve);

}