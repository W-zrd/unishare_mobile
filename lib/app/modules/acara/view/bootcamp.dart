import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:unishare/app/controller/acara_controller.dart';
import 'package:unishare/app/models/acara_kemahasiswaan.dart';
import 'package:unishare/app/modules/acara/view/acara_post_card.dart';
import 'package:unishare/app/modules/acara/view/detail_acara.dart';

class WorkshopPage extends StatelessWidget {
  final AcaraService acaraService;

  WorkshopPage({Key? key, AcaraService? acaraService})
      : acaraService = acaraService ?? AcaraService(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [Expanded(child: _buildAcaraList(context))],
      ),
    );
  }

  Widget _buildAcaraList(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: acaraService.getDocumentsByKategori('Bootcamp'),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print('Error: ${snapshot.error}');
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: Text('Loading...'));
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No data available'));
        }

        final docs = snapshot.data!.docs;
        return ListView(
          key: Key('acara_list'),
          children: docs.map((doc) => _buildAcaraItem(doc, context)).toList(),
        );
      },
    );
  }

  Widget _buildAcaraItem(DocumentSnapshot doc, BuildContext context) {
    final data = doc.data() as Map<String, dynamic>;
    final acara = AcaraKemahasiswaan.fromJson(data);

    final startDate = acara.startDate?.toDate();
    final endDate = acara.endDate?.toDate();
    final startDateString = startDate != null
        ? '${startDate.day}-${startDate.month}-${startDate.year}'
        : 'TBA';
    final endDateString = endDate != null
        ? '${endDate.day}-${endDate.month}-${endDate.year}'
        : 'TBA';

    return PostCardAcara(
      key: Key('acara_item_${doc.id}'),
      type: acara.kategori,
      title: acara.judul,
      period: 'Registrasi: $startDateString sampai $endDateString',
      location: acara.lokasi,
      thumbnailAsset: 'assets/img/unishare_splash.png',
      announcementDate: acara.announcementDate != null
          ? 'Pengumuman: ${acara.announcementDate!.toDate().day}-${acara.announcementDate!.toDate().month}-${acara.announcementDate!.toDate().year}'
          : 'Pengumuman: TBA',
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailAcara(
              acaraID: doc.id,
              acara: acara,
            ),
          ),
        );
      },
    );
  }
}
