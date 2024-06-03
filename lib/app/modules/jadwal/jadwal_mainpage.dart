import 'package:flutter/material.dart';
import 'package:unishare/app/modules/jadwal/jadwal.dart';
import 'package:unishare/app/modules/jadwal/to_do_list.dart';

class JadwalMain extends StatefulWidget {
  const JadwalMain({super.key});

  @override
  _JadwalMainState createState() => _JadwalMainState();
}

class _JadwalMainState extends State<JadwalMain> {
  final int _selectedIndex = 0;

  final List<Widget> _pages = [
    JadwalPage(),
    ToDoListPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: _selectedIndex,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Jadwal',
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
                  'Jadwal',
                  style: TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'To-do List',
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
