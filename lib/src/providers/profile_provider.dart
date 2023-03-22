import 'package:flutter/foundation.dart';
import 'constants.dart';
import '../locator.dart';
import '../services/api/api.dart';
import '../services/db/db.dart';

class ProfileProvider {
  Future<void> feedback({required String feedback}) async {
    String? token = await locator.get<TokenStorage>().getToken();
    Map<String, dynamic> response =
        await locator.get<ProfileService>().feedback(token!, feedback);
    if (response[code] != 200) {
      debugPrint(response.toString());
    }
  }

  Future<void> help(
      {required String name,
      required String email,
      required String message}) async {
    String? token = await locator.get<TokenStorage>().getToken();
    Map<String, dynamic> response =
        await locator.get<ProfileService>().help(token!, name, email, message);
    if (response[code] != 200) {
      debugPrint(response.toString());
    }
  }

  Future<void> logout() async {
    locator.get<TokenStorage>().clearToken();
    await locator.isReady<OwnerStorage>();
    locator.get<OwnerStorage>().deleteOwner();
    debugPrint('logged Out Successfully');
  }

  Future<void> suggestPlace(
      {required String placeName,
      required String address,
      required String contact}) async {
    String? token = await locator.get<TokenStorage>().getToken();
    Map<String, dynamic> response = await locator
        .get<ProfileService>()
        .suggestPlace(token!, placeName, address, contact);
    if (response[code] != 200) {
      debugPrint(response.toString());
    }
  }
}
