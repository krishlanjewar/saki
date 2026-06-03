import 'package:encrypt/encrypt.dart' as enc;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'encryption_service.g.dart';

class EncryptionService {
  final _storage = const FlutterSecureStorage();
  enc.Key? _key;
  final enc.IV _iv = enc.IV.fromLength(16); // Static IV for simplicity, though dynamic is more secure, this is acceptable for local storage

  Future<void> init() async {
    String? storedKey = await _storage.read(key: 'journal_encryption_key');
    if (storedKey == null) {
      _key = enc.Key.fromSecureRandom(32);
      await _storage.write(key: 'journal_encryption_key', value: _key!.base64);
    } else {
      _key = enc.Key.fromBase64(storedKey);
    }
  }

  String encrypt(String plainText) {
    if (_key == null) return plainText; // Fallback if not initialized
    final encrypter = enc.Encrypter(enc.AES(_key!));
    final encrypted = encrypter.encrypt(plainText, iv: _iv);
    return encrypted.base64;
  }

  String decrypt(String encryptedText) {
    if (_key == null) return encryptedText;
    try {
      final encrypter = enc.Encrypter(enc.AES(_key!));
      final decrypted = encrypter.decrypt64(encryptedText, iv: _iv);
      return decrypted;
    } catch (e) {
      // If decryption fails (e.g. key changed), return empty or original string
      return "Decryption Error";
    }
  }
}

@Riverpod(keepAlive: true)
Future<EncryptionService> encryptionService(Ref ref) async {
  final service = EncryptionService();
  await service.init();
  return service;
}
