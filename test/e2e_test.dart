import 'package:dwhois/dwhois.dart';
import 'package:test/test.dart';

import 'matchers/has_result.dart';

void main() {
  test('queryWhoisServer calls whois successfully', () async {
    final actual = await whois('google.com');
    expect(actual, startsWith(googleResult.body));
  });

  group('findWhoisServer', () {
    test(' finds corresponding whois server', () async {
      expect(
        await findWhoisServer(domain: 'google.com.br'),
        'whois.registro.br',
      );
      expect(
        await findWhoisServer(domain: 'pub.dev'),
        'whois.nic.google',
      );
      expect(
        await findWhoisServer(domain: 'php.net'),
        'whois.verisign-grs.com',
      );
      expect(
        await findWhoisServer(domain: 'php.net'),
        'whois.verisign-grs.com',
      );
    });

    test('returns [null] for unknown domains', () async {
      expect(await findWhoisServer(domain: 'foo.bar.baz'), isNull);
    });
  });

  group('whoisMany', () {
    test('emits nothing for empty input', () {
      expect(whoisMany([]), emitsDone);
    });

    test('emits responses for valid domains', () {
      expect(
        whoisMany(['google.com', 'pub.dev']),
        emitsInOrder([
          emitsInAnyOrder([
            hasResult(googleResult),
            hasResult(pubDevResult),
          ]),
          emitsDone,
        ]),
      );
    });

    test('ignores invalid domains', () {
      expect(
        whoisMany(['google.com', 'foo.bar.baz']),
        emitsInOrder([
          emitsInAnyOrder([
            hasResult(googleResult),
            emitsError(isA<FailedToQueryWhoisException>()),
          ]),
          emitsDone,
        ]),
      );
    });
  });
}

const googleResult = WhoisResult(
  domain: 'google.com',
  body: '''
   Domain Name: GOOGLE.COM\r
   Registry Domain ID: 2138514_DOMAIN_COM-VRSN\r
   Registrar WHOIS Server: whois.markmonitor.com\r
   Registrar URL: http://www.markmonitor.com\r
''',
);

const pubDevResult = WhoisResult(
  domain: 'pub.dev',
  body: '''
Domain Name: pub.dev\r
Registry Domain ID: 33E50E250-DEV\r
Registrar WHOIS Server: whois.nic.google\r
Registrar URL: http://www.markmonitor.com\r
''',
);
