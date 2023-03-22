import 'dart:async' show TimeoutException;
import 'dart:convert' show jsonDecode;
import 'dart:io' show HttpHeaders, SocketException;
import 'dart:typed_data' show Uint8List;
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart' show XFile;
import '../constants.dart';

class OwnerService {
  Future<Map<String, dynamic>> getOwnerDetails(String token) async {
    Map<String, dynamic> body = {};
    try {
      http.Response response = await http.get(
        Uri.parse('$baseUrl/getdata'),
        headers: <String, String>{
          HttpHeaders.authorizationHeader: token,
          'Content-Type': 'application/json; charset=UTF-8',
        },
      ).timeout(authTimeout);

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
