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
  DateTime? _annnouncementDate;

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
          'Edit Beasiswa',
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
            const Text(
              'Tanggal Pengumuman',
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
                          _annnouncementDate = pickedDate;
                        });
                      }
                    },
                    icon: Icon(Icons.calendar_today),
                    label: Text(
                      _annnouncementDate != null
                          ? '${_annnouncementDate!.day}/${_annnouncementDate!.month}/${_annnouncementDate!.year}'
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
                  BeasiswaPost updatedBeasiswaPost = BeasiswaPost(
                    judul: _judulController.text,
                    penyelenggara: _penyelenggaraController.text,
                    urlBeasiswa: _urlController.text,
                    img: "/img/Wzrd.jpg",
                    jenis: jenisValue,
                    startDate:
                        widget.beasiswaPost['startDate'] ?? Timestamp.now(),
                    endDate: widget.beasiswaPost['endDate'] ?? Timestamp.now(),
                    deskripsi: _deskripsiController.text,
                    announcementDate: widget.beasiswaPost['announcementDate'],
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
