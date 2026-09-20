import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/di/injection.dart';
import 'core/localization/app_localizations.dart';
import 'core/localization/app_strings.dart';
import 'core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const BusinoApp());

  configureDependencies().then<void>(
    (_) {},
    onError: (Object error, StackTrace stackTrace) {
      debugPrint('Dependency configuration failed: $error');
      debugPrintStack(stackTrace: stackTrace);
    },
  );
}

class BusinoApp extends StatelessWidget {
  const BusinoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Busino',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,

      // ─── Localization ───
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('fa', 'IR'),

      home: const _HomePage(),
    );
  }
}

class _HomePage extends StatelessWidget {
  const _HomePage();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.appName),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_none),
              tooltip: 'اعلان‌ها',
            ),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          children: [
            Text(
              '${AppStrings.goodMorning} 👋',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              AppStrings.homeSubtitle,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),
            const _RouteSearchCard(),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppStrings.allRoutes,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(AppStrings.seeAll),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const _RoutePreview(
              line: 'خط ۱',
              route: 'میدان ولیعصر تا دانشگاه تهران',
              time: 'هر ۱۰ دقیقه',
              color: Colors.teal,
            ),
            const SizedBox(height: 12),
            const _RoutePreview(
              line: 'خط ۲',
              route: 'پارک ملت تا میدان آزادی',
              time: 'هر ۱۵ دقیقه',
              color: Colors.orange,
            ),
          ],
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: 0,
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: AppStrings.navHome),
            NavigationDestination(icon: Icon(Icons.alt_route), label: AppStrings.navRoutes),
            NavigationDestination(icon: Icon(Icons.confirmation_num_outlined), label: AppStrings.navTicket),
            NavigationDestination(icon: Icon(Icons.person_outline), label: AppStrings.navProfile),
          ],
          onDestinationSelected: (_) {},
        ),
      ),
    );
  }
}

class _RouteSearchCard extends StatelessWidget {
  const _RouteSearchCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.trip_origin),
                labelText: AppStrings.origin,
                hintText: AppStrings.originHint,
              ),
            ),
            const SizedBox(height: 12),
            const TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.location_on_outlined),
                labelText: AppStrings.destination,
                hintText: AppStrings.destHint,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.search),
                label: const Text(AppStrings.findBestRoute),
              ),
            ),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.my_location),
              label: const Text(AppStrings.useMyLocation),
            ),
          ],
        ),
      ),
    );
  }
}

class _RoutePreview extends StatelessWidget {
  const _RoutePreview({
    required this.line,
    required this.route,
    required this.time,
    required this.color,
  });

  final String line;
  final String route;
  final String time;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color,
          child: Text(line.replaceAll('خط ', '')),
        ),
        title: Text(route),
        subtitle: Text(time),
        trailing: const Icon(Icons.chevron_left),
        onTap: () {},
      ),
    );
  }
}