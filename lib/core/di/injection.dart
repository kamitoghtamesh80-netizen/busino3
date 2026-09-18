import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Datasources
import '../../data/datasources/local/database_helper.dart';

// Repositories (Interfaces)
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/location_repository.dart';
import '../../domain/repositories/reservation_repository.dart';
import '../../domain/repositories/route_repository.dart';
import '../../domain/repositories/station_repository.dart';
import '../../domain/repositories/ticket_repository.dart';
import '../../domain/repositories/trip_repository.dart';
import '../../domain/repositories/wallet_repository.dart';

// Repositories (Implementations)
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/repositories/location_repository_impl.dart';
import '../../data/repositories/reservation_repository_impl.dart';
import '../../data/repositories/route_repository_impl.dart';
import '../../data/repositories/station_repository_impl.dart';
import '../../data/repositories/ticket_repository_impl.dart';
import '../../data/repositories/trip_repository_impl.dart';
import '../../data/repositories/wallet_repository_impl.dart';

// UseCases
import '../../domain/usecases/auth/login.dart';
import '../../domain/usecases/auth/logout.dart';
import '../../domain/usecases/auth/register.dart';
import '../../domain/usecases/location/get_current_location.dart';
import '../../domain/usecases/reservation/create_reservation.dart';
import '../../domain/usecases/reservation/get_user_reservations.dart';
import '../../domain/usecases/route/get_all_routes.dart';
import '../../domain/usecases/route/get_route_by_id.dart';
import '../../domain/usecases/route/search_routes.dart';
import '../../domain/usecases/station/get_all_stations.dart';
import '../../domain/usecases/station/get_nearby_stations.dart';
import '../../domain/usecases/station/search_stations.dart';
import '../../domain/usecases/ticket/get_user_tickets.dart';
import '../../domain/usecases/ticket/issue_ticket.dart';
import '../../domain/usecases/trip/get_trips_by_route.dart';
import '../../domain/usecases/trip/get_upcoming_trips_at_station.dart';
import '../../domain/usecases/wallet/get_balance.dart';
import '../../domain/usecases/wallet/top_up_wallet.dart';

final getIt = GetIt.instance;

/// راه‌اندازی همه‌ی وابستگی‌ها
/// این تابع توی main.dart قبل از runApp صدا زده می‌شه.
Future<void> configureDependencies() async {
  // ══════════════════════════════════════════════
  //  External
  // ══════════════════════════════════════════════
  final prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(prefs);

  // ══════════════════════════════════════════════
  //  Datasources
  // ══════════════════════════════════════════════
  getIt.registerLazySingleton<DatabaseHelper>(
    () => DatabaseHelper.instance,
  );

  // ══════════════════════════════════════════════
  //  Repositories
  // ══════════════════════════════════════════════
  getIt.registerLazySingleton<StationRepository>(
    () => StationRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<RouteRepository>(
    () => RouteRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<TripRepository>(
    () => TripRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<ReservationRepository>(
    () => ReservationRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<TicketRepository>(
    () => TicketRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt(), getIt()),
  );
  getIt.registerLazySingleton<WalletRepository>(
    () => WalletRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<LocationRepository>(
    () => LocationRepositoryImpl(),
  );

  // ══════════════════════════════════════════════
  //  UseCases
  // ══════════════════════════════════════════════

  // Station
  getIt.registerLazySingleton(() => GetAllStations(getIt()));
  getIt.registerLazySingleton(() => SearchStations(getIt()));
  getIt.registerLazySingleton(() => GetNearbyStations(getIt()));

  // Route
  getIt.registerLazySingleton(() => GetAllRoutes(getIt()));
  getIt.registerLazySingleton(() => GetRouteById(getIt()));
  getIt.registerLazySingleton(() => SearchRoutes(getIt()));

  // Trip
  getIt.registerLazySingleton(() => GetTripsByRoute(getIt()));
  getIt.registerLazySingleton(() => GetUpcomingTripsAtStation(getIt()));

  // Reservation
  getIt.registerLazySingleton(() => CreateReservation(getIt()));
  getIt.registerLazySingleton(() => GetUserReservations(getIt()));

  // Ticket
  getIt.registerLazySingleton(() => IssueTicket(getIt()));
  getIt.registerLazySingleton(() => GetUserTickets(getIt()));

  // Auth
  getIt.registerLazySingleton(() => Login(getIt()));
  getIt.registerLazySingleton(() => Register(getIt()));
  getIt.registerLazySingleton(() => Logout(getIt()));

  // Wallet
  getIt.registerLazySingleton(() => GetBalance(getIt()));
  getIt.registerLazySingleton(() => TopUpWallet(getIt()));

  // Location
  getIt.registerLazySingleton(() => GetCurrentLocation(getIt()));
}