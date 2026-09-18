import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';
import '../../../core/constants/app_constants.dart';
import '../../models/station_model.dart';
import '../../models/route_model.dart';
import '../../models/driver_model.dart';
import '../../models/trip_model.dart';

class SeedData {
  static const _uuid = Uuid();

  /// چک می‌کنه اگه دیتابیس خالیه، داده‌های اولیه رو اضافه کنه
  static Future<void> seedIfEmpty(Database db) async {
    final count = Sqflite.firstIntValue(
      await db.rawQuery('SELECT COUNT(*) FROM ${AppConstants.tableStations}'),
    );
    if (count != null && count > 0) return; // قبلاً پر شده

    await _seedStations(db);
    await _seedRoutes(db);
    await _seedDrivers(db);
    await _seedTrips(db);
  }

  // ═══════════════════════════════════════════
  //  ایستگاه‌های واقعی تهران
  // ═══════════════════════════════════════════
  static Future<void> _seedStations(Database db) async {
    final now = DateTime.now().millisecondsSinceEpoch;

    final stations = <StationModel>[
      // ─── خطوط مرکزی ───
      StationModel(
        id: 'st_valiasr',
        name: 'میدان ولیعصر',
        address: 'میدان ولیعصر، تهران',
        lat: 35.7115,
        lng: 51.4073,
        routeIds: ['rt_3', 'rt_9'],
        createdAt: now,
      ),
      StationModel(
        id: 'st_enghelab',
        name: 'میدان انقلاب',
        address: 'میدان انقلاب اسلامی، تهران',
        lat: 35.7011,
        lng: 51.3892,
        routeIds: ['rt_3', 'rt_7'],
        createdAt: now,
      ),
      StationModel(
        id: 'st_azadi',
        name: 'میدان آزادی',
        address: 'میدان آزادی، تهران',
        lat: 35.6997,
        lng: 51.3407,
        routeIds: ['rt_1'],
        createdAt: now,
      ),
      StationModel(
        id: 'st_tehran_uni',
        name: 'دانشگاه تهران',
        address: 'خیابان انقلاب، دانشگاه تهران',
        lat: 35.7005,
        lng: 51.3922,
        routeIds: ['rt_1', 'rt_3', 'rt_7', 'rt_9'],
        createdAt: now,
      ),
      StationModel(
        id: 'st_karimkhan',
        name: 'خیابان کریم‌خان',
        address: 'خیابان کریم‌خان زند، تهران',
        lat: 35.7172,
        lng: 51.4185,
        routeIds: ['rt_3'],
        createdAt: now,
      ),
      StationModel(
        id: 'st_tajrish',
        name: 'میدان تجریش',
        address: 'میدان تجریش، تهران',
        lat: 35.8049,
        lng: 51.4337,
        routeIds: ['rt_9'],
        createdAt: now,
      ),
      StationModel(
        id: 'st_vanak',
        name: 'میدان ونک',
        address: 'میدان ونک، تهران',
        lat: 35.7572,
        lng: 51.4101,
        routeIds: ['rt_9'],
        createdAt: now,
      ),
      StationModel(
        id: 'st_terminal_jonub',
        name: 'ترمینال جنوب',
        address: 'ترمینال جنوب، تهران',
        lat: 35.6457,
        lng: 51.3791,
        routeIds: ['rt_7'],
        createdAt: now,
      ),
      StationModel(
        id: 'st_rahahan',
        name: 'میدان راه‌آهن',
        address: 'میدان راه‌آهن، تهران',
        lat: 35.6582,
        lng: 51.3977,
        routeIds: ['rt_7'],
        createdAt: now,
      ),
      StationModel(
        id: 'st_ferdowsi',
        name: 'میدان فردوسی',
        address: 'میدان فردوسی، تهران',
        lat: 35.6843,
        lng: 51.3937,
        routeIds: ['rt_1'],
        createdAt: now,
      ),
    ];

    final batch = db.batch();
    for (final st in stations) {
      batch.insert(AppConstants.tableStations, st.toMap());
    }
    await batch.commit(noResult: true);
  }

  // ═══════════════════════════════════════════
  //  خطوط اتوبوس
  // ═══════════════════════════════════════════
  static Future<void> _seedRoutes(Database db) async {
    final now = DateTime.now().millisecondsSinceEpoch;

    final routes = <RouteModel>[
      RouteModel(
        id: 'rt_3',
        code: '۳',
        name: 'خط ۳',
        originStationId: 'st_valiasr',
        destStationId: 'st_tehran_uni',
        stopIds: ['st_valiasr', 'st_karimkhan', 'st_enghelab', 'st_tehran_uni'],
        price: 15000,
        durationMinutes: 18,
        createdAt: now,
      ),
      RouteModel(
        id: 'rt_1',
        code: '۱',
        name: 'خط ۱',
        originStationId: 'st_azadi',
        destStationId: 'st_tehran_uni',
        stopIds: ['st_azadi', 'st_ferdowsi', 'st_enghelab', 'st_tehran_uni'],
        price: 15000,
        durationMinutes: 25,
        createdAt: now,
      ),
      RouteModel(
        id: 'rt_7',
        code: '۷',
        name: 'خط ۷',
        originStationId: 'st_terminal_jonub',
        destStationId: 'st_tehran_uni',
        stopIds: ['st_terminal_jonub', 'st_rahahan', 'st_enghelab', 'st_tehran_uni'],
        price: 15000,
        durationMinutes: 30,
        createdAt: now,
      ),
      RouteModel(
        id: 'rt_9',
        code: '۹',
        name: 'خط ۹',
        originStationId: 'st_tajrish',
        destStationId: 'st_tehran_uni',
        stopIds: ['st_tajrish', 'st_vanak', 'st_valiasr', 'st_tehran_uni'],
        price: 15000,
        durationMinutes: 27,
        createdAt: now,
      ),
    ];

    final batch = db.batch();
    for (final r in routes) {
      batch.insert(AppConstants.tableRoutes, r.toMap());
    }
    await batch.commit(noResult: true);
  }

  // ═══════════════════════════════════════════
  //  راننده‌ها
  // ═══════════════════════════════════════════
  static Future<void> _seedDrivers(Database db) async {
    final now = DateTime.now().millisecondsSinceEpoch;

    final drivers = <DriverModel>[
      DriverModel(
        id: 'dr_1',
        name: 'رضا کریمی',
        phone: '09121111111',
        rating: 4.8,
        totalTrips: 245,
        createdAt: now,
      ),
      DriverModel(
        id: 'dr_2',
        name: 'محمد رضایی',
        phone: '09122222222',
        rating: 4.5,
        totalTrips: 180,
        createdAt: now,
      ),
      DriverModel(
        id: 'dr_3',
        name: 'علی محمدی',
        phone: '09123333333',
        rating: 4.9,
        totalTrips: 320,
        createdAt: now,
      ),
      DriverModel(
        id: 'dr_4',
        name: 'حسین احمدی',
        phone: '09124444444',
        rating: 4.2,
        totalTrips: 95,
        createdAt: now,
      ),
    ];

    final batch = db.batch();
    for (final d in drivers) {
      batch.insert(AppConstants.tableDrivers, d.toMap());
    }
    await batch.commit(noResult: true);
  }

  // ═══════════════════════════════════════════
  //  سفرها (Trip)
  // ═══════════════════════════════════════════
  static Future<void> _seedTrips(Database db) async {
    final now = DateTime.now();
    final nowMs = now.millisecondsSinceEpoch;

    final trips = <TripModel>[
      // ─── خط ۳ (ولیعصر ← دانشگاه) ───
      TripModel(
        id: _uuid.v4(),
        routeId: 'rt_3',
        driverId: 'dr_1',
        busNumber: '۴۴۲ ط ۱۸',
        busPlate: 'ایران ۸۸',
        departureTime: nowMs + 6 * 60 * 1000, // ۶ دقیقه دیگه
        arrivalTime: nowMs + 24 * 60 * 1000,
        capacity: 40,
        occupied: 27,
        status: AppConstants.tripAvailable,
        currentLat: 35.7145,
        currentLng: 51.4100,
        createdAt: nowMs,
      ),
      TripModel(
        id: _uuid.v4(),
        routeId: 'rt_3',
        driverId: 'dr_3',
        busNumber: '۵۱۸ ب ۲۲',
        busPlate: 'ایران ۷۷',
        departureTime: nowMs + 25 * 60 * 1000,
        arrivalTime: nowMs + 43 * 60 * 1000,
        capacity: 40,
        occupied: 5,
        status: AppConstants.tripAvailable,
        createdAt: nowMs,
      ),

      // ─── خط ۱ (آزادی ← دانشگاه) ───
      TripModel(
        id: _uuid.v4(),
        routeId: 'rt_1',
        driverId: 'dr_2',
        busNumber: '۲۳۷ ج ۱۱',
        busPlate: 'ایران ۶۶',
        departureTime: nowMs + 12 * 60 * 1000,
        arrivalTime: nowMs + 37 * 60 * 1000,
        capacity: 40,
        occupied: 40,
        status: AppConstants.tripFull,
        createdAt: nowMs,
      ),

      // ─── خط ۷ (ترمینال جنوب ← دانشگاه) ───
      TripModel(
        id: _uuid.v4(),
        routeId: 'rt_7',
        driverId: 'dr_4',
        busNumber: '۸۹۳ د ۵۵',
        busPlate: 'ایران ۵۵',
        departureTime: nowMs + 20 * 60 * 1000,
        arrivalTime: nowMs + 50 * 60 * 1000,
        capacity: 35,
        occupied: 35,
        status: AppConstants.tripFull,
        createdAt: nowMs,
      ),

      // ─── خط ۹ (تجریش ← دانشگاه) ───
      TripModel(
        id: _uuid.v4(),
        routeId: 'rt_9',
        driverId: 'dr_1',
        busNumber: '۶۷۵ الف ۳۳',
        busPlate: 'ایران ۴۴',
        departureTime: nowMs + 16 * 60 * 1000,
        arrivalTime: nowMs + 43 * 60 * 1000,
        capacity: 40,
        occupied: 14,
        status: AppConstants.tripAvailable,
        createdAt: nowMs,
      ),
    ];

    final batch = db.batch();
    for (final t in trips) {
      batch.insert(AppConstants.tableTrips, t.toMap());
    }
    await batch.commit(noResult: true);
  }
}