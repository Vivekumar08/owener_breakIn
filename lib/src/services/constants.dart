import '../style/snack_bar.dart';

String baseUrl = 'https://breakin-backend.onrender.com/owner';
String resUrl = 'https://breakin-backend.onrender.com/restaurants';
String fileInfo = 'https://breakin-backend.onrender.com/fileinfo';

Duration duration_5 = const Duration(seconds: 5);
Duration duration_10 = const Duration(seconds: 10);

void noInternet() => showSnackBar('No Internet');
void timeOut() => showSnackBar('Timeout');
