import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:unishare/app/controller/beasiswa_controller.dart';
import 'package:unishare/app/modules/admin/beasiswa/make_beasiswa_post.dart';
import 'package:unishare/app/modules/admin/beasiswa/update_beasiswa_post.dart';
import 'package:unishare/app/modules/homescreen/home_screen.dart';
import 'package:unishare/app/widgets/card/adminpost.dart';

class BeasiswaScreen extends StatefulWidget {
  final BeasiswaService? beasiswaService;

  const BeasiswaScreen({Key? key, this.beasiswaService}) : super(key: key);

  @override
  _BeasiswaAdminState createState() => _BeasiswaAdminState();
}

class _BeasiswaAdminState extends State<BeasiswaScreen> {
  late BeasiswaService _beasiswaService;

  @override
  void initState() {
    super.initState();
    _beasiswaService = widget.beasiswaService ?? BeasiswaService();
  }

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
      body: Column(
        children: [
          const SizedBox(height: 25),
          Expanded(child: _buildBeasiswaList(context)),
        ],
      ),
    );
  }

  Widget _buildBeasiswaList(BuildContext context) {
    return StreamBuilder(
      stream: _beasiswaService.getBeasiswas(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Error');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        }
        if (snapshot.hasData) {
          return ListView(
            children: snapshot.data!.docs
                .map((doc) => _buildKarirItem(doc, context))
                .toList(),
          );
        }
        return const Text('No data available');
      },
    );
  }

  Widget _buildKarirItem(DocumentSnapshot doc, BuildContext context) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return Card(
      child: ListTile(
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
                  data["jenis"], // Replace with your data key
                  style: const TextStyle(
                    color: Colors.orange, // Set the desired orange color
                    fontSize: 12.0, // Adjust font size as needed
                  ),
                ),
              ),
            ),
            // Title below the orange text
            Align(
              alignment: Alignment.centerLeft, // Or adjust alignment as needed
              child: Text(
                data["judul"],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 8.0),
          ],
        ),
        subtitle:
            Text('Deadline: ...\n' + 'Penyelenggara: ' + data["penyelenggara"]),
        isThreeLine: true,
      ),
    );
  }
}
