import '../../domain/entities/station.dart';
import '../../domain/entities/bus_route.dart';
import '../../domain/entities/driver.dart';
import '../../domain/entities/trip.dart';
import '../../domain/entities/reservation.dart';
import '../../domain/entities/ticket.dart';
import '../../domain/entities/app_user.dart';
import '../models/station_model.dart';
import '../models/route_model.dart';
import '../models/driver_model.dart';
import '../models/trip_model.dart';
import '../models/reservation_model.dart';
import '../models/ticket_model.dart';
import '../models/user_model.dart';

/// تبدیل مدل‌های دیتابیس به Entity های دامنه
class EntityMappers {
  EntityMappers._();

  // ─── Station ───
  static Station stationFromModel(StationModel m) => Station(
        id: m.id,
        name: m.name,
        address: m.address,
        lat: m.lat,
        lng: m.lng,
        routeIds: m.routeIds,
      );

  // ─── BusRoute ───
  static BusRoute routeFromModel(RouteModel m) => BusRoute(
        id: m.id,
        code: m.code,
        name: m.name,
        originStationId: m.originStationId,
        destStationId: m.destStationId,
        stopIds: m.stopIds,
        price: m.price,
        durationMinutes: m.durationMinutes,
      );

  // ─── Driver ───
  static Driver driverFromModel(DriverModel m) => Driver(
        id: m.id,
        name: m.name,
        phone: m.phone,
        rating: m.rating,
        totalTrips: m.totalTrips,
      );

  // ─── Trip ───
  static Trip tripFromModel(TripModel m) => Trip(
        id: m.id,
        routeId: m.routeId,
        driverId: m.driverId,
        busNumber: m.busNumber,
        busPlate: m.busPlate,
        departureTime:
            DateTime.fromMillisecondsSinceEpoch(m.departureTime),
        arrivalTime: DateTime.fromMillisecondsSinceEpoch(m.arrivalTime),
        capacity: m.capacity,
        occupied: m.occupied,
        status: m.status,
        currentLat: m.currentLat,
        currentLng: m.currentLng,
      );

  // ─── Reservation ───
  static Reservation reservationFromModel(ReservationModel m) => Reservation(
        id: m.id,
        userId: m.userId,
        tripId: m.tripId,
        routeId: m.routeId,
        originStationId: m.originStationId,
        destStationId: m.destStationId,
        status: m.status,
        price: m.price,
        createdAt: DateTime.fromMillisecondsSinceEpoch(m.createdAt),
        confirmedAt: m.confirmedAt != null
            ? DateTime.fromMillisecondsSinceEpoch(m.confirmedAt!)
            : null,
      );

  // ─── Ticket ───
  static Ticket ticketFromModel(TicketModel m) => Ticket(
        id: m.id,
        reservationId: m.reservationId,
        ticketCode: m.ticketCode,
        qrData: m.qrData,
        issuedAt: DateTime.fromMillisecondsSinceEpoch(m.issuedAt),
        expiresAt: m.expiresAt != null
            ? DateTime.fromMillisecondsSinceEpoch(m.expiresAt!)
            : null,
        usedAt: m.usedAt != null
            ? DateTime.fromMillisecondsSinceEpoch(m.usedAt!)
            : null,
      );

  // ─── AppUser ───
  static AppUser userFromModel(UserModel m) => AppUser(
        id: m.id,
        firstName: m.firstName,
        lastName: m.lastName,
        mobile: m.mobile,
        walletBalance: m.walletBalance,
        createdAt: DateTime.fromMillisecondsSinceEpoch(m.createdAt),
      );
}