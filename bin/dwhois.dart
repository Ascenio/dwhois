import 'package:dwhois/dwhois.dart';

Future<void> main() async {
  print(await whois('google.com.br') ?? 'not found');
}
