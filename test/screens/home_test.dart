import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:get_it/get_it.dart';
import 'package:melton_app/api/api.dart';

import 'package:melton_app/screens/home.dart';
import 'package:melton_app/sentry/SentryService.dart';

import '../api/mock_api.dart';
import '../api/mock_sentry_service.dart';
import '../util/test_util.dart';

void main() {
  final TestWidgetsFlutterBinding binding =
      TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("Home screen and map layout", (WidgetTester tester) async {
    bool success = setupMockDependencies();
    expect(success, true);
    await binding.setSurfaceSize(Size(1024, 768));

    await tester.pumpWidget(TestUtil.makeWidgetTestable(Home()));

    expect(find.text("MELTON NEWS"), findsOneWidget);
    expect(find.text("SEE ALL"), findsOneWidget);
    expect(find.byIcon(Icons.map), findsOneWidget);

    await tester.tap(find.byIcon(Icons.map));
    await tester.pumpAndSettle();

    expect(find.text("MELTON NEWS"), findsNothing);
    expect(find.text("SEE ALL"), findsNothing);
    expect(find.text("Fellows Map"), findsOneWidget);
  });

  testWidgets("Home screen and news layout", (WidgetTester tester) async {
    await tester.pumpWidget(TestUtil.makeWidgetTestable(Home()));

    expect(find.text("MELTON NEWS"), findsOneWidget);
    expect(find.text("SEE ALL"), findsOneWidget);
    expect(find.byIcon(Icons.map), findsOneWidget);

    await tester.tap(find.text("SEE ALL"));
    await tester.pumpAndSettle();

    expect(find.text("SEE ALL"), findsNothing);
  });
}

bool setupMockDependencies() {
  GetIt.instance.registerSingleton<ApiService>(MockApiService());
  GetIt.instance.registerSingleton<SentryService>(MockSentryService());
  return true;
}
