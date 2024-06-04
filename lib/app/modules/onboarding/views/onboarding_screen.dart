import 'package:flutter/material.dart';
import 'package:unishare/app/modules/auth/login/views/login_screen.dart';
import 'package:unishare/app/modules/auth/register/views/register_screen.dart';
import 'package:unishare/app/widgets/button/primary_button.dart';
import 'package:unishare/app/widgets/button/secondary_button.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20.0),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Image.asset(
                  'assets/img/logoHD.png',
                  scale: 3.6,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Image.asset(
                    'assets/img/onboarding.png',
                    scale: 2,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 5),
                  child: Text(
                    "Temukan Peluangmu!",
                    style: TextStyle(
                        fontFamily: 'Rubik',
                        fontWeight: FontWeight.bold,
                        fontSize: 24),
                  ),
                ),
                const SizedBox(
                  width: 340,
                  height: 40,
                  child: Text(
                    'Kami hadir untuk memberikanmu akses ke informasi terbaru dengan mudah dan cepat di ujung jari mu.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF7C7974),
                      fontSize: 13,
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: PrimaryButton(
                    "Masuk",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    },
                  ),
                ),
                SecondaryButton("Daftar Akun", null, onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterPage(),
                    ),
                  );
                }),
                const Padding(
                  padding: EdgeInsets.only(top: 60.0, bottom: 25),
                  child: SizedBox(
                    width: 340,
                    height: 40,
                    child: Text(
                      'Dengan masuk atau mendaftar, kamu smenyetujui Persyaratan Layanan & Kebijakan Privasi kami',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF7C7974),
                        fontSize: 12,
                        fontFamily: 'Rubik',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
