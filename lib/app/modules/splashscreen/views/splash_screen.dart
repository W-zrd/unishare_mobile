import 'package:flutter/material.dart';
import 'package:unishare/app/modules/auth/gate.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Future.delayed(const Duration(seconds: 3)), // Menunggu 5 detik
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // Setelah menunggu 5 detik, pindah ke layar onboarding
            return const AuthGate();
          } else {
            // Selama menunggu, tampilkan tampilan splash screen
            return Stack(
              children: [
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      color: Colors.black,
                      height: MediaQuery.of(context).size.height / 1.8,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  const TextSpan(
                                    text: 'Uni',
                                    style: TextStyle(
                                      fontSize: 48.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Share',
                                    style: TextStyle(
                                      fontSize: 48.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.orange.shade900,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            Text(
                              'Unlock Your Opportunities\nBoost Your Career',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.grey.shade100,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: CustomGrayLayer(),
                  ),
                ),
                const Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: CustomOrangeLayer(),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 1.1,
                    child: Image.asset(
                      'assets/img/unishare_splash.png',
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

class CustomOrangeLayer extends StatelessWidget {
  const CustomOrangeLayer({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CustomClipPath(), // Apply the custom clip path
      child: Container(
        height: MediaQuery.of(context).size.height / 1.5,
        decoration: BoxDecoration(
          color: Colors.orange.shade900,
        ),
      ),
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    // Adjust border offsetr
    const double borderWidth = 2.0;

    // Move to the starting point of the curve
    path.moveTo(0.0, size.height * 0.35);

    // Define control points for quadratic Bezier curve
    double controlPointX = size.width / 2;
    double controlPointY = 1; // Control point at the top-middle
    double endPointX = size.width;
    double endPointY = size.height * 0.35;

    // Draw the quadratic Bezier curve to the top-right
    path.quadraticBezierTo(controlPointX, controlPointY, endPointX, endPointY);

    // Draw a line to the bottom-right corner
    path.lineTo(size.width, size.height);

    // Draw a line to the bottom-left corner
    path.lineTo(0.0, size.height);
    path.lineTo(0.0, 0.0); // Close the path

    path.close();

    // Create a bordered path
    final borderedPath = Path();
    borderedPath.addPath(path, Offset.zero);
    borderedPath.addPath(path, const Offset(borderWidth, borderWidth));

    return borderedPath;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class CustomGrayLayer extends StatelessWidget {
  const CustomGrayLayer({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CustomClipPath(), // Apply the custom clip path
      child: Container(
        height: MediaQuery.of(context).size.height / 1.45,
        decoration: BoxDecoration(
          color: Colors.grey.shade400,
        ),
      ),
    );
  }
}
