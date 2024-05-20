import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:unishare/app/controller/acara_controller.dart';
import 'package:unishare/app/widgets/card/post_card.dart';

class AllAcaraPage extends StatefulWidget {
  final AcaraService? acaraService;

  AllAcaraPage({super.key, this.acaraService});

  @override
  _AllAcaraPageState createState() => _AllAcaraPageState();
}

class _AllAcaraPageState extends State<AllAcaraPage> {
  late AcaraService _acaraService;

  @override
  void initState() {
    super.initState();
    _acaraService = widget.acaraService ?? AcaraService();
  }

  Widget _buildAcaraList(BuildContext context) {
    return StreamBuilder(
      stream: _acaraService.getAcaras(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}')); // Display the error text
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: Text('Loading...')); // Center the loading text
        }
        return ListView(
          children: snapshot.data!.docs
              .map((doc) => _buildAcaraItem(doc, context))
              .toList(),
        );
      },
    );
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
      ),
    );
  }
}