import 'package:flutter/material.dart';

import '../homescreen/home_screen.dart';
// import 'package:intl/intl.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});
  // const String constantDateTimeString = "2024-03-26 13:22";

  final List<Map<String, dynamic>> content = const [
    {
      "icon": Icon(Icons.email),
      "title": "Ubah password akun",
      "desc": "Password anda telah berhasil diubah!",
      // "time": Text(DateFormat('hh:mm a').format(DateTime.now())),
    },
    {
      "icon": Icon(Icons.shield),
      "title": "Kompetisi : JOINTS CTF UGM",
      "desc": "Sertifikat juara telah dikirim via Email ketua!",
      // "time": (constantDateTimeString).toString().substring(11, 16),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notifikasi',
          style: TextStyle(
            fontFamily: 'Rubik',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          },
        ),
      ),
      backgroundColor: const Color(0xFFF6F7FF),
      body: ListView.separated(
          padding: EdgeInsets.all(20),
          itemCount: content.length,
          separatorBuilder: (context, index) => SizedBox(height: 10),
          itemBuilder: (context, index) {
            return ListTile(
              tileColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              leading: CircleAvatar(
                backgroundColor: Color(0xFFFEEACB),
                child: content[index]["icon"],
              ),
              title: Text(content[index]["title"]),
              subtitle: Text(content[index]["desc"]),
            );
          }),
    );
  }
}
