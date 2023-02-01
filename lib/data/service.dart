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

  Future get({
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
