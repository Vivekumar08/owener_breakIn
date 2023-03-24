import 'package:flutter/foundation.dart';
import 'constants.dart';
import '../locator.dart';
import '../models/models.dart';
import '../services/api/api.dart';
import '../services/db/db.dart';
import '../style/snack_bar.dart';

// AuthProvider Constants
// ignore: constant_identifier_names
enum ListPlaceState { Idle, Uploading, Uploaded }

extension ListPlaceExtension on ListPlaceState {
  bool isUploaded() => this == ListPlaceState.Uploaded ? true : false;
}

class ListPlaceProvider {
  ListPlaceState _state = ListPlaceState.Idle;
  ListPlaceState get state => _state;

  ListPlaceModel? _listPlaceModel;
  ListPlaceModel? get listPlaceModel => _listPlaceModel;

  void _changeViewState(ListPlaceState state) => _state = state;

  ListPlaceProvider();

  ListPlaceProvider.init(bool token) {
    if (token && listPlaceModel == null) {
      getListPlace();
    }
  }

  Future<void> listPlace(ListPlaceModel listPlace) async {
    _changeViewState(ListPlaceState.Uploading);
    String? token = await locator.get<TokenStorage>().getToken();
    Map<String, dynamic> response =
        await locator.get<ListPlaceService>().listPlace({
      "PlaceName": listPlace.placeName,
      "Address": listPlace.address,
      "OwnerName": listPlace.ownerName,
    }, token!, listPlace.document);

    if (response[code] == 200) {
      _changeViewState(ListPlaceState.Uploaded);
    } else {
      if (response[msg] != null) {
        showSnackBar(response[err].toString());
      }
      _changeViewState(ListPlaceState.Idle);
    }
  }

  Future<void> getListPlace() async {
    await locator.isReady<ListPlaceStorage>().whenComplete(() async {
      _listPlaceModel = locator.get<ListPlaceStorage>().getListPlace();
      if (_listPlaceModel == null) {
        await getListPlaceFromServer();
      }
    });
  }

  Future<void> getListPlaceFromServer() async {
    String? token = await locator.get<TokenStorage>().getToken();
    Map<String, dynamic> response =
        await locator.get<ListPlaceService>().getListPlace(token!);

    if (response[code] == 200) {
      _listPlaceModel = ListPlaceModel.fromJson(response);
      // If status is verified or, make it local
      if (_listPlaceModel?.status == ListPlaceStatus.verified) {
        (await locator.getAsync<ListPlaceStorage>())
            .addListPlace(_listPlaceModel!);
      }
    } else {
      debugPrint(response.toString());
    }
  }
}