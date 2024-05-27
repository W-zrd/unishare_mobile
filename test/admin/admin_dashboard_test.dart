import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:unishare/app/models/acara_kemahasiswaan.dart';
import 'package:unishare/app/modules/admin/dashboard/controller/latest_post.dart';
import 'package:unishare/app/modules/admin/dashboard/views/dashboard_admin.dart';
import 'package:unishare/app/widgets/card/post_card.dart';
import 'package:unishare/app/widgets/dadrawer.dart';

import '../mock.dart';
import '../test_helper.dart';

void main() {
  group('Dashboard Admin Test Group', () {
    setupFirebaseAuthMocks();

    setUpAll(() async {
      await Firebase.initializeApp();
    });

    testWidgets('Verify the presence of widgets on the Admin Dashboard Page',
            (WidgetTester tester) async {
          FlutterError.onError = ignoreOverflowErrors;

          await tester.pumpWidget(const MaterialApp(home: AdminHomePage()));
          expect(find.widgetWithText(AppBar, "Unishare Admin"), findsOneWidget);

          // Find the Scaffold widget
          final scaffoldFinder = find.byType(Scaffold);
          expect(scaffoldFinder, findsOneWidget);

          // Get the Scaffold widget
          final scaffold = tester.widget<Scaffold>(scaffoldFinder);

          // Check if the drawer property is not null
          expect(scaffold.drawer, isNotNull);
        });


    testWidgets('Admin Dashboard Page test success state with latest posts', (WidgetTester tester) async {
      // Override the getLatestPosts method to return a list of posts
      LatestPostService.getLatestPostsOverride = () async {
        return [
          AcaraKemahasiswaan(
            kategori: 'Category 1',
            judul: 'Title 1',
            startDate: Timestamp.fromDate(DateTime(2023, 1, 1)),
            endDate: Timestamp.fromDate(DateTime(2023, 1, 5)),
            lokasi: 'Location 1',
            img: '',
          ),
          AcaraKemahasiswaan(
            kategori: 'Category 2',
            judul: 'Title 2',
            startDate: Timestamp.fromDate(DateTime(2023, 2, 1)),
            endDate: Timestamp.fromDate(DateTime(2023, 2, 10)),
            lokasi: 'Location 2',
            img: '',
          ),
        ];
      };

      await tester.pumpWidget(const MaterialApp(home: AdminHomePage()));
      await tester.pumpAndSettle();

      expect(find.byType(PostCard), findsNWidgets(2));
      expect(find.text('Title 1'), findsOneWidget);
      expect(find.text('Title 2'), findsOneWidget);
    });

    testWidgets('Admin Dashboard Test success state with empty latest posts',
            (WidgetTester tester) async {
          // Override the getLatestPosts method to return an empty list
          LatestPostService.getLatestPostsOverride = () async {
            return [];
          };

          await tester.pumpWidget(const MaterialApp(home: AdminHomePage()));
          await tester.pumpAndSettle();

          expect(find.byType(PostCard), findsNothing);
        });

  });
}
