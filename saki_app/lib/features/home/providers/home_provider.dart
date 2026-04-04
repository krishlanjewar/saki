import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_provider.g.dart';

@riverpod
class Home extends _$Home {
  @override
  FutureOr<String> build() async {
    // Initial data fetch or computation goes here
    await Future.delayed(const Duration(seconds: 1));
    return 'Ready to organize your day.';
  }

  // Add mutator methods here
}
