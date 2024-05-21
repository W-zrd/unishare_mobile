import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:unishare/app/controller/karir_submission_controller.dart';
import 'package:unishare/app/models/karir_submission_model.dart';
import 'package:unishare/app/modules/homescreen/home_screen.dart';
import 'package:unishare/app/modules/karir/detail_karir_ril.dart';
import 'package:unishare/app/modules/karir/karir_page.dart';
import 'package:unishare/app/widgets/file_picker.dart';

class DaftarKarir extends StatefulWidget {
  final String karirID;

  const DaftarKarir({Key? key, required this.karirID}) : super(key: key);

  @override
  _DaftarKarirState createState() => _DaftarKarirState();
}

class _DaftarKarirState extends State<DaftarKarir> {
  TextEditingController namaController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nomorHpController = TextEditingController();
  TextEditingController alamatKtpController = TextEditingController();
  TextEditingController alamatDomisiliController = TextEditingController();
  TextEditingController linkedinController = TextEditingController();
  TextEditingController universitasController = TextEditingController();
  TextEditingController fakultasController = TextEditingController();
  TextEditingController jurusanController = TextEditingController();
  String? cv;
  String? motivletter;

  @override
  void initState() {
    super.initState();
  }

  void _handleCvSelected(String? url) {
    setState(() {
      cv = url;
    });
  }

  void _handleMotivletterSelected(String? url) {
    setState(() {
      motivletter = url;
    });
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
              MaterialPageRoute(builder: (context) => const KarirPage()),
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
                decoration: InputDecoration(labelText: 'Nama Lengkap'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: nomorHpController,
                decoration: InputDecoration(labelText: 'Nomor HP'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: alamatKtpController,
                decoration: InputDecoration(labelText: 'Alamat KTP'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: alamatDomisiliController,
                decoration: InputDecoration(labelText: 'Alamat Domisili'),
              ),
              const SizedBox(height: 10),
              FileInputWidget(
                fileType: 'CV',
                onSaveToDatabase: _handleCvSelected,
              ),
              const SizedBox(height: 10),
              FileInputWidget(
                fileType: 'Motivation Letter',
                onSaveToDatabase: _handleMotivletterSelected,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: linkedinController,
                decoration: InputDecoration(labelText: 'LinkedIN'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: universitasController,
                decoration: InputDecoration(labelText: 'Universitas'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: fakultasController,
                decoration: InputDecoration(labelText: 'Fakultas'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: jurusanController,
                decoration: InputDecoration(labelText: 'Jurusan'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor:
                    MaterialStatePropertyAll(Color.fromRGBO(247, 86, 0, 1)),
                    padding: MaterialStatePropertyAll(EdgeInsets.only(
                        left: 150, top: 20, right: 150, bottom: 20))),
                onPressed: () {
                  // Defer the validation until after the build method
                  Future.delayed(Duration.zero, () {
                    if (cv == null || motivletter == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please select CV and Motivation Letter')),
                      );
                      return;
                    }

                    KarirSubmission karirSubmission = KarirSubmission(
                      nama: namaController.text,
                      email: emailController.text,
                      nomorHp: nomorHpController.text,
                      alamatKtp: alamatKtpController.text,
                      alamatDomisili: alamatDomisiliController.text,
                      cv: cv!,
                      motivLetter: motivletter!,
                      linkedin: linkedinController.text,
                      universitas: universitasController.text,
                      fakultas: fakultasController.text,
                      jurusan: jurusanController.text,
                      karirID: widget.karirID,
                      userID: FirebaseAuth.instance.currentUser!.uid,
                    );
                    KarirSubmissionService.addToFirestore(context, karirSubmission);
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