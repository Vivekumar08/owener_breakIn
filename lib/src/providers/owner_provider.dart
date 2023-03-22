import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart' show XFile;
import '../locator.dart';
import '../models/models.dart';
import '../services/api/api.dart';
import '../services/db/db.dart';
import '../style/snack_bar.dart';
import 'constants.dart';

// ignore: constant_identifier_names
enum OwnerState { Uninitialized, Initializing, Initialized, Updating, Updated }

extension OwnerExtension on OwnerState {
  bool initialized() => this == OwnerState.Initialized ? true : false;
  bool updating() => this == OwnerState.Updating ? true : false;
}

class OwnerProvider extends ChangeNotifier {
  Owner? _owner;
  Owner? get owner => _owner;

  OwnerState _state = OwnerState.Uninitialized;
  OwnerState get state => _state;

  String? get name => _owner?.FullName;

  void _changeOwnerState(OwnerState ownerState) {
    _state = ownerState;
    notifyListeners();
  }

  OwnerProvider.init() {
    if (owner == null) {
      getOwnerData();
    }
  }

  OwnerProvider.fromProvider(bool token, bool auth) {
    if (token || auth) {
      if (owner == null) {
        getOwnerData();
      }
    } else {
      _changeOwnerState(OwnerState.Uninitialized);
    }
  }

  Future<String> getName() async {
    if (owner == null) {
      return getOwnerData().then((_) => owner!.FullName);
    } else {
      return owner!.FullName;
    }
  }

  Future<void> getOwnerData() async {
    locator.isReady<OwnerStorage>().whenComplete(() {
      dynamic ownerStored = locator.get<OwnerStorage>().getOwner();
      if (ownerStored is Owner) {
        _owner = ownerStored;
        _changeOwnerState(OwnerState.Initialized);
      } else {
        getOwnerDataFromServer();
      }
    });
  }

  Future<void> getOwnerDataFromServer() async {
    if (state == OwnerState.Initializing) {
      return;
    }
    _changeOwnerState(OwnerState.Initializing);
    String? token = await locator.get<TokenStorage>().getToken();
    Map<String, dynamic> response =
        await locator.get<OwnerService>().getOwnerDetails(token!);

    if (response[code] == 200) {
      Owner owner = Owner.fromJson(response);
      _owner = owner;
      locator.get<OwnerStorage>().addOwner(owner);
      _changeOwnerState(OwnerState.Initialized);
    } else {
      _changeOwnerState(OwnerState.Uninitialized);
    }
  }

  Future<void> uploadProfilePic(XFile file) async {
    showSnackBar('Uploading...');
    _changeOwnerState(OwnerState.Updating);
    String? token = await locator.get<TokenStorage>().getToken();
    Map<String, dynamic> response =
        await locator.get<OwnerService>().uploadProfilePic(token!, file);

    if (response[code] == 200) {
      showSnackBar(response[msg].toString());
      if (response[fileName] != null) {
        (await locator.getAsync<OwnerStorage>())
            .updateProfilePic(response[fileName]);
        getOwnerData();
        _changeOwnerState(OwnerState.Updated);
        return;
      }
    } else {
      if (response[error] != null) {
        showSnackBar(response[error].toString());
      }
    }
    _changeOwnerState(OwnerState.Initialized);
  }
}
