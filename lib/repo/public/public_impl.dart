part of setting_repo;

class PublicImpl extends PublicRepo {
  PublicImpl(this.publicID);
  final String publicID;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final publicCollection = "public";
  final Service service = Service();

  @override
  Future init() async {}

  CollectionReference get collection => _firestore.collection(publicCollection);

  DocumentReference document(String document) {
    return collection.doc(document);
  }

  @override
  Stream<Map<String, dynamic>> get publicStream =>
      service.publicRef(publicID).snapshots().map(
        (event) {
          final data = event.data();
          if (data == null) {
            return {};
          }
          return data as Map<String, dynamic>;
        },
      );

  @override
  Future updatePublic(Map<String, dynamic> data) {
    return document(publicID).set(data);
  }
}
