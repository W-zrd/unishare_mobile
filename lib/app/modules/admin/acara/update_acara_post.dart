import 'package:unishare/app/controller/acara_controller.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unishare/app/models/acara_kemahasiswaan.dart';
import 'package:unishare/app/widgets/file_picker.dart';

class UpdateAcaraPost extends StatefulWidget {
  final DocumentSnapshot acaraPost;
  UpdateAcaraPost({super.key, required this.acaraPost});

  @override
  _MakeAcaraPostState createState() => _MakeAcaraPostState();
}

class _MakeAcaraPostState extends State<UpdateAcaraPost> {
  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _penyelenggaraController =
      TextEditingController();
  final TextEditingController _urlAcaraController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();
  final TextEditingController _lokasiController = TextEditingController();

  String? _img = '';
  String? _guidebook = '';
  DateTime? _startDate;
  DateTime? _endDate;
  DateTime? _announcementDate;

  final List<String> _temaList = [
    "Teknologi",
    "Marketing",
    "Desain",
    "Bisnis",
    "Sains"
  ];
  late String _selectedTema = _temaList[0]; // Default selection

  final List<String> _kategoriList = ["Kompetisi", "Bootcamp", "Seminar"];
  late String _selectedKategori = _kategoriList[0];

  @override
  void initState() {
    super.initState();
    _judulController.text = widget.acaraPost['judul'];
    _penyelenggaraController.text = widget.acaraPost['penyelenggara'];
    _urlAcaraController.text = widget.acaraPost['urlAcara'];
    _deskripsiController.text = widget.acaraPost['deskripsi'];
    _lokasiController.text = widget.acaraPost['lokasi'];
    _selectedTema = _temaList[0];
    _selectedKategori = _kategoriList[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Buat Acara',
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
              'Judul Acara',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextFormField(
              controller: _judulController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Judul tidak boleh kosong';
                }
                return null;
              },
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Penyelenggara tidak boleh kosong';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            //Lokasi
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
            //link acara
            const Text(
              'Link Acara',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextFormField(
              controller: _urlAcaraController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Link Acara tidak boleh kosong';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),

            //tema
            const Text(
              'Tema',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            DropdownButtonFormField<String>(
              value: _selectedTema,
              hint: const Text('Pilih Tema'),
              items: _temaList
                  .map((tema) => DropdownMenuItem<String>(
                        value: tema,
                        child: Text(tema),
                      ))
                  .toList(),
              onChanged: (value) => setState(() => _selectedTema = value!),
            ),
            const SizedBox(height: 20),

            //kategori
            const Text(
              'Kategori',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            DropdownButtonFormField<String>(
              value: _selectedKategori,
              hint: const Text('Pilih Kategori'),
              items: _kategoriList
                  .map((kategori) => DropdownMenuItem<String>(
                        value: kategori,
                        child: Text(kategori),
                      ))
                  .toList(),
              onChanged: (value) => setState(() => _selectedKategori = value!),
            ),
            const SizedBox(height: 20),

            //guidebook
            FileInputWidget(
              fileType: 'Guidebook',
              onSaveToDatabase: (guidebook) {
                _guidebook = guidebook;
              },
            ),

            const SizedBox(height: 10),

            //banner acara
            FileInputWidget(
              fileType: 'Banner Acara',
              onSaveToDatabase: (img) {
                _img = img;
              },
            ),

            const SizedBox(height: 10),

            //deskripsi acara
            const Text(
              'Deskripsi Acara',
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

            // Start Date
            const Text(
              'Tanggal Mulai',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextButton.icon(
                    onPressed: () async {
                      final DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          _startDate = pickedDate;
                        });
                      }
                    },
                    icon: Icon(Icons.calendar_today),
                    label: Text(
                      _startDate != null
                          ? '${_startDate!.day}/${_startDate!.month}/${_startDate!.year}'
                          : 'Pilih Tanggal',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // End Date
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

            // Announcement Date
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
                    onPressed: () async {
                      final DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          _announcementDate = pickedDate;
                        });
                      }
                    },
                    icon: Icon(Icons.calendar_today),
                    label: Text(
                      _announcementDate != null
                          ? '${_announcementDate!.day}/${_announcementDate!.month}/${_announcementDate!.year}'
                          : 'Pilih Tanggal',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                // Defer the validation until after the build method
                Future.delayed(Duration.zero, () {
                  AcaraKemahasiswaan acaraPost = AcaraKemahasiswaan(
                    judul: _judulController.text,
                    penyelenggara: _penyelenggaraController.text,
                    urlAcara: _selectedTema,
                    img: _img,
                    kategori: _selectedKategori,
                    lokasi: _lokasiController.text,
                    guidebook: _guidebook,
                    deskripsi: _deskripsiController.text,
                    startDate: Timestamp.fromDate(_startDate!),
                    endDate: Timestamp.fromDate(_endDate!),
                    announcementDate: Timestamp.fromDate(_announcementDate!),
                  );
                  AcaraService.updateAcara(
                      context, acaraPost, widget.acaraPost.id);
                });
              },
              child:
                  const Text('Unggah', style: TextStyle(color: Colors.black87)),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class MyDropdownButton extends StatefulWidget {
  String dropdownValue;
  final List<String> items;

  MyDropdownButton(
      {super.key, required this.dropdownValue, required this.items});

  @override
  // ignore: library_private_types_in_public_api
  _MyDropdownButtonState createState() => _MyDropdownButtonState();
}

class _MyDropdownButtonState extends State<MyDropdownButton> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      isExpanded: true,
      value: widget.dropdownValue,
      onChanged: (String? newValue) {
        setState(() {
          widget.dropdownValue = newValue!;
        });
      },
      items: widget.items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
