import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:unishare/app/models/todo.dart';

class ToDoController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<ToDo>> fetchToDos() {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('No user logged in');
    }
    return _firestore
        .collection('users')
        .doc(user.uid)
        .collection('todos')
        .orderBy('deadline')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ToDo.fromDocument(doc))
            .toList());
  }

  Future<void> addToDo(ToDo todo) async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('No user logged in');
    }
    await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('todos')
        .add(todo.toJson());
  }
}