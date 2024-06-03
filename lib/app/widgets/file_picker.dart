import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;

class FileInputWidget extends StatefulWidget {
  final String fileType;
  final void Function(String? firebaseUrl)? onSaveToDatabase;

  FileInputWidget({required this.fileType, this.onSaveToDatabase});

  @override
  _FileInputWidgetState createState() => _FileInputWidgetState();
}

class _FileInputWidgetState extends State<FileInputWidget> {
  String _filePath = '';

  Future<String?> _pickPdfFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      setState(() {
        _filePath = file.path!;
      });

      // Tentukan direktori Firebase Storage berdasarkan jenis file
      String directory = widget.fileType == 'Image' ? 'img/' : 'file/';

      // Upload file ke Firebase Storage
      Reference ref = FirebaseStorage.instance
          .ref()
          .child(directory)
          .child(path.basename(_filePath));
      UploadTask uploadTask = ref.putFile(File(_filePath));
      TaskSnapshot snapshot = await uploadTask.whenComplete(() {});

      // Dapatkan URL file yang diupload
      String downloadUrl = await snapshot.ref.getDownloadURL();

      // Panggil callback untuk menyimpan URL ke database jika tersedia
      if (widget.onSaveToDatabase != null) {
        widget.onSaveToDatabase!(downloadUrl);
      }

      return downloadUrl;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.fileType,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextButton(
          onPressed: () async {
            await _pickPdfFile();
          },
          child: Row(
            children: [
              const Icon(Icons.attach_file),
              const SizedBox(width: 8), // Add spacing between icon and text
              Text(
                'Choose ${widget.fileType}',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black, // Adjust text color if necessary
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
            height:
            8), // Add some spacing between the text button and file path
        Text(
          _filePath,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey, // Adjust text color if necessary
          ),
        ),
      ],
    );
  }
}