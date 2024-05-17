import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:unishare/app/controller/karir_controller.dart';
import 'package:unishare/app/controller/karir_submission_controller.dart';
import 'package:unishare/app/models/karirmodel.dart';
import 'package:unishare/app/widgets/date/date_card.dart';
import 'package:unishare/app/widgets/date/date_button.dart';

class JadwalPage extends StatelessWidget {
  final KarirSubmissionService _karirSubmissionService =
      KarirSubmissionService();

  JadwalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Berikut adalah jadwalmu',
              style: TextStyle(
                fontFamily: 'Rubik',
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 4),
            Expanded(child: _buildJadwalList(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildJadwalList(BuildContext context) {
    return StreamBuilder(
      stream: _karirSubmissionService
          .getDocumentsByField(FirebaseAuth.instance.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No data available'));
        }
        return ListView(
          children: snapshot.data!.docs
              .map((doc) => _buildJadwalItem(doc, context))
              .toList(),
        );
      },
    );
  }

  Widget _buildJadwalItem(DocumentSnapshot doc, BuildContext context) {
    Map<String, dynamic> dataSubmission = doc.data() as Map<String, dynamic>;
    KarirService _karirService = KarirService();

    return FutureBuilder<DocumentSnapshot>(
      future: _karirService.getKarirByID(dataSubmission[
          'karirID']), // Ensure you use the correct key for the ID
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error fetching karir data'));
        }
        if (!snapshot.hasData || !snapshot.data!.exists) {
          return Center(child: Text('Karir data not available'));
        }

        Map<String, dynamic> dataKarir =
            snapshot.data!.data() as Map<String, dynamic>;
        KarirPost karirPost = KarirPost(
          posisi: dataKarir['posisi'],
          penyelenggara: dataKarir['penyelenggara'],
          lokasi: dataKarir['lokasi'],
          urlKarir: dataKarir['urlKarir'],
          img: dataKarir['img'],
          tema: dataKarir['tema'],
          kategori: dataKarir['kategori'],
          deskripsi: dataKarir['deskripsi'],
          startDate: dataKarir['startDate'],
          endDate: dataKarir['endDate'],
          AnnouncementDate: dataKarir['AnnouncementDate'],
        );

        return DateCard(
          penyelenggara: karirPost.penyelenggara,
          kategori: karirPost.kategori,
          tanggal: karirPost.endDate.toDate().day.toString() +
              "-" +
              karirPost.endDate.toDate().month.toString() +
              "-" +
              karirPost.endDate.toDate().year.toString(),
        );
      },
    );
  }
}
