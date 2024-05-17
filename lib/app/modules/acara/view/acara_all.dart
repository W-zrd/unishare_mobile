import 'package:flutter/material.dart';
import 'package:unishare/app/widgets/card/post_card.dart';

class AllAcaraPage extends StatefulWidget {
  const AllAcaraPage({super.key});

  @override
  _AllAcaraPageState createState() => _AllAcaraPageState();
}

class _AllAcaraPageState extends State<AllAcaraPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final int _cardsPerPage = 5;

  final List<Widget> _cards = const [
    PostCard(
      type: 'INI WORKSHOP',
      title: 'Virtual Talent Inc.',
      period: 'Registrasi: 12 Agust - 28 Sept 2023',
      location: 'Lokasi: Remote from Home',
      thumbnailAsset: 'assets/img/unishare_splash.png',
    ),
    PostCard(
      type: 'Full Stack Developer',
      title: 'PT. Unity Dev Indonesia',
      period: 'Registrasi: 12 Des - 30 Jan 2024',
      location: 'Lembang, Bandung',
      thumbnailAsset: 'assets/img/unishare_splash.png',
    ),
    PostCard(
      type: 'Network Engineer',
      title: 'UniShare Indo',
      period: 'Registrasi: 12 Agust - 28 Sept 2023',
      location: 'Lokasi: Remote from Home',
      thumbnailAsset: 'assets/img/unishare_splash.png',
    ),
    PostCard(
      type: 'Penetration Tester',
      title: 'PT. Unknown',
      period: 'Registrasi: 12 Des - 30 Jan 2024',
      location: 'Lembang, Bandung',
      thumbnailAsset: 'assets/img/unishare_splash.png',
    ),
    PostCard(
      type: 'Database Engineer',
      title: 'Virtual Talent Inc.',
      period: 'Registrasi: 12 Agust - 28 Sept 2023',
      location: 'Lokasi: Remote from Home',
      thumbnailAsset: 'assets/img/unishare_splash.png',
    ),
    PostCard(
      type: 'Devops Engineer',
      title: 'UniShare Indo',
      period: 'Registrasi: 12 Des - 30 Jan 2024',
      location: 'Lembang, Bandung',
      thumbnailAsset: 'assets/img/unishare_splash.png',
    ),
    PostCard(
      type: 'Cyber Security',
      title: 'Tokopedia',
      period: 'Registrasi: 12 Des - 30 Jan 2024',
      location: 'Lembang, Bandung',
      thumbnailAsset: 'assets/img/unishare_splash.png',
    ),
    // Add more PostCard widgets as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            itemCount: (_cards.length / _cardsPerPage).ceil(),
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              final startIndex = index * _cardsPerPage;
              final endIndex = (startIndex + _cardsPerPage < _cards.length)
                  ? startIndex + _cardsPerPage
                  : _cards.length;
              return ListView(
                children: _cards.sublist(startIndex, endIndex),
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            (_cards.length / _cardsPerPage).ceil(),
            (index) => GestureDetector(
              onTap: () {
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                decoration: BoxDecoration(
                  color: _currentPage == index
                      ? const Color(0xFFF75600)
                      : Colors.grey,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '${index + 1}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
