import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'journal_auth_service.g.dart';

class JournalAuthService {
  final FlutterSecureStorage _storage;
  static const String _pinKey = 'journal_pin_code';

  JournalAuthService(this._storage);

  /// Checks if a PIN has been set up previously
  Future<bool> hasPinSet() async {
    final pin = await _storage.read(key: _pinKey);
    return pin != null && pin.isNotEmpty;
  }

  /// Sets a new PIN
  Future<void> setPin(String pin) async {
    await _storage.write(key: _pinKey, value: pin);
  }

  /// Verifies if the provided PIN is correct
  Future<bool> verifyPin(String pin) async {
    final storedPin = await _storage.read(key: _pinKey);
    return storedPin == pin;
  }
}

@riverpod
JournalAuthService journalAuthService(Ref ref) {
  const storage = FlutterSecureStorage();
  return JournalAuthService(storage);
}
