class Failure implements Exception {
  final dynamic message;
  final int? code;
  final Exception? exception;
  final bool isReportable;

  Failure(
      {required this.message,
      this.code,
      this.exception,
      this.isReportable = false});

  @override
  String toString() =>
      'Failure(message: $message, code: $code, exception: $exception)';
}
