import 'package:freezed_annotation/freezed_annotation.dart';

part 'result.freezed.dart';

@freezed
class Result<T, E> with _$Result<T, E> {
  const factory Result.success(T data) = Success<T, E>;
  const factory Result.failure(E error) = Failure<T, E>;
}

// Utility extension for easier mapping
extension ResultXP<T, E> on Result<T, E> {
  bool get isSuccess => this is Success<T, E>;
  bool get isFailure => this is Failure<T, E>;

  T? get dataOrNull => when(
        success: (data) => data,
        failure: (_) => null,
      );

  E? get errorOrNull => when(
        success: (_) => null,
        failure: (error) => error,
      );
}
