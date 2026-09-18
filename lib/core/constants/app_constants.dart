class AppConstants {
  AppConstants._();

  // App Info
  static const String appName = 'Busino';
  static const String appVersion = '1.0.0';

  // Database
  static const String dbName = 'busino.db';
  static const int dbVersion = 1;

  // Table Names
  static const String tableStations = 'stations';
  static const String tableRoutes = 'routes';
  static const String tableTrips = 'trips';
  static const String tableReservations = 'reservations';
  static const String tableTickets = 'tickets';
  static const String tableDrivers = 'drivers';
  static const String tableUsers = 'users';
  static const String tableWallet = 'wallet_transactions';

  // Default Values
  static const double defaultSearchRadiusKm = 2.0;
  static const int maxNearbyStations = 5;
  static const int defaultBusCapacity = 40;
  static const int boardBeforeMinutes = 5;
  static const int noShowPenaltyAmount = 5000;

  // Ticket Statuses
  static const String ticketPending = 'pending';
  static const String ticketConfirmed = 'confirmed';
  static const String ticketCancelled = 'cancelled';
  static const String ticketExpired = 'expired';
  static const String ticketUsed = 'used';
  static const String ticketNoShow = 'no_show';
  static const String ticketWaiting = 'waiting';

  // Trip Statuses
  static const String tripAvailable = 'available';
  static const String tripAlmostFull = 'almost_full';
  static const String tripFull = 'full';
  static const String tripDeparted = 'departed';
  static const String tripCancelled = 'cancelled';

  // Shared Preferences Keys
  static const String prefUserId = 'user_id';
  static const String prefIsLoggedIn = 'is_logged_in';
  static const String prefLanguage = 'language';
  static const String prefFirstLaunch = 'first_launch';
}