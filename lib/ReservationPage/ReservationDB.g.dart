// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ReservationDB.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $ReservationDBBuilderContract {
  /// Adds migrations to the builder.
  $ReservationDBBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $ReservationDBBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<ReservationDB> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorReservationDB {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $ReservationDBBuilderContract databaseBuilder(String name) =>
      _$ReservationDBBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $ReservationDBBuilderContract inMemoryDatabaseBuilder() =>
      _$ReservationDBBuilder(null);
}

class _$ReservationDBBuilder implements $ReservationDBBuilderContract {
  _$ReservationDBBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $ReservationDBBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $ReservationDBBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<ReservationDB> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$ReservationDB();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$ReservationDB extends ReservationDB {
  _$ReservationDB([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  BookDAO? _bookDaoInstance;

  Future<sqflite.Database> open(
      String path,
      List<Migration> migrations, [
        Callback? callback,
      ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `BookFlight` (`id` INTEGER NOT NULL, `name` TEXT NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  BookDAO get bookDao {
    return _bookDaoInstance ??= _$BookDAO(database, changeListener);
  }
}

class _$BookDAO extends BookDAO {
  _$BookDAO(
      this.database,
      this.changeListener,
      )   : _queryAdapter = QueryAdapter(database),
        _bookFlightInsertionAdapter = InsertionAdapter(
            database,
            'BookFlight',
                (BookFlight item) =>
            <String, Object?>{'id': item.id, 'name': item.name});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<BookFlight> _bookFlightInsertionAdapter;

  @override
  Future<List<BookFlight>> getBookFlight() async {
    return _queryAdapter.queryList('SELECT * FROM BookFlight',
        mapper: (Map<String, Object?> row) =>
            BookFlight(row['id'] as int, row['name'] as String));
  }

  @override
  Future<void> bookInsert(BookFlight reserve) async {
    await _bookFlightInsertionAdapter.insert(reserve, OnConflictStrategy.abort);
  }
}
