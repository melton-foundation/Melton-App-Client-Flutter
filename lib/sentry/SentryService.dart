import 'package:flutter/cupertino.dart';
import 'package:melton_app/util/secrets.dart';
import 'package:sentry/sentry.dart';

class SentryService {
  var sentry;

  SentryService(){
    sentry = SentryClient(dsn: Secrets.SENTRY_CLIENT_DSN);
  }

  getSentryLogger() {
    return sentry;
  }

  Future<void> reportErrorToSentry({@required dynamic error, dynamic stackTrace}) async {
    sentry.captureException(
      exception: error,
      stackTrace: stackTrace,
    );
  }
}