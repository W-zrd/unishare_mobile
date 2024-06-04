import 'package:firebase_auth/firebase_auth.dart';
import 'package:unishare/app/controller/database_helper.dart';
import 'package:unishare/app/modules/admin/acara/acara_post_admin.dart';
import 'package:flutter/material.dart';
import 'package:unishare/app/modules/admin/beasiswa/beasiswa_post_admin.dart';
import 'package:unishare/app/modules/admin/karir/karirpostadmin.dart';
import 'package:unishare/app/modules/auth/login/views/login_screen.dart';
import 'package:unishare/app/modules/onboarding/views/onboarding_screen.dart';
import 'package:unishare/app/modules/splashscreen/views/splash_screen.dart';

class DaDrawer extends StatelessWidget {
  const DaDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color(0xFF252422),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              //logo
              const DrawerHeader(
                child: Center(
                    child: Text(
                  'Unishare',
                  style: TextStyle(fontSize: 50, color: Colors.white),
                )),
              ),

              //home list tile
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: ListTile(
                  title:
                      Text('Dashboard', style: TextStyle(color: Colors.white)),
                  leading: Icon(Icons.home),
                  onTap: () {},
                ),
              ),

              //settings list tile
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: ListTile(
                  title: Text('Karir', style: TextStyle(color: Colors.white)),
                  leading: Icon(Icons.settings),
                  onTap: () {
                    Navigator.pop(context);

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => KarirAdmin(),
                        ));
                  },
                ),
              ),
              //settings list tile
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: ListTile(
                  title: Text('Acara', style: TextStyle(color: Colors.white)),
                  leading: Icon(Icons.settings),
                  onTap: () {
                    Navigator.pop(context);

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AcaraAdmin(),
                        ));
                  },
                ),
              ),
              //settings list tile
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: ListTile(
                  key: Key('beasiswa-button'),
                  title: const Text('Beasiswa',
                      style: TextStyle(color: Colors.white)),
                  leading: const Icon(Icons.settings),
                  onTap: () {
                    Navigator.pop(context);

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BeasiswaAdmin(),
                        ));
                  },
                ),
              ),
            ],
          ),

          //logout list tile
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: ListTile(
              title: const Text(
                'L O G O U T',
                style: TextStyle(color: Colors.red),
              ),
              leading: const Icon(
                Icons.logout,
                color: Colors.red,
              ),
              onTap: () async {
                FirebaseAuth _auth = FirebaseAuth.instance;
                await DatabaseHelper().deleteDatabase();
                _auth.signOut();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SplashScreen(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
