import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'BookDAO.dart';
import 'BookFlight.dart';

part  'database.g.dart';

@Database(version: 1, entities: [BookFlight])
abstract class ReservationDB extends FloorDatabase {
  BookDAO get bookDao;
}