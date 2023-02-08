import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Service {
  final _firestore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  DocumentReference _ref(
    String collection,
    String document,
  ) {
    return _firestore.collection(collection).doc(document);
  }

  DocumentReference publicRef(String publicID) {
    return _ref("public", publicID);
  }

  CollectionReference feedRef(String publicID) {
    return publicRef(publicID).collection("feed");
  }

  CollectionReference chatRef(String publicID) {
    return publicRef(publicID).collection("chat");
  }

  CollectionReference userRef() {
    return _firestore.collection("user");
  }

  CollectionReference chatEnterRef(String publicID) {
    return publicRef(publicID).collection("chatEnter");
  }

  CollectionReference connectRef() {
    return _firestore.collection("connect");
  }

  Future<String> uploadFile(String filePath) async {
    final index = DateTime.now().millisecondsSinceEpoch;
    final ref = _storage.ref(index.toString());
    await ref.putFile(File(filePath));
    return ref.getDownloadURL();
  }

  Future removeFile(String fileName) {
    final ref = _storage.ref(fileName);
    return ref.delete();
  }
}
