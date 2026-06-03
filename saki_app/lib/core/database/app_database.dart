import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_database.g.dart';

/// Local file-based Key-Value database store residing in core/database.
/// Uses path_provider to persist data to a JSON document file.
class AppDatabase {
  AppDatabase._();
  
  static final AppDatabase instance = AppDatabase._();

  File? _dbFile;
  Map<String, String> _data = {};

  Future<void> init() async {
    if (kIsWeb) {
      _data = {};
      return;
    }
    try {
      final dir = await getApplicationDocumentsDirectory();
      _dbFile = File('${dir.path}/saki_kv_database.json');
      if (await _dbFile!.exists()) {
        final content = await _dbFile!.readAsString();
        if (content.isNotEmpty) {
          final decoded = jsonDecode(content);
          if (decoded is Map) {
            _data = decoded.map((k, v) => MapEntry(k.toString(), v.toString()));
          }
        }
      }
    } catch (e) {
      // Suppress or handle error
      _data = {};
    }
  }

  Future<String?> getString(String key) async {
    return _data[key];
  }

  Future<void> putString(String key, String value) async {
    _data[key] = value;
    if (kIsWeb) return;
    if (_dbFile != null) {
      await _dbFile!.writeAsString(jsonEncode(_data));
    }
  }

  Future<void> delete(String key) async {
    _data.remove(key);
    await _saveToFile();
  }

  Future<void> _saveToFile() async {
    if (kIsWeb) return;
    if (_dbFile == null) return;
    try {
      final jsonString = jsonEncode(_data);
      await _dbFile!.writeAsString(jsonString);
    } catch (e) {
      // Suppress or handle error
    }
  }
}

@Riverpod(keepAlive: true)
AppDatabase database(Ref ref) {
  return AppDatabase.instance;
}
