import 'package:flutter/material.dart';

import '../../../widgets/achievement_card.dart';
import '../../../widgets/achievement_logo.dart';
import '../../homescreen/home_screen.dart';

class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          },
        ),
        title: const Text(
          'Leaderboard',
          style: TextStyle(
            fontFamily: 'Rubik',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: const Column(
        children: [
          AchievementLogo(),
          SizedBox(height: 20),
          AchievementCard(name: 'Rafidhiahaikal P.', university: 'Universitas Telkom', thumbnailAsset: 'assets/img/demonzz.jpg', score: 1047, placement: 1,),
          AchievementCard(name: 'Muhammad Nagif', university: 'Universitas Telkom', thumbnailAsset: 'assets/img/demonzz.jpg', score: 1046, placement: 2,),
          AchievementCard(name: 'Fahryan Anggriantaka', university: 'Universitas Telkom', thumbnailAsset: 'assets/img/demonzz.jpg', score: 1047, placement: 3,),
          AchievementCard(name: 'Muhammad Nurrasyid W.', university: 'Universitas Telkom', thumbnailAsset: 'assets/img/demonzz.jpg', score: 1046, placement: 4,),
          AchievementCard(name: 'Glorious Satria D. A.', university: 'Universitas Telkom', thumbnailAsset: 'assets/img/demonzz.jpg', score: 1047, placement: 5,),
          AchievementCard(name: 'User X', university: 'Universitas Telkom', thumbnailAsset: 'assets/img/demonzz.jpg', score: 1046, placement: 6,),
        ],
      ),
    );
  }
}
