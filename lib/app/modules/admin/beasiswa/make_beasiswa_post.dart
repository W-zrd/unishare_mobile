import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:unishare/app/controller/beasiswa_controller.dart';
import 'package:unishare/app/models/beasiswa_model.dart';

class MakeBeasiswaPost extends StatefulWidget {
  MakeBeasiswaPost({Key? key}) : super(key: key);

  @override
  State<MakeBeasiswaPost> createState() => _MakeBeasiswaPostState();
}

class _MakeBeasiswaPostState extends State<MakeBeasiswaPost> {
  TextEditingController _judulController = TextEditingController();
  TextEditingController _penyelenggaraController = TextEditingController();
  TextEditingController _urlController = TextEditingController();
  TextEditingController _deskripsiController = TextEditingController();

  String jenisValue = 'Swasta';
  DateTime? _endDate;

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
              key: Key('judul_field'),
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
              key: Key('penyelenggara_field'),
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
              key: Key('url_field'),
              controller: _urlController,
            ),
            const SizedBox(height: 20),

            //deskripsi
            const Text(
              'Deskripsi',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextFormField(
              key: Key('deskripsi_field'),
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

            //banner acara
            const Text(
              'Banner Acara',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            //file input
            const SizedBox(height: 20),

            //enddate
            const Text(
              'Tanggal Selesai',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextButton.icon(
                    key: Key("date-picker"),
                    onPressed: () async {
                      final DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          _endDate = pickedDate;
                        });
                      }
                    },
                    icon: Icon(Icons.calendar_today),
                    label: Text(
                      _endDate != null
                          ? '${_endDate!.day}/${_endDate!.month}/${_endDate!.year}'
                          : 'Pilih Tanggal',
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Future.delayed(Duration.zero, () {
                  BeasiswaPost beasiswaPost = BeasiswaPost(
                    judul: _judulController.text,
                    penyelenggara: _penyelenggaraController.text,
                    urlBeasiswa: _urlController.text,
                    img: "/img/Wzrd.jpg",
                    jenis: jenisValue,
                    deskripsi: _deskripsiController.text,
                    startDate: Timestamp.now(),
                    endDate: Timestamp.fromDate(_endDate!),
                  );
                  BeasiswaService.addToFirestore(context, beasiswaPost);
                });
              },
              child: const Text('Unggah'),
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
