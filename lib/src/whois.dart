import 'dart:io';

Future<String?> whois(String domain) async {
  final addresses = await InternetAddress.lookup(domain);
  if (addresses.isEmpty) {
    return null;
  }
  final socket = await Socket.connect('whois.iana.org', 43);
  socket.add('$domain\r\n'.codeUnits);
  final response =
      await socket.map((bytes) => String.fromCharCodes(bytes)).first;
  await socket.close();
  return response;
}
