import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Menubar extends StatefulWidget {
  const Menubar({super.key});

  @override
  State<Menubar> createState() {
    return _MenubarState();
  }
}

class _MenubarState extends State<Menubar> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      color: Colors.white,
      width: screenWidth,
      height: 64,
      alignment: Alignment.center,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Column(
              children: [
                IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset('assets/icons/home-outlined.svg')),
                const Text(
                  "Home",
                  style: TextStyle(
                    fontSize: 11,
                    fontFamily: 'Rubik',
                    fontWeight: FontWeight.w400,
                    height: -0.5,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Column(
              children: [
                IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset('assets/icons/karir-outlined.svg')),
                const Text(
                  "Karir",
                  style: TextStyle(
                    fontSize: 11,
                    fontFamily: 'Rubik',
                    fontWeight: FontWeight.w400,
                    height: -0.5,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Column(
              children: [
                IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset('assets/icons/acara-outlined.svg')),
                const Text(
                  "Acara",
                  style: TextStyle(
                    fontSize: 11,
                    fontFamily: 'Rubik',
                    fontWeight: FontWeight.w400,
                    height: -0.5,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Column(
              children: [
                IconButton(
                    onPressed: () {},
                    icon:
                        SvgPicture.asset('assets/icons/profile-outlined.svg')),
                const Text(
                  "Profil",
                  style: TextStyle(
                    fontSize: 11,
                    fontFamily: 'Rubik',
                    fontWeight: FontWeight.w400,
                    height: -0.4,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
