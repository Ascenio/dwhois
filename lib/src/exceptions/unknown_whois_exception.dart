import 'exceptions.dart';

class UnknownWhoisException implements WhoisException {
  const UnknownWhoisException({
    required this.exception,
    required this.stackTrace,
  }) : super();

  final Exception exception;
  final StackTrace stackTrace;

  @override
  String toString() => 'Unknown exception: $exception';
}
