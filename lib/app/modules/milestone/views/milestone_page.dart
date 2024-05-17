import 'package:flutter/material.dart';

import '../../../widgets/milestone_card.dart';
import '../../../widgets/pencapaian_card.dart';
import '../../homescreen/home_screen.dart';

class MilestonePage extends StatelessWidget {
  const MilestonePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          key: Key('back-button'),
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          },
        ),
        title: const Text(
          'Milestone',
          style: TextStyle(
            fontFamily: 'Rubik',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 25.0, bottom: 5, right: 25.0),
            child: Text(
              'Total Pencapaian',
              style: TextStyle(
                fontFamily: 'Rubik',
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              PencapaianCard(
                  number: '3',
                  desc: 'Milestone Selesai',
                  picture: 'assets/icons/target1.png'),
              PencapaianCard(
                  number: '847 pts',
                  desc: 'Milestone Selesai',
                  picture: 'assets/icons/fire1.png'),
            ],
          ),
          Padding(
            padding:
                EdgeInsets.only(left: 25.0, bottom: 5, right: 25.0, top: 20),
            child: Text(
              'List Milestone',
              style: TextStyle(
                fontFamily: 'Rubik',
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          MilestoneCard(
            isCheckedIn: true,
            isCheckedOut: true,
          ),
          MilestoneCard(
            isCheckedIn: true,
            isCheckedOut: false,
          ),
        ],
      ),
    );
  }
}
