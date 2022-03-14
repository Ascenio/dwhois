import 'package:dwhois/dwhois.dart';

Future<void> main() async {
  print(await whois('google.com') ?? 'not found');
  whoisMany(['google.com', 'pub.dev']).listen(print);
}
