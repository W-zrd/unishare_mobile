import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:unishare/app/modules/onboarding/views/onboarding_screen.dart';
import 'package:unishare/app/modules/splashscreen/views/splash_screen.dart';

void main() {
  testWidgets('Splash screen should be loaded if the user open the UniShare app in their phone', (WidgetTester tester) async {
    // Build the SplashScreen widget
    await tester.pumpWidget(MaterialApp(
      home: SplashScreen(),
    ));

    // Wait for initial setup to complete
    await tester.pumpAndSettle();

    // Verify that the SplashScreen is displayed initially
    expect(find.text('Unlock Your Opportunities\nBoost Your Career'), findsOneWidget);

    // Wait for 3 seconds (as defined in the SplashScreen widget) to simulate the delay
    await tester.pump(const Duration(seconds: 3));

    // Verify that after the delay, the OnboardingScreen is displayed
    expect(find.byType(OnboardingScreen), findsOneWidget);
  });
}
