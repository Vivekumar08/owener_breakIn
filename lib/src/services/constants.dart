import '../style/snack_bar.dart';

String baseUrl = 'https://breakin-backend.onrender.com/owner';

Duration authTimeout = const Duration(seconds: 5);
Duration otpTimeout = const Duration(seconds: 10);
Duration settingsTimeout = const Duration(seconds: 5);

void noInternet() => showSnackBar('No Internet');
void timeOut() => showSnackBar('Timeout');
