import 'package:dwhois/dwhois.dart';
import 'package:test/test.dart';

Matcher hasResult(WhoisResult expected) {
  return TypeMatcher<WhoisResult>()
      .having((actual) => actual.domain, 'domain', expected.domain)
      .having((actual) => actual.body, 'body', startsWith(expected.body));
}
