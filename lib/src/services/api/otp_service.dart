import 'dart:async' show TimeoutException;
import 'dart:convert' show jsonEncode, jsonDecode;
import 'dart:io' show SocketException;
import '../constants.dart';
import 'package:http/http.dart' as http;

class OtpServiceViaEmail {
  Future<Map<String, dynamic>> forgotPassword(String email) async {
    Map<String, dynamic> body = {};
    try {
      http.Response response = await http.post(
        Uri.parse('$baseUrl/forgotEmail'),
        body: jsonEncode({"Email": email}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      ).timeout(otpTimeout);

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

  Future<Map<String, dynamic>> verifyOTP(String email, String otp) async {
    Map<String, dynamic> body = {};
    try {
      http.Response response = await http.put(
        Uri.parse('$baseUrl/verifyOTPviaEmail'),
        body: jsonEncode({"Email": email, "otp": otp}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      ).timeout(otpTimeout);

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

  Future<Map<String, dynamic>> resendOTP(String email) async {
    Map<String, dynamic> body = {};
    try {
      http.Response response = await http.put(
        Uri.parse('$baseUrl/resendOTPviaEmail'),
        body: jsonEncode({"Email": email}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      ).timeout(otpTimeout);

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

  Future<Map<String, dynamic>> updatePassword(
      String email, String password) async {
    Map<String, dynamic> body = {};
    try {
      http.Response response = await http.put(
        Uri.parse('$baseUrl/updatePasswordViaEmail'),
        body: jsonEncode({"Email": email, "Password": password}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      ).timeout(otpTimeout);

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
