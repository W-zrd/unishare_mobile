import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomepageCardd extends StatefulWidget {
  final String penyelenggara;
  final String nama_beasiswa;
  final String deadline;
  final void Function()? onTap;

  const HomepageCardd(
      {Key? key,
      required this.penyelenggara,
      required this.nama_beasiswa,
      required this.deadline,
      required this.onTap})
      : super(key: key);

  @override
  State<HomepageCardd> createState() => _HomepageCardState();
}

class _HomepageCardState extends State<HomepageCardd> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 180,
        height: 230,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x26252422),
              blurRadius: 15,
              offset: Offset(0, 3),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 150,
              height: 100,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/img/dazai.jpg'),
                    fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Center(
                child: Text(
                  widget.nama_beasiswa,
                  style: TextStyle(
                    color: Color(0xFF252422),
                    fontSize: 14,
                    fontFamily: 'Rubik',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 12, top: 5),
                  child: Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: Color.fromRGBO(64, 61, 57, 1),
                        size: 21,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 3),
                        child: Text(
                          widget.penyelenggara,
                          style: TextStyle(
                            color: Color(0xFF403D39),
                            fontSize: 12,
                            fontFamily: 'Rubik',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 12, top: 5),
                  child: Row(
                    children: [
                      Icon(
                        Icons.schedule,
                        color: Color.fromRGBO(64, 61, 57, 1),
                        size: 21,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 3),
                        child: Text(
                          textAlign: TextAlign.start,
                          widget.deadline,
                          style: TextStyle(
                            color: Color(0xFF403D39),
                            fontSize: 12,
                            fontFamily: 'Rubik',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
      onTap: widget.onTap,
    );
  }
}
