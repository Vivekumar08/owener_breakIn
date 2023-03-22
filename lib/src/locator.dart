import 'package:get_it/get_it.dart';
import 'services/api/api.dart';
import 'services/db/db.dart';

final GetIt locator = GetIt.instance;

setup() {
  // Api Services
  locator.registerLazySingleton<AuthService>(() => AuthService());
  locator.registerLazySingleton<OtpServiceViaEmail>(() => OtpServiceViaEmail());
  locator.registerLazySingleton<ProfileService>(() => ProfileService());
  locator.registerLazySingleton<OwnerService>(() => OwnerService());

  // DB services
  locator.registerLazySingleton<TokenStorage>(() => TokenStorage());
  locator.registerLazySingletonAsync<OwnerStorage>(
      () async => await OwnerStorage.init());
}
