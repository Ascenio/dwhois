import 'package:dwhois/dwhois.dart';
import 'package:test/test.dart';

Matcher hasResult(WhoisResult result) => _HasResult(startsWith(result.body));

class _HasResult extends CustomMatcher {
  _HasResult(Object? valueOrMatcher)
      : super('Result with body like', 'body', valueOrMatcher);

  @override
  Object? featureValueOf(dynamic actual) => (actual as WhoisResult).body;
}
