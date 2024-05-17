import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:unishare/app/modules/admin/dashboard/controller/latest_post.dart';
import 'package:unishare/app/widgets/card/post_card.dart';
import 'package:unishare/app/widgets/dadrawer.dart';
import 'package:unishare/app/models/acara_kemahasiswaan.dart';
import 'package:intl/intl.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Unishare Admin',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF252422),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Container(
            child: const Text(
              "Latest Upload",
              style: TextStyle(),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<AcaraKemahasiswaan>>(
              future: LatestPostService.getLatestPosts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text('Loading...'); // Menampilkan indikator loading
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  final List<AcaraKemahasiswaan>? latestPosts = snapshot.data;
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: latestPosts?.length ?? 0,
                    itemBuilder: (context, index) {
                      final post = latestPosts![index];
                      final startDate = (post.startDate as Timestamp).toDate();
                      final endDate = (post.endDate as Timestamp).toDate();

                      final startDateString =
                          DateFormat('dd-MM').format(startDate);
                      final endDateString = DateFormat('dd-MM').format(endDate);
                      final period = startDateString + " - " + endDateString;
                      return PostCard(
                        type: post.kategori,
                        title: post.judul,
                        period: period,
                        location: post.lokasi,
                        thumbnailAsset: post.img!,
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
      drawer: const DaDrawer(),
    );
  }
}
