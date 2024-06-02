import 'package:flutter/material.dart';

class PostCardAcara extends StatelessWidget {
  final String? type;
  final String? title;
  final String? period;
  final String thumbnailAsset;
  final String? location;
  final String? announcementDate;
  final void Function()? onTap;

  const PostCardAcara({
    super.key,
    required this.type,
    required this.title,
    required this.period,
    required this.location,
    required this.thumbnailAsset,
    required this.announcementDate,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
                      image: thumbnailAsset.isNotEmpty
                          ? AssetImage(thumbnailAsset)
                          : const AssetImage('assets/img/dazai.jpg'),
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
                        type!,
                        style: const TextStyle(
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          color: Color(0xFFF75600),
                        ),
                      ),
                      Text(
                        title!,
                        style: const TextStyle(
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        period!,
                        style: const TextStyle(
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        location!,
                        style: const TextStyle(
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w200,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        announcementDate!,
                        style: const TextStyle(
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}