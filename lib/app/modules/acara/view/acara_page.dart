import 'package:flutter/material.dart';
import 'package:unishare/app/controller/acara_controller.dart';
import 'package:unishare/app/modules/acara/view/acara_all.dart';
import 'package:unishare/app/modules/acara/view/kompetisi.dart';
import 'package:unishare/app/modules/acara/view/seminar.dart';
import 'package:unishare/app/modules/acara/view/workshop.dart';

import '../../homescreen/home_screen.dart';

class AcaraPage extends StatefulWidget {
  final AcaraService? acaraService;

  const AcaraPage({Key? key, this.acaraService}) : super(key: key);

  @override
  _AcaraPageState createState() => _AcaraPageState();
}

class _AcaraPageState extends State<AcaraPage> {
  final List<Map<String, dynamic>> buttons = [
    {'key': 'all-category', 'text': 'All', 'icon': Icons.interests_sharp},
    {
      'key': 'kompetisi-category',
      'text': 'Kompetisi',
      'icon': Icons.computer_sharp
    },
    {
      'key': 'workshop-category',
      'text': 'Bootcamp',
      'icon': Icons.settings_outlined
    },
    {
      'key': 'seminar-category',
      'text': 'Seminar',
      'icon': Icons.people_alt_sharp
    },
  ];

  int _selectedIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

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
          'Acara',
          style: TextStyle(
            fontFamily: 'Rubik',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: buttons
                  .asMap()
                  .entries
                  .map(
                    (entry) => Padding(
                      padding:
                          const EdgeInsets.only(left: 5, right: 5, bottom: 8),
                      child: ElevatedButton(
                        key: Key(entry.value['key']),
                        onPressed: () {
                          setState(() {
                            _selectedIndex = entry.key;
                            _pageController.animateToPage(
                              entry.key,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          });
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            _selectedIndex == entry.key
                                ? const Color(0xFFF75600)
                                : Colors.white,
                          ),
                          foregroundColor: MaterialStateProperty.all<Color>(
                            _selectedIndex == entry.key
                                ? Colors.white
                                : const Color(0xFFF75600),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(entry.value['icon']),
                            const SizedBox(width: 8),
                            Text(
                              entry.value['text'],
                              style: const TextStyle(
                                fontFamily: 'Rubik',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              children: [
                AllAcaraPage(),
                KompetisiPage(),
                WorkshopPage(),
                SeminarPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
