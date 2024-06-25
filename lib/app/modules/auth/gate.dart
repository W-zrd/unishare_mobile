import 'package:flutter/material.dart';
import 'package:unishare/app/controller/database_helper.dart';
import 'package:unishare/app/modules/homescreen/home_screen.dart';
import 'package:unishare/app/modules/onboarding/views/onboarding_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: DatabaseHelper().isDatabaseEmpty(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data ?? true) {
              // logic admin TBD
              return const OnboardingScreen();
            } else {
              return const HomeScreen();
            }
          } else {
            return Stack();
          }
        },
      ),
    );
  }
}
