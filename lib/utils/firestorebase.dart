import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasemlkit/classes/visionposition/visionresult.dart';

import '../classes/user/userprovider.dart';

class FirestoreBase {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  //  Firestore users
  Future<void> addUser(UserProvider userprovider) async {
    await _db
        .collection("users")
        .doc(userprovider.id)
        .set(userprovider.toMap());
  }

  Future<void> udpateUser(UserProvider userprovider) async {
    await _db
        .collection("users")
        .doc(userprovider.id)
        .update(userprovider.toMap());
  }

  Future<void> deleteUser(String documentId) async {
    await _db.collection("users").doc(documentId).delete();
  }

  //Firestore image
  Future<void> addResult(VisionResultProvider visioresultprovider) async {
    await _db.collection("results").add(visioresultprovider.toMap());
  }
}
