import 'package:cloud_firestore/cloud_firestore.dart';

class AcaraKemahasiswaan {
  final String? id;
  final String? lokasi;
  final String? kategori;
  final String? penyelenggara;
  final String? judul;
  final String? urlAcara;
  final String? img;
  final String? guidebook;
  final String? deskripsi;
  final Timestamp? startDate;
  final Timestamp? endDate;
  final Timestamp? announcementDate;

  AcaraKemahasiswaan({
    this.id,
    this.penyelenggara,
    this.lokasi,
    this.kategori,
    this.judul,
    this.urlAcara,
    this.img,
    this.guidebook,
    this.deskripsi,
    this.startDate,
    this.endDate,
    this.announcementDate,
  });

  factory AcaraKemahasiswaan.fromJson(Map<String, dynamic>? json) =>
      AcaraKemahasiswaan(
        penyelenggara: json?['penyelenggara'],
        judul: json?['judul'],
        urlAcara: json?['urlAcara'],
        img: json?['img'],
        guidebook: json?['guidebook'],
        deskripsi: json?['deskripsi'],
        lokasi: json?['lokasi'],
        kategori: json?['kategori'],
        startDate: json?['startDate'],
        endDate: json?['endDate'],
        announcementDate: json?['announcementDate'],
      );

  Map<String, dynamic> toJson() => {
        'penyelenggara': penyelenggara,
        'judul': judul,
        'urlAcara': urlAcara,
        'img': img,
        'guidebook': guidebook,
        'lokasi': lokasi,
        'kategori': kategori,
        'deskripsi': deskripsi,
        'startDate': startDate,
        'endDate': endDate,
        'announcementDate': announcementDate,
      };
}