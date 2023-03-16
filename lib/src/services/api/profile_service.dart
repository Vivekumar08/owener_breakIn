import 'dart:async' show TimeoutException;
import 'dart:convert' show jsonEncode, jsonDecode;
import 'dart:io' show HttpHeaders, SocketException;
import 'dart:typed_data' show Uint8List;
import 'package:image_picker/image_picker.dart' show XFile;
import 'package:mime/mime.dart';
import '../constants.dart';
import 'package:http/http.dart' as http;

class ProfileService {
  Future<Map<String, dynamic>> feedback(String token, String message) async {
    Map<String, dynamic> body = {};
    try {
      http.Response response = await http.post(
        Uri.parse('$baseUrl/feedbackUser'),
        body: jsonEncode({"Message": message}),
        headers: <String, String>{
          HttpHeaders.authorizationHeader: token,
          'Content-Type': 'application/json; charset=UTF-8',
        },
      ).timeout(settingsTimeout);

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

  Future<Map<String, dynamic>> help(
      String token, String name, String email, String message) async {
    Map<String, dynamic> body = {};
    try {
      http.Response response = await http.post(
        Uri.parse('$baseUrl/HelpUser'),
        body: jsonEncode({"Name": name, "Email": email, "Message": message}),
        headers: <String, String>{
          HttpHeaders.authorizationHeader: token,
          'Content-Type': 'application/json; charset=UTF-8',
        },
      ).timeout(settingsTimeout);

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

  Future<Map<String, dynamic>> suggestPlace(
      String token, String placeName, String address, String contact) async {
    Map<String, dynamic> body = {};
    try {
      http.Response response = await http.post(
        Uri.parse('$baseUrl/suggestPlace'),
        body: jsonEncode(
            {"PlaceName": placeName, "Address": address, "Contact": contact}),
        headers: <String, String>{
          HttpHeaders.authorizationHeader: token,
          'Content-Type': 'application/json; charset=UTF-8',
        },
      ).timeout(settingsTimeout);

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

  Future<Map<String, dynamic>> uploadProfilePic(
      String token, XFile file) async {
    Map<String, dynamic> body = {};
    try {
      http.MultipartRequest request =
          http.MultipartRequest('POST', Uri.parse('$baseUrl/profilePic'));
      request.fields['filename'] = file.name;
      request.fields['mimetype'] = lookupMimeType(file.path) ?? 'image/';
      request.headers[HttpHeaders.authorizationHeader] = token;
      request.headers[HttpHeaders.contentTypeHeader] = 'multipart/form-data';

      final picture = http.MultipartFile.fromBytes(
          'file', await file.readAsBytes(),
          filename: file.name);
      request.files.add(picture);

      http.StreamedResponse response = await request.send();

      Uint8List responseData = await response.stream.toBytes();
      body = jsonDecode(String.fromCharCodes(responseData));
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
