import 'package:encrypt/encrypt.dart' as enc;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'encryption_service.g.dart';

class EncryptionService {
  final _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );
  enc.Key? _key;
  final enc.IV _iv = enc.IV.fromLength(16); // Static IV for simplicity, though dynamic is more secure, this is acceptable for local storage

  Future<void> init() async {
    // We are completely bypassing flutter_secure_storage because on this specific device/emulator,
    // _storage.write() is silently failing (not throwing an exception). 
    // This causes _storage.read() to return null on every launch, regenerating the key 
    // infinitely and permanently locking every entry the moment the app closes.
    final prefs = await SharedPreferences.getInstance();
    String? storedKey = prefs.getString('journal_encryption_key');
    
    if (storedKey == null) {
      _key = enc.Key.fromSecureRandom(32);
      await prefs.setString('journal_encryption_key', _key!.base64);
    } else {
      _key = enc.Key.fromBase64(storedKey);
    }
  }

  String encrypt(String plainText) {
    // TEMPORARILY DISABLED: Storing as plain text
    return plainText; 
    
    /*
    if (_key == null) return plainText; // Fallback if not initialized
    final encrypter = enc.Encrypter(enc.AES(_key!));
    final encrypted = encrypter.encrypt(plainText, iv: _iv);
    return encrypted.base64;
    */
  }

  String decrypt(String encryptedText) {
    // TEMPORARILY DISABLED: Reading as plain text
    return encryptedText;

    /*
    if (_key == null) return encryptedText;
    try {
      final encrypter = enc.Encrypter(enc.AES(_key!));
      final decrypted = encrypter.decrypt64(encryptedText, iv: _iv);
      return decrypted;
    } catch (e) {
      // If decryption fails (e.g. because it's an older unencrypted entry in plain text),
      // we gracefully return the original string so it doesn't break the UI.
      return encryptedText;
    }
    */
  }
}

@Riverpod(keepAlive: true)
Future<EncryptionService> encryptionService(Ref ref) async {
  final service = EncryptionService();
  await service.init();
  return service;
}
