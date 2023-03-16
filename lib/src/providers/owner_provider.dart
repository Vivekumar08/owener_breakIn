import 'package:flutter/foundation.dart';
import '../locator.dart';
import '../models/models.dart';
import '../services/api/api.dart';
import '../services/db/db.dart';
import 'constants.dart';

// ignore: constant_identifier_names
enum OwnerState { Uninitialized, Initializing, Initialized }

extension OwnerExtension on OwnerState {
  bool initialized() => this == OwnerState.Initialized ? true : false;
}

class OwnerProvider extends ChangeNotifier {
  Owner? _owner;
  Owner? get user => _owner;

  OwnerState _state = OwnerState.Uninitialized;
  OwnerState get state => _state;

  String? get name => _owner?.FullName;

  void _changeownerState(OwnerState ownerState) {
    _state = ownerState;
    notifyListeners();
  }

  OwnerProvider.init() {
    if (user == null) {
      getOwnerDataLocally();
    }
  }

  OwnerProvider.fromProvider(bool token, bool auth) {
    if (token && auth) {
      if (user == null) {
        getOwnerDataLocally();
      }
    } else {
      _changeownerState(OwnerState.Uninitialized);
    }
  }

  Future<void> getOwnerDataLocally() async {
    locator.isReady<UserStorage>().whenComplete(() {
      dynamic userStored = locator.get<UserStorage>().getUser();
      if (userStored is Owner) {
        _owner = userStored;
        _changeownerState(OwnerState.Initialized);
      } else {
        getOwnerDataFromServer();
      }
    });
  }

  Future<void> getOwnerDataFromServer() async {
    if (state == OwnerState.Initializing) {
      return;
    }
    _changeownerState(OwnerState.Initializing);
    String? token = await locator.get<TokenStorage>().getToken();
    Map<String, dynamic> response =
        await locator.get<OwnerService>().getOwnerDetails(token!);

    if (response[code] == 200) {
      Owner user = Owner.fromJson(response);
      _owner = user;
      locator.get<UserStorage>().addUser(user);
      _changeownerState(OwnerState.Initialized);
    } else {
      _changeownerState(OwnerState.Uninitialized);
    }
  }
}
