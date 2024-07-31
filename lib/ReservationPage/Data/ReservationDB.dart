import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'BookDAO.dart';
import 'BookFlight.dart';

part  '';

@Database(version: 1, entities: [BookFlight])
abstract class ReservationDB extends FloorDatabase {
  BookDAO get bookDao;
}