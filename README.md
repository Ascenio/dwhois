# :detective: dwhois

A simple [whois](https://en.wikipedia.org/wiki/WHOIS) client in Dart :bird:

## Usage

### Query whois

It picks automatically a whois server based on [IANA WHOIS Service](https://www.iana.org/whois)
and queries agaisnt it.
```dart
Future<void> main() async {
  final response = await whois('google.com');
  print(response);
}
```

### Query whois against a specific server

```dart
Future<void> main() async {
  final response = await queryWhoisServer(
    domain: 'google.com',
    whoisServer: 'whois.verisign-grs.com',
  );
  print(response);
}
```

### Find a whois server by domain

```dart
Future<void> main() async {
  final server = await findWhoisServer(domain: 'google.com');
  print(server); // whois.verisign-grs.com
}
```

### Example

The code:
```dart
import 'package:dwhois/dwhois.dart';

Future<void> main() async {
  final response = await whois('google.com');
  print(response);
}
```

The output:
```
Domain Name: GOOGLE.COM
Registry Domain ID: 2138514_DOMAIN_COM-VRSN
Registrar WHOIS Server: whois.markmonitor.com
Registrar URL: http://www.markmonitor.com
Updated Date: 2019-09-09T15:39:04Z
Creation Date: 1997-09-15T04:00:00Z
Registry Expiry Date: 2028-09-14T04:00:00Z
Registrar: MarkMonitor Inc.
Registrar IANA ID: 292
Registrar Abuse Contact Email: abusecomplaints@markmonitor.com
Registrar Abuse Contact Phone: +1.2083895740
...
```
