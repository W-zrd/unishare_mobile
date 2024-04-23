import 'package:flutter/material.dart';
import 'package:unishare/app/widgets/card/post_card.dart';

class MagangPage extends StatelessWidget {
  const MagangPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
          children: const [
            PostCard(
              type: 'Network Security Engineer',
              title: 'DKatalis Indonesia',
              period: 'Registrasi: 21 Feb - 30 Apr 2023',
              location: 'Lokasi: DKI Yogyakarta',
              thumbnailAsset: 'assets/img/unishare_splash.png',
            ),
            PostCard(
              type: 'Software Engineer',
              title: 'Intrego.ai',
              period: 'Registrasi: 12 Des - 30 Jan 2024',
              location: 'Lokasi: Lembang, Bandung',
              thumbnailAsset: 'assets/img/unishare_splash.png',
            ),
          ],
        ),
    );
  }
}
