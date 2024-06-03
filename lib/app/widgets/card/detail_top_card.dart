import 'package:flutter/material.dart';

class CardDetailTop extends StatelessWidget {
  final String type;
  final String title;
  final String period;
  final String thumbnailAsset;
  final String salary;
  final String minimumWorkExperience;
  const CardDetailTop({
    Key? key,
    required this.type,
    required this.title,
    required this.period,
    required this.thumbnailAsset,
    required this.salary,
    required this.minimumWorkExperience,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                type,
                style: const TextStyle(
                  fontFamily: 'Rubik',
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 6),
              Row(
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
                          title,
                          style: const TextStyle(
                            fontFamily: 'Rubik',
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          period,
                          style: const TextStyle(
                            fontFamily: 'Rubik',
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Divider(),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Informasi',
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            const Icon(Icons.monetization_on_rounded),
                            Text(
                              salary,
                              style: const TextStyle(
                                fontFamily: 'Rubik',
                                fontWeight: FontWeight.normal,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(width: 20),
                            const Icon(Icons.info_outline),
                            Text(
                              minimumWorkExperience,
                              style: const TextStyle(
                                fontFamily: 'Rubik',
                                fontWeight: FontWeight.normal,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
