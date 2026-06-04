import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:local_auth/local_auth.dart';
import '../../domain/models/journal_entry.dart';
import '../../domain/models/journal_stats.dart';
import '../../data/repositories/journal_repository.dart';
import '../../data/services/journal_auth_service.dart';

part 'journal_providers.g.dart';

@riverpod
class JournalEntries extends _$JournalEntries {
  @override
  FutureOr<List<JournalEntry>> build() async {
    final repo = await ref.watch(journalRepositoryProvider.future);
    return repo.getEntries();
  }

  Future<void> addEntry(JournalEntry entry) async {
    final repo = await ref.read(journalRepositoryProvider.future);
    final current = state.asData?.value ?? [];
    final updated = [...current, entry];
    state = AsyncData(updated);
    await repo.saveEntries(updated);
  }

  Future<void> updateEntry(JournalEntry entry) async {
    final repo = await ref.read(journalRepositoryProvider.future);
    final current = state.asData?.value ?? [];
    final updated = current.map((e) => e.id == entry.id ? entry : e).toList();
    state = AsyncData(updated);
    await repo.saveEntries(updated);
  }

  Future<void> deleteEntry(String id) async {
    final repo = await ref.read(journalRepositoryProvider.future);
    final current = state.asData?.value ?? [];
    final updated = current.where((e) => e.id != id).toList();
    state = AsyncData(updated);
    await repo.saveEntries(updated);
  }
}

@riverpod
class JournalDraft extends _$JournalDraft {
  @override
  FutureOr<JournalEntry?> build() async {
    final repo = await ref.watch(journalRepositoryProvider.future);
    return repo.getDraft();
  }

  Future<void> saveDraft(JournalEntry? draft) async {
    state = AsyncData(draft);
    final repo = await ref.read(journalRepositoryProvider.future);
    await repo.saveDraft(draft);
  }
}

@riverpod
JournalStats journalStats(Ref ref) {
  final entries = ref.watch(journalEntriesProvider).asData?.value ?? [];
  return JournalStatsCalculator.calculate(entries);
}

@riverpod
FutureOr<bool> hasPinSet(Ref ref) {
  final authService = ref.watch(journalAuthServiceProvider);
  return authService.hasPinSet();
}

@riverpod
class LocalAuth extends _$LocalAuth {
  final LocalAuthentication auth = LocalAuthentication();

  @override
  FutureOr<bool> build() async {
    return false; // Default to locked, require authentication
  }

  Future<bool> authenticate() async {
    try {
      final canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
      final canAuthenticate = canAuthenticateWithBiometrics || await auth.isDeviceSupported();

      if (!canAuthenticate) {
        // Device doesn't support biometrics, rely on PIN
        return false;
      }

      final didAuthenticate = await auth.authenticate(
        localizedReason: 'Please authenticate to access your Journal',
      );
      if (didAuthenticate) {
        state = const AsyncData(true);
      }
      return didAuthenticate;
    } catch (e) {
      return false;
    }
  }

  void unlockWithPin() {
    state = const AsyncData(true);
  }
}
