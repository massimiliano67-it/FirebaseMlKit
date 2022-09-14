import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class UserProvider with ChangeNotifier {
  String? _id;
  String? _email;
  String? _displayname;
  String? _urlPhoto;
  String? _phoneNumber;

  String? get email => _email;
  String? get displayname => _displayname;
  String? get urlPhoto => _urlPhoto;
  String? get phoneNumber => _phoneNumber;
  String? get id => _id;

  UserProvider() {}

  Future<void> setEmail({required String? value}) async {
    _email = value;
    notifyListeners();
  }

  Future<void> setId({required String? value}) async {
    _id = value;
    notifyListeners();
  }

  Future<void> setPhoneNumber({required String? value}) async {
    _phoneNumber = value;
    notifyListeners();
  }

  Future<void> setDisplayname({required String? value}) async {
    _displayname = value;
    notifyListeners();
  }

  Future<void> setUrlPhoto({required String? value}) async {
    _urlPhoto = value;
    notifyListeners();
  }

  Future<void> setUser({
    required String? id,
    required String? email,
    required String? displyname,
    required String? phoneNumber,
    required String? urlphoto,
  }) async {
    _id = id;
    _email = email;
    _displayname = displyname;
    _urlPhoto = urlphoto;
    _phoneNumber = phoneNumber;
    notifyListeners();
  }

  Map<String, dynamic> toMap() {
    return {
      'id': _id,
      'email': _email,
      'displayname': _displayname,
      'phoneNumber': _phoneNumber,
      'urlPhoto': _urlPhoto
    };
  }

  UserProvider.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : _id = doc.id,
        _email = doc.data()!["email"],
        _displayname = doc.data()!["displayname"],
        _phoneNumber = doc.data()!["phoneNumber"],
        _urlPhoto = doc.data()!["urlPhoto"];
}
