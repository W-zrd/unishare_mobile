// test/login_screen_test.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:unishare/app/modules/auth/controller/auth_controller.dart';
import 'package:unishare/app/modules/auth/login/views/login_screen.dart';
import 'package:unishare/app/modules/auth/register/views/register_screen.dart';
import 'package:unishare/app/modules/homescreen/home_screen.dart';
import 'package:unishare/app/modules/onboarding/views/onboarding_screen.dart';
import 'package:unishare/app/widgets/button/google_button.dart';
import 'package:unishare/app/widgets/button/primary_button.dart';

import 'mock.dart';
import 'test_helper.dart';

class MockLoginService extends Mock implements AuthService {
  @override
  Future<User?> signInWithEmailAndPassword(String email, String password) {
    return super.noSuchMethod(
      Invocation.method(
        #signInWithEmailAndPassword,
        [email, password],
      ),
      returnValue: Future.value(null),
      returnValueForMissingStub: Future.value(null),
    );
  }
}

class MockUser extends Mock implements User {}

void main() {


  group('LoginPage', () {
    late MockLoginService mockLoginService;
    setupFirebaseAuthMocks();

    setUpAll(() async {
      await Firebase.initializeApp();
    });

    testWidgets('Renders Login Page correctly', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: LoginPage()));
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(Image), findsOneWidget);
      expect(find.byType(TextField), findsExactly(2));
      expect(find.byType(PrimaryButton), findsOneWidget);
      expect(find.byType(GoogleButton), findsOneWidget);

      expect(find.text('Masukkan Email address'), findsOneWidget);
      expect(find.text('Masukkan Email address'), findsOneWidget);
      expect(find.text('Remember Password'), findsOneWidget);
      expect(find.text('Masuk Akun'), findsAtLeastNWidgets(1));
      expect(find.text('Register!'), findsOneWidget);
    });

    testWidgets('Login Page navigates to Home Screen when credentials are filled',
            (WidgetTester tester) async {
          FlutterError.onError = ignoreOverflowErrors;

          // Create a mock LoginService
          final mockLoginService = MockLoginService();

          // Override the `signInWithEmailAndPassword` method to return a MockUser when valid credentials are provided
          when(mockLoginService.signInWithEmailAndPassword('exploiter.47@gmail.com', 'Wzrd1234'))
              .thenAnswer((_) async => MockUser());

          // Build the LoginPage with the mock service
          await tester.pumpWidget(MaterialApp(
            home: LoginPage(loginService: mockLoginService),
          ));

          // Enter valid credentials
          await tester.enterText(find.byKey(const Key('email-field')), 'exploiter.47@gmail.com');
          await tester.enterText(find.byKey(const Key('password-field')), 'Wzrd1234');

          // Tap the "Masuk Akun" button
          await tester.ensureVisible(find.byType(PrimaryButton));
          await tester.pumpAndSettle();
          await tester.tap(find.byType(PrimaryButton));
          await tester.pumpAndSettle();

          // Verify that the HomeScreen is displayed
          expect(find.byType(HomeScreen), findsOneWidget);
        });

    testWidgets('Stay on login page message when login fails', (WidgetTester tester) async {
      FlutterError.onError = ignoreOverflowErrors;

      // Create a mock LoginService
      final mockLoginService = MockLoginService();

      // Override the `signInWithEmailAndPassword` method to simulate a failed login
      when(mockLoginService.signInWithEmailAndPassword('invalid@example.com', 'wrongpassword'))
          .thenAnswer((_) async => null);

      // Build the LoginPage with the mock service
      await tester.pumpWidget(MaterialApp(
        home: LoginPage(loginService: mockLoginService),
      ));

      // Enter invalid credentials
      await tester.enterText(find.byKey(const Key('email-field')), 'invalid@example.com');
      await tester.enterText(find.byKey(const Key('password-field')), 'wrongpassword');

      // Tap the "Masuk Akun" button
      await tester.ensureVisible(find.byType(PrimaryButton));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(PrimaryButton));
      await tester.pumpAndSettle();

      // Verify that the user remains on the LoginPage
      expect(find.byType(LoginPage), findsOneWidget);
    });

    testWidgets('Back button on Login screen navigates to OnboardingScreen', (WidgetTester tester) async {
      // Build the RegisterPage widget
      await tester.pumpWidget(MaterialApp(
        routes: {
          '/': (context) => const OnboardingScreen(),
          '/login': (context) => const LoginPage(),
        },
        initialRoute: '/login',
      ));

      // Tap on the back button in the app bar
      await tester.tap(find.byType(IconButton));
      await tester.pumpAndSettle();

      // Verify that the OnboardingScreen is displayed
      expect(find.byType(OnboardingScreen), findsOneWidget);
    });

    testWidgets('Register text button navigates to register page', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: LoginPage(),
      ));

      await tester.ensureVisible(find.byKey(Key("register-text-button")));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(Key("register-text-button")));
      await tester.pumpAndSettle();

      // Verify that the HomeScreen is displayed
      expect(find.text("Atau daftar menggunakan"), findsOneWidget);
      expect(find.byType(RegisterPage), findsOneWidget);
    });

  });
}
