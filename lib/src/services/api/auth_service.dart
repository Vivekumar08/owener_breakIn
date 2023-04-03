import 'dart:async' show TimeoutException;
import 'dart:convert' show jsonEncode, jsonDecode;
import 'dart:io' show SocketException;
import '../constants.dart';
import 'package:http/http.dart' as http;

class AuthService {
  Future<Map<String, dynamic>> loginWithMail(
      String email, String password) async {
    Map<String, dynamic> body = {};
    try {
      http.Response response = await http.post(
        Uri.parse('$baseUrl/loginWithEmail'),
        body: jsonEncode({"Email": email, "Password": password}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
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

  Future<Map<String, dynamic>> registerWithMail(
      String name, String email, String password) async {
    Map<String, dynamic> body = {};
    try {
      http.Response response = await http.post(
        Uri.parse('$baseUrl/registerWithEmail'),
        body: jsonEncode(
            {"FullName": name, "Email": email, "Password": password}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
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
