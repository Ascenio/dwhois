import 'package:dwhois/src/whois.dart';
import 'package:test/test.dart';

void main() {
  test('queryWhoisServer calls whois successfully', () async {
    final actual = await whois('google.com');
    expect(actual, startsWith(googleResultBegin));
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
}

const googleResultBegin = '''
   Domain Name: GOOGLE.COM\r
   Registry Domain ID: 2138514_DOMAIN_COM-VRSN\r
   Registrar WHOIS Server: whois.markmonitor.com\r
   Registrar URL: http://www.markmonitor.com\r
   Updated Date: 2019-09-09T15:39:04Z\r
   Creation Date: 1997-09-15T04:00:00Z\r
   Registry Expiry Date: 2028-09-14T04:00:00Z\r
   Registrar: MarkMonitor Inc.\r
   Registrar IANA ID: 292\r
   Registrar Abuse Contact Email: abusecomplaints@markmonitor.com\r
   Registrar Abuse Contact Phone: +1.2083895740\r
   Domain Status: clientDeleteProhibited https://icann.org/epp#clientDeleteProhibited\r
   Domain Status: clientTransferProhibited https://icann.org/epp#clientTransferProhibited\r
   Domain Status: clientUpdateProhibited https://icann.org/epp#clientUpdateProhibited\r
   Domain Status: serverDeleteProhibited https://icann.org/epp#serverDeleteProhibited\r
   Domain Status: serverTransferProhibited https://icann.org/epp#serverTransferProhibited\r
   Domain Status: serverUpdateProhibited https://icann.org/epp#serverUpdateProhibited\r
   Name Server: NS1.GOOGLE.COM\r
   Name Server: NS2.GOOGLE.COM\r
   Name Server: NS3.GOOGLE.COM\r
   Name Server: NS4.GOOGLE.COM\r
   DNSSEC: unsigned\r
   URL of the ICANN Whois Inaccuracy Complaint Form: https://www.icann.org/wicf/\r
''';
