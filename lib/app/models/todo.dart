import 'package:cloud_firestore/cloud_firestore.dart';

class ToDo {
  final String id;
  final String judul;
  final String kategori;
  final DateTime deadline;
  final String status;

  ToDo({
    required this.id,
    required this.judul,
    required this.kategori,
    required this.deadline,
    required this.status,
  });

  factory ToDo.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ToDo(
      id: doc.id,
      judul: data['judul'],
      kategori: data['kategori'],
      deadline: (data['deadline'] as Timestamp).toDate(),
      status: data['status'],
    );
  }

  Map<String, dynamic> toJson() => {
        'judul': judul,
        'kategori': kategori,
        'deadline': deadline,
        'status': status,
      };
}