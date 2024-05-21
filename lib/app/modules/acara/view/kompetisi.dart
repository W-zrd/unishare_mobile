import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:unishare/app/controller/acara_controller.dart';
import 'package:unishare/app/widgets/card/post_card.dart';

class KompetisiPage extends StatefulWidget {
  final AcaraService? acaraService;
  KompetisiPage({Key? key, this.acaraService}) : super(key: key);

  @override
  _KompetisiPageState createState() => _KompetisiPageState();
}

class _KompetisiPageState extends State<KompetisiPage> {
  late AcaraService _kompetisiService;

  @override
  void initState() {
    super.initState();
    _kompetisiService = widget.acaraService ?? AcaraService();
  }

  Widget _buildAcaraList(BuildContext context) {
    return StreamBuilder(
        stream: _kompetisiService.getDocumentsByKategori('Kompetisi'),
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

    Timestamp startDate = data['startDate'];
    String startDateString = startDate.toDate().day.toString() +
        "-" +
        startDate.toDate().month.toString() +
        "-" +
        startDate.toDate().year.toString();

    Timestamp endDate = data['endDate'];
    String endDateString = endDate.toDate().day.toString() +
        "-" +
        endDate.toDate().month.toString() +
        "-" +
        endDate.toDate().year.toString();
    return PostCard(
      type: data['kategori'],
      title: data['judul'],
      period: 'Registrasi: ' + startDateString + ' sampai ' + endDateString,
      location: data['lokasi'],
      thumbnailAsset: 'assets/img/unishare_splash.png',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [Expanded(child: _buildAcaraList(context))],
    ));
  }
}
