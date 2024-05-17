import 'package:flutter/material.dart';
import '../homescreen/home_screen.dart';
import 'lowongan_kerja.dart';
import 'magang.dart';

class KarirPage extends StatefulWidget {
  const KarirPage({super.key});

  @override
  _KarirPageState createState() => _KarirPageState();
}

class _KarirPageState extends State<KarirPage> {
  final int _selectedIndex = 0;

  final List<Widget> _pages = [
    LowonganKerjaPage(),
    const MagangPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: _selectedIndex,
      child: Scaffold(
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
            'Karir',
            style: TextStyle(
              fontFamily: 'Rubik',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          bottom: const TabBar(
            indicatorColor: Color(0xFFF75600),
            labelColor: Color(0xFFF75600),
            tabs: [
              Tab(
                child: Text(
                  'Lowongan Kerja',
                  style: TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'Magang',
                  style: TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: _pages,
        ),
      ),
    );
  }
}
