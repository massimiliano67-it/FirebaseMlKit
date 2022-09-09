import 'package:flutter/cupertino.dart';

class UserProvider with ChangeNotifier {
  String? _email;
  String? _displayname;
  String? _urlPhoto;

  String? get email => _email;
  String? get displayname => _displayname;
  String? get urlPhoto => _urlPhoto;

  Future<void> setEmail({required String? value}) async {
    _email = value;
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
    required String? email,
    required String? displyname,
    required String? urlphoto,
  }) async {
    _email = email;
    _displayname = displyname;
    _urlPhoto = urlphoto;
    notifyListeners();
  }
}
