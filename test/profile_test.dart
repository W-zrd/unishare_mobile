import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:unishare/app/modules/homescreen/home_screen.dart';
import 'package:unishare/app/modules/profil/controller/image_service.dart';
import 'package:unishare/app/modules/profil/controller/user_service.dart';
import 'package:unishare/app/modules/profil/views/profil_page.dart';

import 'mock.dart';
import 'test_helper.dart';

class MockProfileService extends Mock implements ProfileService {
  @override
  Future<Map<String, dynamic>?> getUserData() async {
    print('Mocked getUserData called');
    return {
      'nama': 'John Doe',
      'email': 'john@example.com',
      'password': 'password123',
      'alamat': '123 Street',
    };
  }
}

class MockImageService extends Mock implements ImageService {
  @override
  Future<String?> pickImageAndUpload() async {
    return 'https://example.com/mocked_image.jpg';
  }
}

void main() {
  group('Profile page test group', () {
    late MockProfileService mockProfileService;
    late MockImageService mockImageService;

    setupFirebaseAuthMocks();

    setUpAll(() {
      mockProfileService = MockProfileService();
      mockImageService = MockImageService();
    });

    testWidgets('ProfilPage is rendered correctly', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: ProfilPage()));

      expect(find.text('Profil'), findsOneWidget);
      expect(find.byType(CircleAvatar), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(4));
      expect(find.text('Update'), findsOneWidget);
    });

    testWidgets('User data is fetched and displayed correctly', (WidgetTester tester) async {
      FlutterError.onError  = ignoreOverflowErrors;
      await tester.pumpWidget(MaterialApp(
        home: ProfilPage(
          profileService: mockProfileService,
          imageService: mockImageService,
        ),
      ));
      await tester.pumpAndSettle();
      tester.widgetList(find.byType(Text)).forEach((widget) {
        print((widget as Text).data);
      });

      expect(find.text('John Doe'), findsOneWidget);
      expect(find.text('john@example.com'), findsOneWidget);
      expect(find.text('123 Street'), findsOneWidget);
    });
  });
}