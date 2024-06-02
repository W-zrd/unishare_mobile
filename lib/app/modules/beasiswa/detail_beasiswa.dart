import 'package:flutter/material.dart';
import 'package:unishare/app/models/beasiswa_model.dart';
import 'package:unishare/app/modules/beasiswa/form_daftar_beasiswa.dart';
import 'package:unishare/app/widgets/card/description_card.dart';
import 'package:unishare/app/widgets/card/detail_top_card.dart';
import 'package:unishare/app/widgets/card/regulation_card.dart';

class DetailBeasiswa extends StatefulWidget {
  final String? beasiswaID;
  final BeasiswaPost? beasiswaPost;

  const DetailBeasiswa({Key? key, this.beasiswaID, this.beasiswaPost})
      : super(key: key);

  @override
  _DetailBeasiswaState createState() => _DetailBeasiswaState();
}

class _DetailBeasiswaState extends State<DetailBeasiswa> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Detail Beasiswa',
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
                image: DecorationImage(
                  image: AssetImage('assets/img/onboarding.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            CardDetailTop(
              type: widget.beasiswaPost?.jenis ?? '',
              title: widget.beasiswaPost?.judul ?? '',
              period:
                  'Registrasi: ${widget.beasiswaPost?.startDate?.toDate().day}/${widget.beasiswaPost?.startDate?.toDate().month} - ${widget.beasiswaPost?.endDate?.toDate().day}/${widget.beasiswaPost?.endDate?.toDate().month}/${widget.beasiswaPost?.endDate?.toDate().year}',
              thumbnailAsset: 'assets/img/unishare_splash.png',
              salary: '', // Replace with relevant info or remove
              minimumWorkExperience: '', // Replace with relevant info or remove
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
                      flex: 1,
                      child: TabBarView(
                        children: [
                          ListView(
                            children: [
                              DescriptionCard(
                                  description:
                                      widget.beasiswaPost?.deskripsi ?? ''),
                            ],
                          ),
                          ListView(
                            children: [
                              RegulationCard(
                                  regulation:
                                      widget.beasiswaPost?.urlBeasiswa ??
                                          'Persyaratan tidak tersedia'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                              Color.fromRGBO(247, 86, 0, 1)),
                          padding: MaterialStatePropertyAll(EdgeInsets.only(
                              left: 150, top: 20, right: 150, bottom: 20))),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DaftarBeasiswa(
                                beasiswaID: widget.beasiswaID ?? ''),
                          ),
                        );
                      },
                      child: const Text('Daftar',
                          style: TextStyle(color: Colors.white)),
                    ),
                    const SizedBox(height: 10),
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
