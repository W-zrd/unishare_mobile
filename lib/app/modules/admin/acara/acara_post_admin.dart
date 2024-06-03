import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:unishare/app/modules/admin/acara/make_acara_post_screen.dart';
import 'package:unishare/app/modules/admin/acara/update_acara_post.dart';
import 'package:unishare/app/widgets/card/adminpost.dart';
import 'package:unishare/app/controller/acara_controller.dart';

class AcaraAdmin extends StatelessWidget {
  final AcaraService _acaraService = AcaraService();

  AcaraAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Acara',
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
          Expanded(child: _buildAcaraList(context)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);

          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MakeAcaraPost(),
              ));
        },
        backgroundColor: const Color(0xFFF75600),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildAcaraList(BuildContext context) {
    return StreamBuilder(
        stream: _acaraService.getAcaras(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('Loading...');
          }
          return ListView(
            children: snapshot.data!.docs
                .map((doc) => _buildAcaraItem(doc, context))
                .toList(),
          );
        });
  }

  Widget _buildAcaraItem(DocumentSnapshot doc, BuildContext context) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return AdminPostCard(
      type: data['kategori'],
      title: data['judul'],
      period: 'Open',
      deskripsi: data['penyelenggara'],
      thumbnailAsset: data['img'],
      delete: () async {
        try {
          await AcaraService.deleteAcara(doc.id);
        } catch (e) {
          print('Error deleting beasiswa post: $e');
          // Handle the error appropriately (e.g., show an error message to the user)
        }
      },
      update: () {
        Navigator.of(context).pop(); // Tutup dialog
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UpdateAcaraPost(
                acaraPost: doc,
              ),
            ));
      },
    );
  }
}
