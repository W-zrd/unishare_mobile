import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:unishare/app/modules/admin/acara/views/make_acara_post_screen.dart';
import 'package:unishare/app/widgets/file_picker.dart';

import 'mock.dart';
import 'test_helper.dart';

void main() {
  group('Admin acara test group', () {
    setupFirebaseAuthMocks();

    setUpAll(() async {
      await Firebase.initializeApp();
    });

    testWidgets('Verify the presence of widgets', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: MakeAcaraPost()));

      expect(find.widgetWithText(AppBar, 'Buat Acara'), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(5));
      expect(find.byType(DropdownButtonFormField<String>), findsNWidgets(2));

      expect(find.byType(FileInputWidget), findsNWidgets(2));
      expect(find.byIcon(Icons.calendar_today), findsNWidgets(2));
      expect(find.widgetWithText(ElevatedButton, 'Unggah'), findsOneWidget);
    });

    // testWidgets('Verify form submission with invalid data',
    //         (WidgetTester tester) async {
    //       await tester.pumpWidget(MaterialApp(home: MakeAcaraPost()));
    //
    //       // Tap the submit button without filling in the form fields
    //       await tester.ensureVisible(find.widgetWithText(ElevatedButton, 'Unggah'));
    //       await tester.pumpAndSettle();
    //
    //       // Verify that validation errors are displayed
    //       expect(find.text('Judul tidak boleh kosong'), findsOneWidget);
    //       expect(find.text('Penyelenggara tidak boleh kosong'), findsOneWidget);
    //       expect(find.text('Lokasi tidak boleh kosong'), findsOneWidget);
    //       expect(find.text('Link Acara tidak boleh kosong'), findsOneWidget);
    //     });

  });
}
