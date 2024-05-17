import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:unishare/app/controller/beasiswa_controller.dart';
import 'package:unishare/app/models/beasiswa_model.dart';

import 'beasiswa_post_admin.dart';

class EditBeasiswaPost extends StatefulWidget {
  final DocumentSnapshot beasiswaPost;
  EditBeasiswaPost({Key? key, required this.beasiswaPost}) : super(key: key);

  @override
  State<EditBeasiswaPost> createState() => _EditBeasiswaPostState();
}

class _EditBeasiswaPostState extends State<EditBeasiswaPost> {
  TextEditingController _judulController = TextEditingController();
  TextEditingController _penyelenggaraController = TextEditingController();
  TextEditingController _urlController = TextEditingController();
  TextEditingController _deskripsiController = TextEditingController();

  String jenisValue = 'Swasta';
  DateTime? _endDate;

  @override
  void initState() {
    super.initState();
    _judulController.text = widget.beasiswaPost['judul'] ?? '';
    _penyelenggaraController.text = widget.beasiswaPost['penyelenggara'] ?? '';
    _urlController.text = widget.beasiswaPost['urlBeasiswa'] ?? '';
    _deskripsiController.text = widget.beasiswaPost['deskripsi'] ?? '';
    jenisValue = widget.beasiswaPost['jenis'] ?? 'Swasta';
    final endDate = widget.beasiswaPost['endDate'];
    if (endDate is Timestamp) {
      _endDate = endDate.toDate();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Buat Beasiswa',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF252422),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15,
            ),

            // judul
            const Text(
              'Judul Beasiswa',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextFormField(
              controller: _judulController,
            ),
            const SizedBox(height: 20),

            //penyelenggara
            const Text(
              'Penyelenggara',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextFormField(
              controller: _penyelenggaraController,
            ),
            const SizedBox(height: 20),

            //link acara
            const Text(
              'Link Pendaftaran',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextFormField(
              controller: _urlController,
            ),
            const SizedBox(height: 20),

            const Text(
              'Deskripsi',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextFormField(
              controller: _deskripsiController,
            ),
            const SizedBox(height: 20),

            //tema
            const Text(
              'Jenis Beasiswa',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            MyDropdownButton(
              dropdownValue: 'Swasta',
              items: const [
                'Swasta',
                'Pemerintah',
              ],
              onChanged: (newValue) {
                setState(() {
                  jenisValue = newValue!;
                });
              },
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Future.delayed(Duration.zero, () {
                  BeasiswaPost updatedBeasiswaPost = BeasiswaPost(
                    judul: _judulController.text,
                    penyelenggara: _penyelenggaraController.text,
                    urlBeasiswa: _urlController.text,
                    img: "/img/Wzrd.jpg",
                    jenis: jenisValue,
                    startDate: widget.beasiswaPost['startDate'] ?? Timestamp.now(),
                    endDate: widget.beasiswaPost['endDate'] ?? Timestamp.now(),
                    deskripsi: _deskripsiController.text,
                  );
                  BeasiswaService.updateBeasiswa(
                      context, updatedBeasiswaPost, widget.beasiswaPost.id);
                });
              },
              child: const Text('Update'),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class MyDropdownButton extends StatelessWidget {
  final String dropdownValue;
  final List<String> items;
  final ValueChanged<String?>? onChanged;

  MyDropdownButton({
    required this.dropdownValue,
    required this.items,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      isExpanded: true,
      value: dropdownValue,
      onChanged: onChanged,
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
