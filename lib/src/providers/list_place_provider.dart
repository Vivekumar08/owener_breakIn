import 'dart:io' show File;
import 'constants.dart';
import '../locator.dart';
import '../services/api/api.dart';
import '../services/db/db.dart';
import '../style/snack_bar.dart';

// AuthProvider Constants
// ignore: constant_identifier_names
enum ListState { Idle, Uploading, Uploaded }

extension ListExtension on ListState {
  bool isUploaded() => this == ListState.Uploaded ? true : false;
}

class ListPlaceProvider {
  ListState _state = ListState.Idle;

  ListState get state => _state;

  void _changeViewState(ListState state) => _state = state;

  Future<void> listPlace(
      {required String placeName,
      required String address,
      required String ownerName,
      required File file}) async {
    _changeViewState(ListState.Uploading);
    String? token = await locator.get<TokenStorage>().getToken();
    Map<String, dynamic> response =
        await locator.get<ListPlaceService>().listPlace({
      "PlaceName": placeName,
      "Address": address,
      "OwnerName": ownerName,
    }, token!, file);

    print(response);

    if (response[code] == 200) {
      showSnackBar(response[msg].toString());
      _changeViewState(ListState.Uploaded);
    } else {
      if (response[msg] != null) {
        showSnackBar(response[err].toString());
      }
      _changeViewState(ListState.Idle);
    }
  }
}
