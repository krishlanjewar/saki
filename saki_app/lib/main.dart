import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app.dart';
import 'core/database/app_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize local DB and other services before running app
  final appDatabase = AppDatabase.instance;
  await appDatabase.init();

  runApp(
    ProviderScope(
      overrides: [
        databaseProvider.overrideWithValue(appDatabase),
      ],
      child: const SakiApp(),
    ),
  );
}
