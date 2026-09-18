import 'seed_data.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../../../core/constants/app_constants.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, AppConstants.dbName);
    return await openDatabase(
      path,
      version: AppConstants.dbVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Table: stations
    await db.execute('''
      CREATE TABLE ${AppConstants.tableStations} (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        address TEXT,
        lat REAL NOT NULL,
        lng REAL NOT NULL,
        route_ids TEXT,
        created_at INTEGER NOT NULL
      )
    ''');
        // Seed initial data
    await SeedData.seedIfEmpty(db);
    // Table: routes
    await db.execute('''
      CREATE TABLE ${AppConstants.tableRoutes} (
        id TEXT PRIMARY KEY,
        code TEXT NOT NULL,
        name TEXT NOT NULL,
        origin_station_id TEXT NOT NULL,
        dest_station_id TEXT NOT NULL,
        stop_ids TEXT NOT NULL,
        price INTEGER NOT NULL,
        duration_minutes INTEGER NOT NULL,
        created_at INTEGER NOT NULL
      )
    ''');

    // Table: drivers
    await db.execute('''
      CREATE TABLE ${AppConstants.tableDrivers} (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        phone TEXT,
        rating REAL DEFAULT 0,
        total_trips INTEGER DEFAULT 0,
        created_at INTEGER NOT NULL
      )
    ''');

    // Table: trips
    await db.execute('''
      CREATE TABLE ${AppConstants.tableTrips} (
        id TEXT PRIMARY KEY,
        route_id TEXT NOT NULL,
        driver_id TEXT,
        bus_number TEXT NOT NULL,
        bus_plate TEXT,
        departure_time INTEGER NOT NULL,
        arrival_time INTEGER NOT NULL,
        capacity INTEGER NOT NULL,
        occupied INTEGER NOT NULL DEFAULT 0,
        status TEXT NOT NULL,
        current_lat REAL,
        current_lng REAL,
        created_at INTEGER NOT NULL
      )
    ''');

    // Table: reservations
    await db.execute('''
      CREATE TABLE ${AppConstants.tableReservations} (
        id TEXT PRIMARY KEY,
        user_id TEXT NOT NULL,
        trip_id TEXT NOT NULL,
        route_id TEXT NOT NULL,
        origin_station_id TEXT NOT NULL,
        dest_station_id TEXT NOT NULL,
        status TEXT NOT NULL,
        price INTEGER NOT NULL,
        created_at INTEGER NOT NULL,
        confirmed_at INTEGER
      )
    ''');

    // Table: tickets
    await db.execute('''
      CREATE TABLE ${AppConstants.tableTickets} (
        id TEXT PRIMARY KEY,
        reservation_id TEXT NOT NULL,
        ticket_code TEXT NOT NULL UNIQUE,
        qr_data TEXT NOT NULL,
        issued_at INTEGER NOT NULL,
        expires_at INTEGER,
        used_at INTEGER
      )
    ''');

    // Table: users
    await db.execute('''
      CREATE TABLE ${AppConstants.tableUsers} (
        id TEXT PRIMARY KEY,
        first_name TEXT NOT NULL,
        last_name TEXT NOT NULL,
        mobile TEXT NOT NULL UNIQUE,
        password_hash TEXT,
        wallet_balance INTEGER NOT NULL DEFAULT 0,
        created_at INTEGER NOT NULL
      )
    ''');

    // Table: wallet_transactions
    await db.execute('''
      CREATE TABLE ${AppConstants.tableWallet} (
        id TEXT PRIMARY KEY,
        user_id TEXT NOT NULL,
        amount INTEGER NOT NULL,
        type TEXT NOT NULL,
        description TEXT,
        created_at INTEGER NOT NULL
      )
    ''');

    // Indexes for performance
    await db.execute(
      'CREATE INDEX idx_trips_route ON ${AppConstants.tableTrips}(route_id)',
    );
    await db.execute(
      'CREATE INDEX idx_trips_departure ON ${AppConstants.tableTrips}(departure_time)',
    );
    await db.execute(
      'CREATE INDEX idx_stations_location ON ${AppConstants.tableStations}(lat, lng)',
    );
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // برای نسخه‌های بعدی
  }

  Future<void> close() async {
    final db = await database;
    db.close();
    _database = null;
  }

  Future<void> deleteDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, AppConstants.dbName);
    await databaseFactory.deleteDatabase(path);
    _database = null;
  }
}