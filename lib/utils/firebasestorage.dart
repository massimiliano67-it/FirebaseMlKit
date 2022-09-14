import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class FirestoreStorage {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  //  Firestore users
  Future<String> addFile(XFile filePath, String user) async {
    String fileName = path.basename(filePath.path);
    File imageFile = File(filePath.path);

    try {
      // Uploading the selected image with some custom meta data
      var snapshot = await _storage.ref(fileName).putFile(
          imageFile,
          SettableMetadata(customMetadata: {
            'uploaded_by': 'A bad guy',
            'description': 'Some description...'
          }));

      var downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } on FirebaseException catch (error) {
      print(error);
      return "";
    } catch (err) {
      print(err);
      return "";
    }
  }
}
