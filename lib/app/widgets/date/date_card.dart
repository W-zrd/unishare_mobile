import 'package:flutter/material.dart';

class DateCard extends StatelessWidget {
  final String penyelenggara;
  final String kategori;
  final String tanggal;
  const DateCard({
    Key? key,
    required this.penyelenggara,
    required this.kategori,
    required this.tanggal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          const SizedBox(width: 8),
          Expanded(
            flex: 4,
            child: Card(
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
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Announcement $kategori by $penyelenggara",
                        style: const TextStyle(
                          fontFamily: 'Rubik',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFFF75600),
                        ),
                      ),
                      Text(
                        tanggal,
                        style: const TextStyle(
                          fontFamily: 'Rubik',
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
