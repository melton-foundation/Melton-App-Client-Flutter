import 'package:flutter/material.dart';

import 'package:melton_app/sentry/SentryService.dart';

class MockSentryService extends SentryService {

  bool isSentryErrorReported = false;

  @override
  Future<void> reportErrorToSentry({@required dynamic error, dynamic stackTrace}) async {
    isSentryErrorReported = true;
    return;
  }

  bool getIsSentryErrorReported() {
    return isSentryErrorReported;
  }
}