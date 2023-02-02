import 'package:cloud_firestore/cloud_firestore.dart';

class FireService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  DocumentReference _ref(
    String collection,
    String document,
  ) {
    return _firestore.collection(collection).doc(document);
  }

  Stream<DocumentSnapshot> stream({
    required String collection,
    required String document,
  }) {
    return _ref(collection, document).snapshots();
  }

  Future update({
    required String collection,
    required String document,
    required Map<String, dynamic> data,
  }) async {
    try {
      return _ref(collection, document).set(data);
    } catch (e) {
      print(e);
    }
  }

  Future remove({
    required String collection,
    required String document,
  }) async {
    try {
      return _ref(collection, document).delete();
    } catch (e) {
      print(e);
    }
  }

  Future<List<Map<String, dynamic>>> getDocumentList(String collection) async {
    final snapshot = await _firestore.collection(collection).get();
    return snapshot.docs.map((e) {
      return e.data();
    }).toList();
  }

  Future getDocument({
    required String collection,
    required String document,
  }) async {
    try {
      final res = await _ref(collection, document).get();
      return res.data();
    } catch (e) {
      print(e);
    }
  }
}
