library setting_repo;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wurigiri/repo/repo.dart';

part 'public_impl.dart';

abstract class PublicRepo extends Repo {
  Stream<Map<String, dynamic>> get publicStream;
  Future<dynamic> updatePublic(Map<String, dynamic> data);
}
