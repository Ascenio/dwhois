import 'dart:io';

Future<void> main() async {
  final domain = 'google.com.br';
  final addresses = await InternetAddress.lookup('whois.registro.br');
  print(addresses);
  final address = addresses.first;
  final socket = await Socket.connect(address, 43);
  socket.add('$domain\r\n'.codeUnits);
  final body = await socket.map((bytes) => String.fromCharCodes(bytes)).first;
  print(body);
}
