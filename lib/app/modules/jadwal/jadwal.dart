import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:unishare/app/controller/acara_submission_controller.dart';
import 'package:unishare/app/controller/karir_submission_controller.dart';
import 'package:unishare/app/widgets/date/date_card.dart';

class JadwalPage extends StatelessWidget {
  final KarirSubmissionService _karirSubmissionService = KarirSubmissionService();
  final AcaraSubmissionService _acaraSubmissionService = AcaraSubmissionService();

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
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      return Center(child: Text('No user logged in'));
    }

    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: _getCombinedSubmissions(currentUser.uid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No data available'));
        }

        return ListView(
          children: snapshot.data!
              .map<Widget>((submission) => _buildJadwalItem(submission, context))
              .toList(),
        );
      },
    );
  }

  Stream<List<Map<String, dynamic>>> _getCombinedSubmissions(String userID) {
    final karirStream = _karirSubmissionService.getDocumentsByField(userID).map(
        (snapshot) => snapshot.docs.map((doc) => {
          ...doc.data() as Map<String, dynamic>,
          'type': 'karir',
        }).toList());

    final acaraStream = _acaraSubmissionService.getDocumentsByField(userID).map(
        (snapshot) => snapshot.docs.map((doc) => {
          ...doc.data() as Map<String, dynamic>,
          'type': 'acara',
        }).toList());

    return Rx.combineLatest2(karirStream, acaraStream,
        (List<Map<String, dynamic>> karirList, List<Map<String, dynamic>> acaraList) {
      return [...karirList, ...acaraList];
    });
  }

  Widget _buildJadwalItem(Map<String, dynamic> submission, BuildContext context) {
    if (submission['type'] == 'karir') {
      return _buildKarirItem(submission, context);
    } else if (submission['type'] == 'acara') {
      return _buildAcaraItem(submission, context);
    } else {
      return Container();
    }
  }

  Widget _buildKarirItem(Map<String, dynamic> dataSubmission, BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('karir').doc(dataSubmission['karirID']).get(),
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

        Map<String, dynamic> dataKarir = snapshot.data!.data() as Map<String, dynamic>;
        String tanggal = dataKarir['endDate'].toDate().day.toString() +
            "-" +
            dataKarir['endDate'].toDate().month.toString() +
            "-" +
            dataKarir['endDate'].toDate().year.toString();

        return DateCard(
          penyelenggara: dataKarir['penyelenggara'],
          kategori: dataKarir['kategori'],
          tanggal: tanggal,
        );
      },
    );
  }

  Widget _buildAcaraItem(Map<String, dynamic> dataSubmission, BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('acara').doc(dataSubmission['acaraID']).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error fetching acara data'));
        }
        if (!snapshot.hasData || !snapshot.data!.exists) {
          return Center(child: Text('Acara data not available'));
        }

        Map<String, dynamic> dataAcara = snapshot.data!.data() as Map<String, dynamic>;
        String tanggal = dataAcara['announcementDate'] != null
            ? '${dataAcara['announcementDate'].toDate().day}-${dataAcara['announcementDate'].toDate().month}-${dataAcara['announcementDate'].toDate().year}'
            : 'TBA';

        return DateCard(
          penyelenggara: dataAcara['penyelenggara'],
          kategori: dataAcara['kategori'],
          tanggal: tanggal,
        );
      },
    );
  }
}