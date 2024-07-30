import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'customer.dart';
import 'customer_dao.dart';

part 'app_database.g.dart'; // Generated code will be here

@Database(version: 1, entities: [Customer])
abstract class AppDatabase extends FloorDatabase {
  CustomerDao get customerDao;
}