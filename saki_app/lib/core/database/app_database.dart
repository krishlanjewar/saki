import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_database.g.dart';

class AppDatabase {
  // Placeholder for Drift database initialization logic
  AppDatabase._();
  
  static final AppDatabase instance = AppDatabase._();

  Future<void> init() async {
    // initialize drift / offline DB here
  }
}

@Riverpod(keepAlive: true)
AppDatabase database(Ref ref) {
  return AppDatabase.instance;
}
