import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:unishare/app/controller/acara_submission_controller.dart';
import 'package:unishare/app/models/acara_submission_model.dart';
import 'package:unishare/app/modules/acara/view/acara_page.dart';
import 'package:unishare/app/modules/homescreen/home_screen.dart';

class DaftarAcara extends StatefulWidget {
  final String acaraID;

  const DaftarAcara({Key? key, required this.acaraID}) : super(key: key);

  @override
  _DaftarAcaraState createState() => _DaftarAcaraState();
}

class _DaftarAcaraState extends State<DaftarAcara> {
  TextEditingController namaController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nomorHpController = TextEditingController();
  TextEditingController universitasController = TextEditingController();
  TextEditingController fakultasController = TextEditingController();
  TextEditingController jurusanController = TextEditingController();

  @override
  void initState() {
    super.initState();
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
              MaterialPageRoute(builder: (context) => const AcaraPage()),
            );
          },
        ),
        title: const Text(
          'Isi Data',
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
                controller: nomorHpController,
                decoration: const InputDecoration(labelText: 'Nomor HP'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: universitasController,
                decoration: const InputDecoration(labelText: 'Universitas'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: fakultasController,
                decoration: const InputDecoration(labelText: 'Fakultas'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: jurusanController,
                decoration: const InputDecoration(labelText: 'Jurusan'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(Color.fromRGBO(247, 86, 0, 1)),
                  padding: MaterialStatePropertyAll(EdgeInsets.only(
                      left: 150, top: 20, right: 150, bottom: 20)),
                ),
                onPressed: () {
                  // Defer the validation until after the build method
                  Future.delayed(Duration.zero, () {
                    AcaraSubmission acaraSubmission = AcaraSubmission(
                      nama: namaController.text,
                      email: emailController.text,
                      nomorHp: nomorHpController.text,
                      jurusan: jurusanController.text,
                      fakultas: fakultasController.text,
                      universitas: universitasController.text,
                      acaraID: widget.acaraID,
                      userID: FirebaseAuth.instance.currentUser!.uid,
                    );
                    AcaraSubmissionService.addToFirestore(context, acaraSubmission);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Data pendaftaran berhasil dikirim!')),
                    );
                    Future.delayed(const Duration(seconds: 1), () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const HomeScreen()),
                      );
                    });
                  });
                },
                child:
                    const Text('Daftar', style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}