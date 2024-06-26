import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:unishare/app/controller/karir_controller.dart';
import 'package:unishare/app/modules/admin/karir/makekarirpost.dart';
import 'package:unishare/app/modules/admin/karir/updatekarirpost.dart';
import 'package:unishare/app/widgets/card/adminpost.dart';

class KarirAdmin extends StatefulWidget {
  final KarirService? karirService;

  KarirAdmin({super.key, this.karirService});

  @override
  _KarirAdminState createState() => _KarirAdminState();
}

class _KarirAdminState extends State<KarirAdmin> {
  late KarirService _karirService;

  @override
  void initState() {
    super.initState();
    _karirService = widget.karirService ?? KarirService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Karir',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF252422),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 25,
          ),
          Expanded(child: _buildKarirList(context)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MakeKarirPost(),
            ),
          );
        },
        backgroundColor: const Color(0xFFF75600),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildKarirList(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _karirService.getKarirs(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('Loading...');
        }
        if (snapshot.hasData) {
          return ListView(
            children: snapshot.data!.docs
                .map((doc) => _buildKarirItem(doc, context))
                .toList(),
          );
        }
        return Text('No data');
      },
    );
  }

  Widget _buildKarirItem(QueryDocumentSnapshot doc, BuildContext context) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return AdminPostCard(
      type: data['posisi'] ?? '',
      title: data['penyelenggara'] ?? '',
      period: 'Open',
      deskripsi: data['deskripsi'] ?? '',
      thumbnailAsset: data['img'] ?? '',
      delete: () async {
        await KarirService.deleteKompetisi(doc.id);
      },
      update: () {
        Navigator.of(context).pop(); // Close the dialog
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UpdateKarirPost(
              karirPost: doc,
            ),
          ),
        );
      },
    );
  }
}