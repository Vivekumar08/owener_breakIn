import 'dart:async' show TimeoutException;
import 'dart:convert' show jsonDecode;
import 'dart:io' show File, HttpHeaders, SocketException;
import 'dart:typed_data' show Uint8List;
import 'package:http/http.dart' as http;
import '../constants.dart';

class ListPlaceService {
  Future<Map<String, dynamic>> listPlace(
      Map<String, String> fields, String token, File document) async {
    Map<String, dynamic> body = {};

    try {
      http.MultipartRequest request =
          http.MultipartRequest('POST', Uri.parse('$resUrl/listPlace'));
      request.headers[HttpHeaders.authorizationHeader] = token;
      request.headers[HttpHeaders.contentTypeHeader] = 'multipart/form-data';

      final file = http.MultipartFile.fromBytes(
          'file', await document.readAsBytes(),
          filename: document.path.split('/').last);
      request.files.add(file);

      request.fields.addAll(fields);

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
