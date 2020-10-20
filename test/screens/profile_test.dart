import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get_it/get_it.dart';
import 'package:melton_app/api/api.dart';

import 'package:melton_app/screens/profile.dart';
import 'package:melton_app/sentry/SentryService.dart';

import '../api/mock_api.dart';
import '../api/mock_sentry_service.dart';
import '../constants/test_constants.dart';
import '../util/test_util.dart';

void main() {
  testWidgets("Profile screen layout and edit profile with email not editable",
      (WidgetTester tester) async {
    bool success = setupMockDependencies();
    expect(success, true);

    await tester.pumpWidget(TestUtil.makeWidgetTestable(Profile()));
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.edit), findsOneWidget);

    expect(find.text(TestConstants.PROFILE_FELLOW_NAME.toUpperCase()),
        findsOneWidget);

    expect(find.text("IMPACT POINTS:"), findsOneWidget);
    expect(find.text("OPEN STORE!"), findsOneWidget);
    expect(find.text(TestConstants.PROFILE_FELLOW_IMPACT_POINTS.toString()),
        findsOneWidget);

    expect(find.text("BIO"), findsOneWidget);
    expect(find.text(TestConstants.PROFILE_FELLOW_BIO), findsOneWidget);
    expect(find.text("WORK"), findsOneWidget);
    expect(find.text(TestConstants.PROFILE_FELLOW_WORK), findsOneWidget);

    expect(find.text("SOCIAL"), findsOneWidget);
    expect(find.byIcon(FontAwesomeIcons.facebook), findsOneWidget);
    expect(find.byIcon(FontAwesomeIcons.instagram), findsOneWidget);
    expect(find.byIcon(FontAwesomeIcons.twitter), findsOneWidget);
    expect(find.byIcon(FontAwesomeIcons.weixin), findsOneWidget);
    expect(find.byIcon(FontAwesomeIcons.linkedin), findsOneWidget);
    expect(find.byIcon(FontAwesomeIcons.globeAmericas), findsOneWidget);

    expect(find.text("SDGs"), findsOneWidget);

    final Offset point = tester.getCenter(find.text("WORK"));
    await tester.dragFrom(point, Offset(0.0, -800.0));
    await tester.pump();

    expect(find.text("EMAIL"), findsOneWidget);
    expect(find.text(TestConstants.PROFILE_FELLOW_EMAIL), findsOneWidget);
    expect(find.byIcon(Icons.email), findsOneWidget);

    expect(find.text("CAMPUS"), findsOneWidget);
    expect(find.text(TestConstants.PROFILE_FELLOW_CAMPUS), findsOneWidget);

    expect(find.text("JOINED MF IN"), findsOneWidget);
    expect(find.text(TestConstants.PROFILE_FELLOW_BATCH.toString()),
        findsOneWidget);

    expect(find.text("CITY"), findsOneWidget);
    expect(find.text(TestConstants.PROFILE_FELLOW_CITY), findsOneWidget);

    await tester.tap(find.byIcon(Icons.edit));
    await tester.pumpAndSettle();

    expect(find.text("Edit Your Profile"), findsOneWidget);
    expect(find.text("EMAIL"), findsNothing);
  });
}

bool setupMockDependencies() {
  GetIt.instance.registerSingleton<ApiService>(MockApiService());
  GetIt.instance.registerSingleton<SentryService>(MockSentryService());
  return true;
}
