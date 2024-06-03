import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ToDoListCard extends StatefulWidget {
  final String id;
  final String title;
  final String category;
  final DateTime deadline;
  final bool isCompleted;

  const ToDoListCard({
    Key? key,
    required this.id,
    required this.title,
    required this.category,
    required this.deadline,
    required this.isCompleted,
  }) : super(key: key);

  @override
  _ToDoListCardState createState() => _ToDoListCardState();
}

class _ToDoListCardState extends State<ToDoListCard> {
  late bool _isCompleted;
  late bool _isLate;

  @override
  void initState() {
    super.initState();
    _isCompleted = widget.isCompleted;
    _checkIfLate(); // Check and update if the task is late
  }

  void _checkIfLate() async {
    final now = DateTime.now();
    if (now.isAfter(widget.deadline) && !_isCompleted) {
      setState(() {
        _isLate = true;
      });

      final User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('todos')
            .doc(widget.id)
            .update({'status': 'late'});
      }
    } else {
      setState(() {
        _isLate = false;
      });
    }
  }

  void _toggleCompletion(bool? value) async {
    if (_isLate) return;

    setState(() {
      _isCompleted = value ?? false;
    });

    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('todos')
          .doc(widget.id)
          .update({'status': _isCompleted ? 'completed' : 'ongoing'});
    }

    _checkIfLate(); // Recheck if the deadline has passed
  }

  @override
  Widget build(BuildContext context) {
    final currentTime = DateTime.now();
    final isPastDeadline = currentTime.isAfter(widget.deadline);

    if (isPastDeadline && !_isCompleted) {
      setState(() {
        _isLate = true;
      });
    }

    Color backgroundColor;
    if (_isCompleted) {
      backgroundColor = Colors.green.withOpacity(0.2);
    } else if (_isLate) {
      backgroundColor = Colors.red.withOpacity(0.2);
    } else {
      backgroundColor = Colors.white;
    }

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      color: backgroundColor,
      child: ListTile(
        leading: Checkbox(
          value: _isCompleted,
          onChanged: isPastDeadline ? null : _toggleCompletion,
          tristate: false,
        ),
        title: Text(widget.title),
        subtitle: Text(widget.category),
        trailing: Text(
          '${widget.deadline.day}-${widget.deadline.month}-${widget.deadline.year} ${widget.deadline.hour.toString().padLeft(2, '0')}:${widget.deadline.minute.toString().padLeft(2, '0')}',
        ),
      ),
    );
  }
}