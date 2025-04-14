sealed class Result<T> {
  const Result();

  const factory Result.ok(T value) = Ok<T>._;

  const factory Result.error(Exception error) = Error<T>._;
}

final class Ok<T> extends Result<T> {
  const Ok._(this.value);

  /// Returned value in result
  final T value;

  @override
  String toString() => 'Result<$T>.ok($value)';
}

final class Error<T> extends Result<T> {
  const Error._(this.error);

  /// Returned error in result
  final Exception error;

  @override
  String toString() => 'Result<$T>.error($error)';
}
