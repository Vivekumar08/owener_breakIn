import 'dart:async' show TimeoutException;
import 'dart:convert' show jsonEncode, jsonDecode;
import 'dart:io' show HttpHeaders, SocketException;
import '../constants.dart';
import 'package:http/http.dart' as http;

class PlaceService {
  Future<Map<String, dynamic>> ratePlace(
      String token,
      String overallRating,
      String hygiene,
      String taste,
      String quality,
      String ambience,
      String comment) async {
    Map<String, dynamic> body = {};
    try {
      http.Response response = await http.post(
        Uri.parse('$baseUrl/ratePlace'),
        body: jsonEncode({
          "OverallRating": overallRating,
          "Hygiene": hygiene,
          "Taste": taste,
          "Quality": taste,
          "Ambience": quality,
          "Comment": comment,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          HttpHeaders.authorizationHeader: token,
        },
      ).timeout(duration_5);

      body = jsonDecode(response.body);
      body.addAll({'code': response.statusCode});
    } on TimeoutException catch (_) {
      timeOut();
    } on SocketException catch (_) {
      noInternet();
    } catch (e) {
      throw Exception(e);
    }
    return body;
  }
}
