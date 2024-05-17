import 'package:cloud_firestore/cloud_firestore.dart';

class KarirPost {
  final String posisi;
  final String lokasi;
  final String urlKarir;
  final String img;
  final String tema;
  final String kategori;
  final String deskripsi;
  final String penyelenggara;
  final Timestamp startDate;
  final Timestamp endDate;
  final Timestamp AnnouncementDate;

  KarirPost({
    required this.posisi,
    required this.penyelenggara,
    required this.lokasi,
    required this.urlKarir,
    required this.img,
    required this.tema,
    required this.kategori,
    required this.deskripsi,
    required this.startDate,
    required this.endDate,
    required this.AnnouncementDate,
  });

  Map<String, dynamic> toMap() => {
        'posisi': posisi,
        'lokasi': lokasi,
        'urlKarir': urlKarir,
        'img': img,
        'tema': tema,
        'kategori': kategori,
        'deskripsi': deskripsi,
        'startDate': startDate,
        'AnnouncementDate': AnnouncementDate,
        'endDate': endDate,
        'penyelenggara': penyelenggara,
      };
}
