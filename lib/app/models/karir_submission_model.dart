import 'package:cloud_firestore/cloud_firestore.dart';

class KarirSubmission {
  final String nama;
  final String email;
  final String nomorHp;
  final String alamatKtp;
  final String alamatDomisili;
  final String cv;
  final String motivLetter;
  final String linkedin;
  final String universitas;
  final String fakultas;
  final String jurusan;
  final String karirID;
  final String userID;

  KarirSubmission({
    required this.nama,
    required this.email,
    required this.nomorHp,
    required this.alamatKtp,
    required this.alamatDomisili,
    required this.cv,
    required this.motivLetter,
    required this.linkedin,
    required this.universitas,
    required this.fakultas,
    required this.jurusan,
    required this.karirID,
    required this.userID,
  });

  Map<String, dynamic> toMap() => {
        'nama': nama,
        'email': email,
        'nomorhp': nomorHp,
        'alamatktp': alamatKtp,
        'alamatdomisili': alamatDomisili,
        'cv': cv,
        'motivletter': motivLetter,
        'linkedin': linkedin,
        'universitas': universitas,
        'fakultas': fakultas,
        'jurusan': jurusan,
        'karirID': karirID,
        'userID': userID,
      };
}
