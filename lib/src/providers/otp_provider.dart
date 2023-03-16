// ignore_for_file: constant_identifier_names
import 'dart:async' show Timer;
import 'package:flutter/foundation.dart';
import 'constants.dart';
import '../locator.dart';
import '../services/api/api.dart';
import '../style/snack_bar.dart';

// OtpProvider Constants
enum OtpState {
  Null,
  Sending,
  Sent,
  Failed,
  Unverified,
  Verifying,
  Verified,
  Resent,
  Expired
}

extension OtpExtension on OtpState {
  bool sent() => this == OtpState.Sent ? true : false;
  bool verified() => this == OtpState.Verified ? true : false;
  bool expired() => this == OtpState.Expired ? true : false;
}

class OtpProviderViaMail extends ChangeNotifier {
  OtpState _state = OtpState.Null;
  OtpState get state => _state;

  String? _email;
  String get email => _email ?? '';

  Timer? timer;
  final int _timeLimit = 60;
  int? _timeLeft;

  void _changeOtpState(OtpState otpState) {
    if (state != OtpState.Resent && timer != null) {
      timer?.cancel();
    }
    _state = otpState;
    notifyListeners();
  }

  Future<void> forgotPassword({required String email}) async {
    _changeOtpState(OtpState.Sending);
    Map<String, dynamic> response =
        await locator.get<OtpServiceViaEmail>().forgotPassword(email);

    if (response[code] == 200) {
      _email = email;
      showSnackBar(response[msg].toString());
      _changeOtpState(OtpState.Sent);
    } else {
      if (response[error] != null) {
        showSnackBar(response[error].toString());
      }
      _changeOtpState(OtpState.Failed);
    }
  }

  Future<void> verifyOTP({required String otp}) async {
    _changeOtpState(OtpState.Verifying);
    Map<String, dynamic> response =
        await locator.get<OtpServiceViaEmail>().verifyOTP(email, otp);

    if (response[code] == 200) {
      showSnackBar(response[msg].toString());
      _changeOtpState(OtpState.Verified);
    } else {
      if (response[error] != null) {
        showSnackBar(response[error].toString());
      }
      _changeOtpState(OtpState.Unverified);
      if (response[code] == 403) {
        _changeOtpState(OtpState.Expired);
      }
    }
  }

  Future<void> resendOTP({required String email}) async {
    if (state == OtpState.Resent) {
      showSnackBar('Otp Already Sent\nWait for $_timeLeft seconds');
      return;
    }

    _changeOtpState(OtpState.Sending);
    Map<String, dynamic> response =
        await locator.get<OtpServiceViaEmail>().resendOTP(email);

    if (response[code] == 200) {
      _email = email;
      showSnackBar(response[msg].toString());
      _changeOtpState(OtpState.Resent);
      _timeLeft = _timeLimit;
      shouldResendOTP();
    } else {
      if (response[error] != null) {
        showSnackBar(response[error].toString());
      }
      _changeOtpState(OtpState.Failed);
      if (response[code] == 403) {
        _changeOtpState(OtpState.Expired);
      }
    }
  }

  void shouldResendOTP() {
    if (state == OtpState.Resent) {
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        _timeLeft = _timeLimit - timer.tick;
        if (_timeLeft == 0) {
          timer.cancel();
          _changeOtpState(OtpState.Null);
        }
      });
    }
  }

  Future<void> updatePassword({required String password}) async {
    Map<String, dynamic> response =
        await locator.get<OtpServiceViaEmail>().updatePassword(email, password);

    if (response[code] == 200) {
      showSnackBar(response[msg].toString());
    } else {
      if (response[error] != null) {
        showSnackBar(response[error].toString());
      }
    }
  }
}
