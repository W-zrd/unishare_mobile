import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unishare/app/modules/admin/karir/karircontroller.dart';
import 'package:unishare/app/modules/admin/karir/karirmodel.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class UpdateKarirPost extends StatefulWidget {
  final DocumentSnapshot karirPost;
  UpdateKarirPost({Key? key, required this.karirPost}) : super(key: key);

  @override
  _UpdateKarirPostState createState() => _UpdateKarirPostState();
}

class _UpdateKarirPostState extends State<UpdateKarirPost> {
  TextEditingController _posisiController = TextEditingController();
  TextEditingController _lokasiController = TextEditingController();
  TextEditingController _urlController = TextEditingController();
  TextEditingController _deskripsiController = TextEditingController();
  TextEditingController _penyelenggaraController = TextEditingController();

  String temaValue = 'Teknologi';
  String kategoriValue = 'Lowongan Kerja';

  @override
  void initState() {
    super.initState();
    // Set initial values for text fields
    _posisiController.text = widget.karirPost['posisi'];
    _penyelenggaraController.text = widget.karirPost['penyelenggara'];
    _lokasiController.text = widget.karirPost['lokasi'];
    _urlController.text = widget.karirPost['urlKarir'];
    _deskripsiController.text = widget.karirPost['deskripsi'];
    temaValue = widget.karirPost['tema'];
    kategoriValue = widget.karirPost['kategori'];
  }

  Future<void> _openFilePicker(BuildContext context) async {
    try {
      final result = await FilePicker.platform.pickFiles();
      if (result != null) {
        final filePath = result.files.single.path;
      }
    } catch (e) {
      print('Error while picking the file: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Update Karir',
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
            const Text(
              'Posisi Karir',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextFormField(
              controller: _posisiController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Posisi tidak boleh kosong';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            const Text(
              'Penyelenggara',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextFormField(
              controller: _penyelenggaraController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Penyelenggara tidak boleh kosong';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            const Text(
              'Lokasi',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextFormField(
              controller: _lokasiController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Lokasi tidak boleh kosong';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            const Text(
              'Link Karir',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextFormField(
              controller: _urlController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Link Acara tidak boleh kosong';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            const Text(
              'Tema',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            MyDropdownButton(
              dropdownValue: temaValue,
              items: const [
                'Teknologi',
                'Sains',
                'Bisnis',
                'Desain',
                'Fotografi',
                'Manajemen'
              ],
              onChanged: (newValue) {
                setState(() {
                  temaValue = newValue!;
                });
              },
            ),
            const SizedBox(height: 20),
            const Text(
              'Kategori',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            MyDropdownButton(
              dropdownValue: kategoriValue,
              items: const ['Lowongan Kerja', 'Magang'],
              onChanged: (newValue) {
                setState(() {
                  kategoriValue = newValue!;
                });
              },
            ),
            const SizedBox(height: 20),
            const Text(
              'Deskripsi Karir',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextFormField(
              controller: _deskripsiController,
              maxLines: null, // Allow for multi-line input
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Color.fromRGBO(247, 86, 0, 1)),
                    padding: MaterialStatePropertyAll(EdgeInsets.only(
                        left: 150, top: 20, right: 150, bottom: 20))),
                onPressed: () {
                  Future.delayed(Duration.zero, () {
                    KarirPost updatedKarirPost = KarirPost(
                      tema: temaValue,
                      kategori: kategoriValue,
                      posisi: _posisiController.text,
                      penyelenggara: _penyelenggaraController.text,
                      urlKarir: _urlController.text,
                      lokasi: _lokasiController.text,
                      img: "/img/Wzrd.jpg",
                      deskripsi: _deskripsiController.text,
                      startDate: widget.karirPost['startDate'],
                      endDate: widget.karirPost['endDate'],
                    );
                    KarirService.updateKarir(
                        context, updatedKarirPost, widget.karirPost.id);
                  });
                },
                child: const Text('Update',
                    style: TextStyle(color: Colors.black87)),
              ),
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
