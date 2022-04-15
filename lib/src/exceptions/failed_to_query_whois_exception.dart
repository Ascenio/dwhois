import 'exceptions.dart';

class FailedToQueryWhoisException implements WhoisException {
  const FailedToQueryWhoisException({required this.domain});

  final String domain;

  @override
  String toString() => 'Failed to query $domain';
}
