import 'package:cloud_firestore/cloud_firestore.dart';

class BeasiswaPost {
  final String judul;
  final String penyelenggara;
  final String urlBeasiswa;
  final String jenis;
  final String img;
  final String deskripsi;
  final Timestamp startDate;
  final Timestamp endDate;

  BeasiswaPost({
    required this.judul,
    required this.penyelenggara,
    required this.urlBeasiswa,
    required this.jenis,
    required this.img,
    required this.startDate,
    required this.endDate,
    required this.deskripsi,
  });

  Map<String, dynamic> toMap() => {
        'judul': judul,
        'penyelenggara': penyelenggara,
        'urlBeasiswa': urlBeasiswa,
        'jenis': jenis,
        'img': img,
        'startDate': startDate,
        'endDate': endDate,
        'deskripsi': deskripsi,
      };
}
