import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import '../entity/flight.dart';
import '../dao/flight_dao.dart';

import 'package:final_project_flights_list/ReservationPage/BookDAO.dart';
import 'package:final_project_flights_list/ReservationPage/BookFlight.dart';

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [Flight])
abstract class AppDatabase extends FloorDatabase {
  FlightDao get flightDao;
}

@Database(version: 2, entities: [BookFlight])
abstract class ReservationDB extends FloorDatabase {
  BookDAO get bookDao;
}