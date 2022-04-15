import 'dart:async';

import 'exceptions/exceptions.dart';
import 'whois.dart';

Stream<WhoisResult> whoisMany(Iterable<String> domains) {
  final controller = StreamController<WhoisResult>();
  final futures = domains
      .map((domain) => _whoisWithSink(domain: domain, sink: controller.sink));
  Future.wait(futures).whenComplete(controller.close);
  return controller.stream;
}

Future<void> _whoisWithSink({
  required String domain,
  required StreamSink<WhoisResult> sink,
}) async {
  try {
    final response = await whois(domain);
    if (response == null) {
      sink.addError(FailedToQueryWhoisException(domain: domain));
    } else {
      sink.add(WhoisResult(domain: domain, body: response));
    }
  } on Exception catch (exception, stackTrace) {
    sink.addError(
      UnknownWhoisException(exception: exception, stackTrace: stackTrace),
    );
  }
}

class WhoisResult {
  const WhoisResult({
    required this.domain,
    required this.body,
  });

  final String domain;
  final String body;

  @override
  String toString() => body;
}
