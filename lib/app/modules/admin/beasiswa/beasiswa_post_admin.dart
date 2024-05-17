import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:unishare/app/controller/beasiswa_controller.dart';
import 'package:unishare/app/modules/admin/beasiswa/make_beasiswa_post.dart';
import 'package:unishare/app/modules/admin/beasiswa/update_beasiswa_post.dart';
import 'package:unishare/app/widgets/card/adminpost.dart';

class BeasiswaAdmin extends StatefulWidget {
  final BeasiswaService? beasiswaService;

  const BeasiswaAdmin({Key? key, this.beasiswaService}) : super(key: key);

  @override
  _BeasiswaAdminState createState() => _BeasiswaAdminState();
}

class _BeasiswaAdminState extends State<BeasiswaAdmin> {
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
        title: const Text(
          'Beasiswa',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF252422),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          const SizedBox(height: 25),
          Expanded(child: _buildKarirList(context)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MakeBeasiswaPost(),
            ),
          );
        },
        backgroundColor: const Color(0xFFF75600),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildKarirList(BuildContext context) {
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

    return AdminPostCard(
      type: data['judul'] ?? '',
      title: data['penyelenggara'] ?? '',
      period: 'Open',
      deskripsi: data['deskripsi'] ?? '',
      thumbnailAsset: data['img'] ?? 'default_image.png',
      delete: () {
        BeasiswaService.deleteBeasiswa(doc.id);
            },
      update: () {
        Navigator.of(context).pop(); // Close the dialog
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditBeasiswaPost(
              beasiswaPost: doc,
            ),
          ),
        );
      },
    );
  }
}
