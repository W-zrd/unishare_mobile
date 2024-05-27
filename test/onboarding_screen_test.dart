import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:unishare/app/modules/auth/login/views/login_screen.dart';
import 'package:unishare/app/modules/auth/register/views/register_screen.dart';
import 'package:unishare/app/modules/onboarding/views/onboarding_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'mock.dart';

void main() {
  setupFirebaseAuthMocks();
  setUpAll(() async {
    await Firebase.initializeApp();
  });

  testWidgets('Splash screen should navigate to the Onboarding screen after 3 seconds delay', (WidgetTester tester) async {
    // Build the OnboardingScreen widget
    await tester.pumpWidget(const MaterialApp(
      home: OnboardingScreen(),
    ));

    expect(find.text("Temukan Peluangmu!"), findsOneWidget);
    expect(find.text('Kami hadir untuk memberikanmu akses ke informasi terbaru dengan mudah dan cepat di ujung jari mu.'), findsOneWidget);
    expect(find.text("Masuk"), findsOneWidget);
    expect(find.text("Daftar Akun"), findsOneWidget);
    expect(find.text('Dengan masuk atau mendaftar, kamu smenyetujui Persyaratan Layanan & Kebijakan Privasi kami'), findsOneWidget);

    // Tap the "Masuk" button and verify navigation
    await tester.tap(find.text("Masuk"));
    await tester.pumpAndSettle(); // Wait for the navigation transition to complete
    expect(find.byType(LoginPage), findsOneWidget);

    // Simulate tapping the system back button
    await tester.tap(find.byType(IconButton));
    await tester.pumpAndSettle();
    expect(find.text("Masuk"), findsOneWidget);
    expect(find.text("Daftar Akun"), findsOneWidget);

    // Tap the "Daftar Akun" button and verify navigation
    await tester.tap(find.text("Daftar Akun"));
    await tester.pumpAndSettle(); // Wait for the navigation transition to complete
    expect(find.byType(RegisterPage), findsOneWidget);
  });
}
