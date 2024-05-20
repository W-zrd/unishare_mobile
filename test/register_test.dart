import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:unishare/app/controller/auth_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:unishare/app/modules/auth/register/views/register_screen.dart';
import 'package:unishare/app/modules/homescreen/home_screen.dart';
import 'package:unishare/app/modules/onboarding/views/onboarding_screen.dart';
import 'package:unishare/app/widgets/button/primary_button.dart';
import 'mock.dart';
import 'package:mockito/mockito.dart';

import 'test_helper.dart';

class MockRegisterService extends Mock implements AuthService {
  @override
  Future<User?> registerUser(
      String email, String password, String displayName) async {
    // Always return a successful MockUser instance
    return MockUser();
  }
}

class MockUser extends Mock implements User {
  @override
  String get displayName => 'Wzrd@OurMine';
}

void main() {
  group('RegisterPage widget test', () {
    late MockRegisterService mockRegisterService;
    setupFirebaseAuthMocks();

    setUpAll(() async {
      await Firebase.initializeApp();
      mockRegisterService = MockRegisterService();
    });

    testWidgets('Renders Register Page correctly', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: RegisterPage()));

      expect(find.byType(Image), findsOneWidget);
      expect(find.byType(TextField), findsExactly(3));
      expect(find.byType(PrimaryButton), findsOneWidget);

      expect(find.text('Masukkan Nama Lengkap'), findsOneWidget);
      expect(find.text('Masukkan Email Address'), findsOneWidget);
      expect(find.text('Daftar Akun'), findsAtLeastNWidgets(1));
    });

    testWidgets('Check if the user cant register with blank text fields',
        (WidgetTester tester) async {
      // Build our app and trigger a frame
      await tester.pumpWidget(MaterialApp(
        home: RegisterPage(registerService: mockRegisterService),
      ));

      await tester.ensureVisible(find.byType(PrimaryButton));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(PrimaryButton));
      await tester.pumpAndSettle();

      expect(find.byType(HomeScreen), findsNothing);
      expect(find.byType(RegisterPage), findsOneWidget);
    });

    testWidgets(
        'Register Page navigates to Home Screen when credentials are filled',
        (WidgetTester tester) async {
      FlutterError.onError = ignoreOverflowErrors;
      // Build the RegisterPage with the mock service
      await tester.pumpWidget(MaterialApp(
        home: RegisterPage(registerService: mockRegisterService),
      ));

      // Enter text into the text fields
      await tester.enterText(
          find.byKey(const Key('fullname-field')), 'Wzrd@OurMine');
      await tester.enterText(
          find.byKey(const Key('email-field')), 'test@unishare.com');
      await tester.enterText(
          find.byKey(const Key('password-field')), 'password123');

      // Tap the "Daftar Akun" button
      await tester.ensureVisible(find.byType(PrimaryButton));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(PrimaryButton));
      await tester.pumpAndSettle();

      // Wait for the navigation to complete
      await tester.pumpAndSettle();
      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets('Back button on Register screen navigates to OnboardingScreen',
        (WidgetTester tester) async {
      // Build the RegisterPage widget
      await tester.pumpWidget(MaterialApp(
        routes: {
          '/': (context) => const OnboardingScreen(),
          '/register': (context) => const RegisterPage(),
        },
        initialRoute: '/register',
      ));

      // Tap on the back button in the app bar
      await tester.tap(find.byType(IconButton));
      await tester.pumpAndSettle();

      // Verify that the OnboardingScreen is displayed
      expect(find.byType(OnboardingScreen), findsOneWidget);
    });
  });
}
