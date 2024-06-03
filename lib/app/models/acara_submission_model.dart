import 'package:cloud_firestore/cloud_firestore.dart';

class AcaraSubmission {
  final String nama;
  final String email;
  final String nomorHp;
  final String jurusan;
  final String fakultas;
  final String universitas;
  final String acaraID;
  final String userID;

  AcaraSubmission({
    required this.nama,
    required this.email,
    required this.nomorHp,
    required this.jurusan,
    required this.fakultas,
    required this.universitas,
    required this.acaraID,
    required this.userID,
  });

  Map<String, dynamic> toMap() => {
        'nama': nama,
        'email': email,
        'nomorhp': nomorHp,
        'jurusan': jurusan,
        'fakultas': fakultas,
        'universitas': universitas,
        'acaraID': acaraID,
        'userID': userID,
      };
}