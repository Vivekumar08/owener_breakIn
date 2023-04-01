import 'package:flutter/foundation.dart';
import '../style/snack_bar.dart';
import 'constants.dart';
import '../locator.dart';
import '../models/models.dart';
import '../services/api/api.dart';
import '../services/db/db.dart';

// ignore: constant_identifier_names
enum InsightsState { Uninitialized, Initializing, Fetching, Fetched, Finale }

extension InsightsExtension on InsightsState {
  bool isInitializing() => this == InsightsState.Initializing ? true : false;
  bool isFetching() => this == InsightsState.Fetching ? true : false;
  bool isFinale() => this == InsightsState.Finale ? true : false;
}

class InsightsProvider extends ChangeNotifier {
  InsightsState _state = InsightsState.Uninitialized;

  InsightsState get state => _state;

  void _changeState(InsightsState state) {
    _state = state;
    notifyListeners();
  }

  List<Rate> list = [];

  Future<void> fetchInsights({required int page, required int limit}) async {
    page == 0
        ? _changeState(InsightsState.Initializing)
        : _changeState(InsightsState.Fetching);
    String? token = await locator.get<TokenStorage>().getToken();
    Map<String, dynamic> response =
        await locator.get<InsightsService>().fetchInsights(token!, page, limit);

    if (response[code] == 200) {
      // ignore: avoid_function_literals_in_foreach_calls
      (response[rates] as List).forEach((element) {
        list.add(Rate.fromJson(element));
      });
      _changeState(InsightsState.Fetched);
    } else {
      if (response[code] == 202) {
        // ignore: avoid_function_literals_in_foreach_calls
        (response[rates] as List).forEach((element) {
          list.add(Rate.fromJson(element));
        });
        _changeState(InsightsState.Finale);
        showSnackBar(response[msg]);
        return _changeState(InsightsState.Finale);
      }
      _changeState(InsightsState.Fetched);
    }
  }
}
