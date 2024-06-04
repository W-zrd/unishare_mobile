import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:unishare/app/modules/homescreen/home_screen.dart';
import 'package:unishare/app/modules/profil/controller/user_service.dart';
import 'package:unishare/app/modules/profil/controller/image_service.dart';
import 'package:unishare/app/modules/splashscreen/views/splash_screen.dart';

class ProfilPage extends StatefulWidget {
  final ProfileService? profileService;
  final ImageService? imageService;

  ProfilPage({this.profileService, this.imageService});
  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  late final ProfileService profileService;
  late final ImageService imageService;

  Map<String, dynamic>? userData;
  TextEditingController namaController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  String profileImageUrl = '';

  @override
  void initState() {
    super.initState();
    profileService = widget.profileService ?? ProfileService();
    imageService = widget.imageService ?? ImageService();
    _getUserData();
  }

  void _getUserData() async {
    Map<String, dynamic>? data = await profileService.getUserData();
    if (data != null) {
      setState(() {
        userData = data;
        namaController.text = userData?['nama'] ?? '';
        emailController.text = userData?['email'] ?? '';
        passwordController.text = userData?['password'] ?? '';
        alamatController.text = userData?['alamat'] ?? '';
        profileImageUrl = userData?['profile_picture'] ?? '';
      });
    }
  }

  Future<void> _updateProfilePicture() async {
    String? newImageUrl = await imageService.pickImageAndUpload();
    if (newImageUrl != null) {
      setState(() {
        profileImageUrl = newImageUrl;
      });
    }
  }

  Future<void> _updateUserData() async {
    try {
      Map<String, dynamic> userData = {
        'nama': namaController.text,
        'email': emailController.text,
        'password': passwordController.text,
        'alamat': alamatController.text,
      };
      await profileService.updateUserData(userData);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error updating user data: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          },
        ),
        title: const Text(
          'Profil',
          style: TextStyle(
            fontFamily: 'Rubik',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Show Snackbar',
            onPressed: () {
              FirebaseAuth _auth = FirebaseAuth.instance;
              _auth.signOut();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SplashScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: _updateProfilePicture,
              child: CircleAvatar(
                radius: 80,
                backgroundImage: profileImageUrl.isNotEmpty
                    ? NetworkImage(profileImageUrl)
                    : const AssetImage('assets/profile_picture.png')
                        as ImageProvider,
                child: profileImageUrl.isEmpty
                    ? const Icon(
                        Icons.account_circle,
                        size: 150,
                      )
                    : null,
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: namaController,
              decoration: const InputDecoration(labelText: 'Nama Lengkap'),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: alamatController,
              decoration: const InputDecoration(labelText: 'Alamat'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateUserData,
              child: const Text('Update'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
