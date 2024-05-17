import 'package:flutter/material.dart';
import 'package:unishare/app/models/karirmodel.dart';
import 'package:unishare/app/modules/karir/form_daftar_karir.dart';
import 'package:unishare/app/widgets/card/description_card.dart';
import 'package:unishare/app/widgets/card/detail_top_card.dart';
import 'package:unishare/app/widgets/card/regulation_card.dart';

class DetailKarirRil extends StatefulWidget {
  final String karirID;
  final KarirPost karir;
  const DetailKarirRil({Key? key, required this.karirID, required this.karir})
      : super(key: key);

  @override
  _DetailKarirState createState() => _DetailKarirState();
}

class _DetailKarirState extends State<DetailKarirRil> {
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
            CardDetailTop(
              type: widget.karir.posisi,
              title: widget.karir.penyelenggara,
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
                      flex: 1,
                      child: TabBarView(
                        children: [
                          ListView(
                            children: [
                              DescriptionCard(
                                  description: widget.karir.deskripsi),
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
                            builder: (context) =>
                                DaftarKarir(karirID: widget.karirID),
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
        // floatingActionButton: Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     ElevatedButton(
        //       style: const ButtonStyle(
        //           backgroundColor:
        //               MaterialStatePropertyAll(Color.fromRGBO(247, 86, 0, 1)),
        //           padding: MaterialStatePropertyAll(EdgeInsets.only(
        //               left: 150, top: 20, right: 150, bottom: 20))),
        //       onPressed: () {
        //         Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //             builder: (context) => DaftarKarir(),
        //           ),
        //         );
        //       },
        //       child:
        //           const Text('Daftar', style: TextStyle(color: Colors.white)),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
