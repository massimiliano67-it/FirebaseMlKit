import 'package:flutter/cupertino.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

import 'geopositionprovider.dart';

class VisionResultProvider with ChangeNotifier {
  List<String>? _listlabel;
  List<String>? _recognizedText;

  String? _geopositionLat;
  String? _geopositionLong;

  String? _uidUser;

  String _urlString = "";

  List<String>? get listlabel => _listlabel;
  List<String>? get recognizedText => _recognizedText;

  String? get uidUser => _uidUser;
  String? get urlString => _urlString;


  String? get geopositionLat => _geopositionLat;
  String? get geopositionLong => _geopositionLong;

  Future<void> setUrlImage({required String value}) async {
    _urlString = value;
    notifyListeners();
  }

  Future<void> setGeopositionLat({required String? value}) async {
    _geopositionLat = value;
    notifyListeners();
  }

  Future<void> setUidUser({required String? value}) async {
    _uidUser = value;
    notifyListeners();
  }

  Future<void> setGeopositionLong({required String? value}) async {
    _geopositionLong = value;
    notifyListeners();
  }

  Future<void> setGeopositionCoordinate(
      {required String? lat, required String? long}) async {
    _geopositionLat = lat;
    _geopositionLong = long;
    notifyListeners();
  }

  Future<void> setRecognizedText({required List<String>? value}) async {
    _recognizedText = value;
    notifyListeners();
  }

  Future<void> setImageLabel({required List<String>? value}) async {
    _listlabel = value;
    notifyListeners();
  }

  Future<void> setResult(
      {required List<String>? listlabel,
      required List<String> recognizedText,
      required GeoPositionProvider? geoposition,
      required String? lat,
      required String? long,
      required String? uuid,
      required String urlImage}) async {
    _listlabel = listlabel;
    _recognizedText = recognizedText;
    _geopositionLat = lat;
    _geopositionLong = long;
    _uidUser = uuid;
    _urlString = urlImage;
    notifyListeners();
  }

  Map<String, dynamic> toMap() {
    return {
      'listlabel': _listlabel,
      'recognizedText': _recognizedText,
      'Lat': _geopositionLat,
      'Long': _geopositionLong,
      'Uuid': _uidUser,
      'urlImage': _urlString,
    };
  }
}
