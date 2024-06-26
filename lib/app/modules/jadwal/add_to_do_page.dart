import 'package:flutter/material.dart';
import 'package:unishare/app/controller/todo_controller.dart';
import 'package:unishare/app/models/todo.dart';

class AddToDoPage extends StatefulWidget {
  @override
  _AddToDoPageState createState() => _AddToDoPageState();
}

class _AddToDoPageState extends State<AddToDoPage> {
  final _formKey = GlobalKey<FormState>();
  final _judulController = TextEditingController();
  final _kategoriController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  final ToDoController _todoController = ToDoController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah To-Do List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _judulController,
                decoration: InputDecoration(labelText: 'Judul'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Judul tidak boleh kosong';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _kategoriController,
                decoration: InputDecoration(labelText: 'Kategori'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Kategori tidak boleh kosong';
                  }
                  return null;
                },
              ),
              ListTile(
                title: Text(_selectedDate == null
                    ? 'Pilih Tanggal'
                    : 'Tanggal: ${_selectedDate!.toLocal()}'.split(' ')[0]),
                trailing: Icon(Icons.calendar_today),
                onTap: _pickDate,
              ),
              ListTile(
                title: Text(_selectedTime == null
                    ? 'Pilih Jam'
                    : 'Jam: ${_selectedTime!.format(context)}'),
                trailing: Icon(Icons.access_time),
                onTap: _pickTime,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveToDo,
                child: Text('Simpan'),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  Future<void> _pickTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  Future<void> _saveToDo() async {
    if (_formKey.currentState!.validate()) {
      if (_selectedDate == null || _selectedTime == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Tanggal dan Jam harus dipilih')),
        );
        return;
      }

      DateTime deadline = DateTime(
        _selectedDate!.year,
        _selectedDate!.month,
        _selectedDate!.day,
        _selectedTime!.hour,
        _selectedTime!.minute,
      );

      ToDo todo = ToDo(
        id: '', // ID will be generated by Firestore
        judul: _judulController.text,
        kategori: _kategoriController.text,
        deadline: deadline,
        status: 'ongoing', // Default status
      );

      await _todoController.addToDo(todo);

      Navigator.pop(context);
    }
  }
}