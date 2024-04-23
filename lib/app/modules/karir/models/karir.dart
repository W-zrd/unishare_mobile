import 'package:cloud_firestore/cloud_firestore.dart';

class Karir {
  final String judulKarir;
  final String deskripsiKarir;
  final Timestamp startDate;
  final Timestamp endDate;
  final String thumbnailAsset;
  final String salary;
  final String minimumWorkExperience;
  final String requirements;

  Karir({
    required this.judulKarir,
    required this.deskripsiKarir,
    required this.startDate,
    required this.endDate,
    required this.thumbnailAsset,
    required this.salary,
    required this.minimumWorkExperience,
    required this.requirements,
  });
}