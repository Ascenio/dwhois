import 'dart:async';
import 'dart:io';

Future<String> queryWhoisServer({
  required String whoisServer,
  required String domain,
}) async {
  final socket = await Socket.connect(whoisServer, 43);
  socket.add('$domain\r\n'.codeUnits);
  final response = await socket.map(String.fromCharCodes).first;
  await socket.close();
  return response;
}

Future<String?> findWhoisServer({
  required String domain,
}) async {
  final response =
      await queryWhoisServer(whoisServer: 'whois.iana.org', domain: domain);
  final whoisLines = response
      .split('\n')
      .map((line) => line.trim().toLowerCase())
      .where((line) => line.startsWith('whois'));
  if (whoisLines.length != 1) {
    return null;
  }
  final whoisLine = whoisLines.first;
  final lineParts = whoisLine.split(RegExp(r'\s+'));
  if (lineParts.length != 2) {
    return null;
  }
  return lineParts.last;
}

Future<String?> whois(String domain) async {
  final whoisServer = await findWhoisServer(domain: domain);
  if (whoisServer == null) {
    return null;
  }
  final response = await queryWhoisServer(
    whoisServer: whoisServer,
    domain: domain,
  );
  return response;
}
