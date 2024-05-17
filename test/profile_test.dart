import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:unishare/app/modules/homescreen/home_screen.dart';
import 'package:unishare/app/modules/profil/controller/user_service.dart';
import 'package:unishare/app/modules/profil/views/profil_page.dart';

import 'mock.dart';
import 'test_helper.dart';

class MockUser extends Mock implements User {}

class MockProfileService extends Mock implements ProfileService {
  @override
  Future<Map<String, dynamic>?> getUserData() {
    return super.noSuchMethod(
      Invocation.method(#getUserData, null),
      returnValue: Future.value({
        'nama': 'John Doe',
        'email': 'john@example.com',
        'password': 'password123',
        'alamat': '123 Main St',
      }),
      returnValueForMissingStub: Future.value({
        'nama': 'John Doe',
        'email': 'john@example.com',
        'password': 'password123',
        'alamat': '123 Main St',
      }),
    );
  }

  @override
  Future<User?> getLoggedInUser() {
    return super.noSuchMethod(
      Invocation.method(#getLoggedInUser, null),
      returnValue: Future.value(MockUser()),
      returnValueForMissingStub: Future.value(null),
    );
  }
}

class MockFirebaseAuth extends Mock implements FirebaseAuth {
  final User? _currentUser;

  MockFirebaseAuth(this._currentUser);

  @override
  User? get currentUser => _currentUser;
}

late MockProfileService mockProfileService;
late MockUser mockUser;

void main() {
  group('Profile page test group', () {
    late MockProfileService mockProfileService;

    setupFirebaseAuthMocks();

    setUpAll(() async {
      await Firebase.initializeApp();
      mockProfileService = MockProfileService();
    });

    testWidgets('Test getLoggedInUser() error handling', (WidgetTester tester) async {
      FlutterError.onError = ignoreOverflowErrors;

      // Create a mock ProfileService that throws an error when getLoggedInUser() is called
      final mockProfileServiceWithError = MockProfileService();
      when(mockProfileServiceWithError.getLoggedInUser()).thenAnswer((_) async {
        throw Exception('Test error');
      });

      // Expect the exception to be thrown
      expect(
        mockProfileServiceWithError.getLoggedInUser(),
        throwsA(isInstanceOf<Exception>()),
      );
      
      when(mockProfileServiceWithError.getUserData()).thenAnswer((_) async => null);

      await tester.pumpWidget(
        MaterialApp(
          home: ProfilPage(profileService: mockProfileServiceWithError),
        ),
      );

      // Wait for the asynchronous operation to complete and the widget tree to rebuild
      await tester.pumpAndSettle();

      // Verify that the TextFormFields are empty since getUserData() returns null
      expect(find.byWidgetPredicate((widget) => widget is TextFormField && widget.controller?.text == ''), findsNWidgets(4));

    });

    testWidgets('Test back button can navigate to Home screen', (WidgetTester tester) async {
      FlutterError.onError = ignoreOverflowErrors;

      await tester.pumpWidget(
        MaterialApp(
          home: ProfilPage(profileService: mockProfileService),
        ),
      );
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();
      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets('Test setState() after getting user data', (WidgetTester tester) async {
      FlutterError.onError = ignoreOverflowErrors;

      await tester.pumpWidget(
        MaterialApp(
          home: ProfilPage(profileService: mockProfileService),
        ),
      );

      // Wait for the asynchronous operation to complete and the widget tree to rebuild
      await tester.pumpAndSettle();

      // Verify that the TextFormFields are populated with the test data
      expect(find.byWidgetPredicate((widget) => widget is TextFormField && widget.controller?.text == 'John Doe'), findsOneWidget);
      expect(find.byWidgetPredicate((widget) => widget is TextFormField && widget.controller?.text == 'john@example.com'), findsOneWidget);
      expect(find.byWidgetPredicate((widget) => widget is TextFormField && widget.controller?.text == 'password123'), findsOneWidget);
      expect(find.byWidgetPredicate((widget) => widget is TextFormField && widget.controller?.text == '123 Main St'), findsOneWidget);
    });


  });
}