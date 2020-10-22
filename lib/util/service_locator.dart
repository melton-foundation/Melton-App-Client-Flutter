import 'package:get_it/get_it.dart';
import 'package:melton_app/api/api.dart';
import 'package:melton_app/sentry/SentryService.dart';
import 'package:melton_app/util/persistent_storage.dart';
import 'package:melton_app/util/token_handler.dart';

final GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerSingletonAsync<PersistentStorage>(() async {
    PersistentStorage ps = PersistentStorage();
    await ps.init();
    return ps;
  });

  await locator.allReady();

  locator.registerSingletonAsync<TokenHandler>(() async {
    TokenHandler handler = TokenHandler();
    await handler.refresh(locator.get<PersistentStorage>());
    return handler;
  });

  locator.registerSingleton<ApiService>(ApiService());

  await locator.allReady();

  locator.registerSingleton<SentryService>(SentryService());

  await locator.allReady();
}
