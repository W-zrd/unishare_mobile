import 'package:flutter/material.dart';
import 'package:unishare/app/modules/homescreen/home_screen.dart';

class ProfilPage extends StatelessWidget {
  final TextEditingController namaController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController alamatController;

  const ProfilPage({
    Key? key,
    required this.namaController,
    required this.emailController,
    required this.passwordController,
    required this.alamatController,
  }) : super(key: key);

  factory ProfilPage.withDefaults() {
    return ProfilPage(
      namaController: TextEditingController(text: 'John Doe'),
      emailController: TextEditingController(text: 'john.doe@example.com'),
      passwordController: TextEditingController(),
      alamatController: TextEditingController(text: '123 Main Street'),
    );
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage(
                  'assets/profile_picture.png'), // Provide your profile picture asset path
              child: Icon(
                Icons.account_circle,
                size: 150,
              ),
            ),
            const SizedBox(
                height: 20), // Spacer between profile picture and text fields
            TextFormField(
              controller: namaController,
              decoration: InputDecoration(labelText: 'Nama Lengkap'),
            ),
            const SizedBox(height: 10), // Spacer between text fields
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 10), // Spacer between text fields
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 10), // Spacer between text fields
            TextFormField(
              controller: alamatController,
              decoration: InputDecoration(labelText: 'Alamat'),
            ),
          ],
        ),
      ),
    );
  }
}
