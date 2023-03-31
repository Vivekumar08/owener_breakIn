import 'dart:async' show TimeoutException;
import 'dart:convert' show jsonDecode, jsonEncode;
import 'dart:io' show File, HttpHeaders, SocketException;
import 'dart:typed_data' show Uint8List;
import 'package:http/http.dart' as http;
import '../../models/menu.dart';
import '../constants.dart';

class FoodPlaceService {
  Future<Map<String, dynamic>> addFoodPlace(
      Map<String, String> fields, String token, File image) async {
    Map<String, dynamic> body = {};

    try {
      http.MultipartRequest request =
          http.MultipartRequest('POST', Uri.parse('$resUrl/add/foodPlace'));
      request.headers[HttpHeaders.authorizationHeader] = token;
      request.headers[HttpHeaders.contentTypeHeader] = 'multipart/form-data';

      final file = http.MultipartFile.fromBytes(
          'file', await image.readAsBytes(),
          filename: image.path.split('/').last);
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

  Future<Map<String, dynamic>> getFoodPlace(String token) async {
    Map<String, dynamic> body = {};
    try {
      http.Response response = await http.get(
        Uri.parse('$resUrl/get/foodPlace'),
        headers: <String, String>{
          HttpHeaders.authorizationHeader: token,
          'Content-Type': 'application/json; charset=UTF-8',
        },
      ).timeout(duration_10);

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

  Future<Map<String, dynamic>> addMenuCategory(
      String token, String category) async {
    Map<String, dynamic> body = {};
    try {
      http.Response response = await http.post(
        Uri.parse('$resUrl/add/MenuItems/Category'),
        body: jsonEncode({"Category": category}),
        headers: <String, String>{
          HttpHeaders.authorizationHeader: token,
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

  Future<Map<String, dynamic>> addMenuItem(
      String token, String category, MenuItem item) async {
    Map<String, dynamic> body = {};
    Map<String, dynamic> fields = item.toJson();
    fields.addAll({'Category': category});
    try {
      http.Response response = await http.post(
        Uri.parse('$resUrl/add/MenuItems'),
        body: jsonEncode(fields),
        headers: <String, String>{
          HttpHeaders.authorizationHeader: token,
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

  Future<Map<String, dynamic>> changeCoverImage(
      String token, File image) async {
    Map<String, dynamic> body = {};
    try {
      http.MultipartRequest request =
          http.MultipartRequest('POST', Uri.parse('$resUrl/edit/coverPhoto'));
      request.headers[HttpHeaders.authorizationHeader] = token;
      request.headers[HttpHeaders.contentTypeHeader] = 'multipart/form-data';

      final file = http.MultipartFile.fromBytes(
          'file', await image.readAsBytes(),
          filename: image.path.split('/').last);
      request.files.add(file);

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

  Future<Map<String, dynamic>> updateItemStatus(
      String token, bool status, MenuItem item) async {
    Map<String, dynamic> body = {};
    try {
      http.Response response = await http.patch(
        Uri.parse('$resUrl/update/status/menuItems?menuid=${item.id}'),
        body: jsonEncode({"status": status}),
        headers: <String, String>{
          HttpHeaders.authorizationHeader: token,
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

  Future<Map<String, dynamic>> editMenuItem(
      String token, String id, String category, MenuItem item) async {
    Map<String, dynamic> body = {};
    Map<String, dynamic> fields = item.toJson();
    fields.addAll({'Category': category});
    try {
      http.Response response = await http.put(
        Uri.parse('$resUrl/edit/menuitems?id=$id'),
        body: jsonEncode(fields),
        headers: <String, String>{
          HttpHeaders.authorizationHeader: token,
          'Content-Type': 'application/json; charset=UTF-8',
        },
      ).timeout(duration_10);

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

  Future<Map<String, dynamic>> deleteMenuItem(String token, String id) async {
    Map<String, dynamic> body = {};
    try {
      http.Response response = await http.delete(
        Uri.parse('$resUrl/delete/menuItems?id=$id'),
        headers: <String, String>{
          HttpHeaders.authorizationHeader: token,
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
