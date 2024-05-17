import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../homescreen/home_screen.dart';

class BeasiswaScreen extends StatelessWidget {
  const BeasiswaScreen({super.key});

  final List<Map<String, dynamic>> content = const [
    {
      // "image": AssetImage('assets/img/defaultimage.png'),
      "title": "Bright YBM BRILiaN",
      "jenis": "Swasta",
      // "deadline": tanggal
      "penyelenggara": "YBM BRILiaN"
    },
    {
      // "image": AssetImage('assets/img/defaultimage.png'),
      "title": "Beasiswa Surabaya",
      "jenis": "Pemerintah",
      // "deadline": tanggal
      "penyelenggara": "Pemerintah Kota Surabaya"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Beasiswa',
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
              // leading: Image(image: content[index]["image"]),
              title: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Positioned(
                      child: Text(
                        content[index]["jenis"], // Replace with your data key
                        style: const TextStyle(
                          color: Colors.orange, // Set the desired orange color
                          fontSize: 12.0, // Adjust font size as needed
                        ),
                      ),
                    ),
                  ),
                  // Title below the orange text
                  Align(
                    alignment:
                        Alignment.centerLeft, // Or adjust alignment as needed
                    child: Text(
                      content[index]["title"],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 8.0),
                ],
              ),
              subtitle: Text('Deadline: ...\n' +
                  'Penyelenggara: ' +
                  content[index]["penyelenggara"]),
              isThreeLine: true,
            );
          }),
    );
  }

}
