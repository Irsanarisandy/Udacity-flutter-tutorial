import "dart:async";
import "dart:convert";
import "dart:io";
import "unit.dart";

class Api {
  final _httpClient = HttpClient();
  final _url = "exchangeratesapi.io";

  Future<Map<String, dynamic>> _getJson(Uri uri) async {
    try {
      final httpRequest = await _httpClient.getUrl(uri);
      final httpResponse = await httpRequest.close();
      if (httpResponse.statusCode != HttpStatus.OK) {
        return null;
      }
      final responseBody = await httpResponse.transform(utf8.decoder).join();
      return json.decode(responseBody);
    } on Exception catch(err) {
      print("$err");
      return null;
    }
  }

  Future<List<Unit>> getUnits() async {
    final uri = Uri.https(_url, "/api/latest");
    final jsonResponse = await _getJson(uri);
    if (jsonResponse == null || jsonResponse["rates"] == null) {
      print("Error retrieving currencies!");
      return null;
    }
    final currencyUnits = <Unit>[];
    for (var key in jsonResponse["rates"].keys) {
      currencyUnits.add(Unit(
        name: key,
        conversion: jsonResponse["rates"][key]
      ));
    }
    return currencyUnits;
  }
}