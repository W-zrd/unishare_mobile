import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:unishare/app/controller/acara_controller.dart';
import 'package:unishare/app/models/acara_kemahasiswaan.dart';
import 'package:unishare/app/widgets/card/post_card.dart';

class AllAcaraPage extends StatefulWidget {
  AllAcaraPage({super.key});

  @override
  _AllAcaraPageState createState() => _AllAcaraPageState();
}

class _AllAcaraPageState extends State<AllAcaraPage> {
  final PageController _pageController = PageController();
  final AcaraService _acaraService = AcaraService();

  int _currentPage = 0;
  final int _cardsPerPage = 5;

  Widget _buildAcaraList(BuildContext context) {
    return StreamBuilder(
        stream: _acaraService.getAcaras(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('Loading...');
          }
          return ListView(
            children: snapshot.data!.docs
                .map((doc) => _buildAcaraItem(doc, context))
                .toList(),
          );
        });
  }

  Widget _buildAcaraItem(DocumentSnapshot doc, BuildContext context) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    Timestamp startDate = data['startDate'];
    String startDateString = startDate.toDate().day.toString() +
        "-" +
        startDate.toDate().month.toString() +
        "-" +
        startDate.toDate().year.toString();

    Timestamp endDate = data['endDate'];
    String endDateString = endDate.toDate().day.toString() +
        "-" +
        endDate.toDate().month.toString() +
        "-" +
        endDate.toDate().year.toString();
    return PostCard(
      type: data['kategori'],
      title: data['judul'],
      period: 'Registrasi: ' + startDateString + ' sampai ' + endDateString,
      location: data['lokasi'],
      thumbnailAsset: 'assets/img/unishare_splash.png',
    );
  }

  // final List<Widget> _cards = const [
  //   PostCard(
  //     type: 'INI WORKSHOP',
  //     title: 'Virtual Talent Inc.',
  //     period: 'Registrasi: 12 Agust - 28 Sept 2023',
  //     location: 'Lokasi: Remote from Home',
  //     thumbnailAsset: 'assets/img/unishare_splash.png',
  //   ),
  //   PostCard(
  //     type: 'Full Stack Developer',
  //     title: 'PT. Unity Dev Indonesia',
  //     period: 'Registrasi: 12 Des - 30 Jan 2024',
  //     location: 'Lembang, Bandung',
  //     thumbnailAsset: 'assets/img/unishare_splash.png',
  //   ),
  //   // Add more PostCard widgets as needed
  // ];

  @override
  Widget build(BuildContext context) {
    //yang di comment ini pagination

    // return Column(
    //   children: [
    //     Expanded(
    //       //pagination
    //       child: PageView.builder(
    //         controller: _pageController,
    //         itemCount: (_cards.length / _cardsPerPage).ceil(),
    //         onPageChanged: (index) {
    //           setState(() {
    //             _currentPage = index;
    //           });
    //         },
    //         itemBuilder: (context, index) {
    //           final startIndex = index * _cardsPerPage;
    //           final endIndex = (startIndex + _cardsPerPage < _cards.length)
    //               ? startIndex + _cardsPerPage
    //               : _cards.length;
    //           return ListView(
    //             children: _cards.sublist(startIndex, endIndex),
    //           );
    //         },
    //       ),
    //     ),
    //     Row(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: List.generate(
    //         (_cards.length / _cardsPerPage).ceil(),
    //         (index) => GestureDetector(
    //           onTap: () {
    //             _pageController.animateToPage(
    //               index,
    //               duration: const Duration(milliseconds: 300),
    //               curve: Curves.easeInOut,
    //             );
    //           },
    //           child: Container(
    //             padding: const EdgeInsets.all(8),
    //             margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
    //             decoration: BoxDecoration(
    //               color: _currentPage == index
    //                   ? const Color(0xFFF75600)
    //                   : Colors.grey,
    //               borderRadius: BorderRadius.circular(4),
    //             ),
    //             child: Text(
    //               '${index + 1}',
    //               style: const TextStyle(
    //                 color: Colors.white,
    //                 fontSize: 16,
    //               ),
    //             ),
    //           ),
    //         ),
    //       ),
    //     ),
    //   ],
    // );

    return Scaffold(
        body: Column(
      children: [Expanded(child: _buildAcaraList(context))],
    ));
  }
}
