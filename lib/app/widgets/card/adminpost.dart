import 'package:flutter/material.dart';
import 'package:unishare/app/modules/admin/karir/updatekarirpost.dart';

class AdminPostCard extends StatelessWidget {
  final String type;
  final String title;
  final String period;
  final String thumbnailAsset;
  final String deskripsi;
  final void Function()? delete;
  final void Function()? update;

  const AdminPostCard({
    Key? key,
    required this.type,
    required this.title,
    required this.period,
    required this.deskripsi,
    required this.thumbnailAsset,
    this.delete,
    this.update,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        margin: const EdgeInsets.only(top: 5, right: 30, left: 30, bottom: 15),
        elevation: 4,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: AssetImage(thumbnailAsset),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        type,
                        style: const TextStyle(
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          color: Color(0xFFF75600),
                        ),
                      ),
                      Text(
                        title,
                        style: const TextStyle(
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        period,
                        style: const TextStyle(
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        deskripsi,
                        style: const TextStyle(
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w200,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: update,
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Delete Post'),
                          content: Text(
                              'Are you sure you want to delete this post?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Tutup dialog
                              },
                              child: Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                // Tambahkan logika untuk menghapus post di sini
                                delete!();
                                Navigator.of(context).pop(); // Tutup dialog
                              },
                              child: Text('Delete'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
