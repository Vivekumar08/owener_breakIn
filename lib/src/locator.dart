import 'package:get_it/get_it.dart';
import 'services/api/api.dart';
import 'services/db/db.dart';
import 'services/location/location.dart';

final GetIt locator = GetIt.instance;

setup() {
  // Api Services
  locator.registerLazySingleton<AuthService>(() => AuthService());
  locator.registerLazySingleton<OtpServiceViaEmail>(() => OtpServiceViaEmail());
  locator.registerLazySingleton<ProfileService>(() => ProfileService());
  locator.registerLazySingleton<OwnerService>(() => OwnerService());
  locator.registerLazySingleton<ListPlaceService>(() => ListPlaceService());

  // DB services
  locator.registerLazySingleton<TokenStorage>(() => TokenStorage());
  locator.registerLazySingletonAsync<OwnerStorage>(
      () async => await OwnerStorage.init());
  locator.registerLazySingletonAsync<ListPlaceStorage>(
      () async => await ListPlaceStorage.init());
  locator.registerLazySingletonAsync<FoodPlaceStorage>(
      () async => await FoodPlaceStorage.init());
  locator.registerLazySingletonAsync<MenuStorage>(() async =>
      await MenuStorage.init(await locator.getAsync<FoodPlaceStorage>()));

  // Location Service
  locator.registerLazySingleton<LocationService>(() => LocationService());
}
