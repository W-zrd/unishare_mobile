import 'package:flutter/material.dart';
import 'package:unishare/app/widgets/card/description_card.dart';
import 'package:unishare/app/widgets/card/detail_top_card.dart';
import 'package:unishare/app/widgets/card/regulation_card.dart';

class DetailKarir extends StatefulWidget {
  const DetailKarir({Key? key}) : super(key: key);

  @override
  _DetailKarirState createState() => _DetailKarirState();
}

class _DetailKarirState extends State<DetailKarir> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            'Detail Karir',
            style: TextStyle(
              fontFamily: 'Rubik',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
              width: 296,
              height: 180,
              margin:
                  const EdgeInsets.only(top: 5, right: 30, left: 30, bottom: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: const DecorationImage(
                  image: AssetImage('assets/img/onboarding.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const CardDetailTop(
              type: 'Computer Forensic Analyst',
              title: 'Virtual Talent Inc.',
              period: 'Registrasi: 12 Agust - 28 Sept 2023',
              thumbnailAsset: 'assets/img/unishare_splash.png',
              salary: '50.000.000',
              minimumWorkExperience: '1 year of work experience',
            ),
            Expanded(
              child: DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 30, left: 30),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      constraints: const BoxConstraints.expand(height: 40),
                      child: const TabBar(
                        indicatorColor: Color(0xFFF75600),
                        labelColor: Color(0xFFF75600),
                        unselectedLabelColor: Colors.black,
                        tabs: [
                          Tab(
                            child: Text(
                              'Deskripsi',
                              style: TextStyle(
                                fontFamily: 'Rubik',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Tab(
                            child: Text(
                              'Persyaratan',
                              style: TextStyle(
                                fontFamily: 'Rubik',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: TabBarView(
                        children: [
                          ListView(
                            children: const [
                              DescriptionCard(
                                  description:
                                      'Virtual Talent Indonesia Inc. telah secara aktif terlibat dalam percetakan. Kami membutuhkan staf keuangan untuk mendukung operasi penjualan kami yang berkembang pesat. Kandidat yang terpilih dapat menjalani on-the-job training dengan Manajer Keuangan.'),
                            ],
                          ),
                          ListView(
                            children: const [
                              RegulationCard(
                                  regulation:
                                      '- Diploma ke atas dalam bidang akuntansi dan bidang terkait. \n- 2 tahun pengalaman kerja yang relevan lebih disukai, lulusan  baru yang didorong akan dipertimbangkan.'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
