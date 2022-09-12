import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

class GeoPositionProvider with ChangeNotifier {
  String _long = "", _lat = "";
  Position? _position;

  String? get long => _long;
  String? get lat => _lat;
  Position? get position => _position;

  Future<void> setLong({required String? value}) async {
    _long = value!;
    notifyListeners();
  }

  Future<void> setPosition({required Position? value}) async {
    _position = value!;
    _lat = _position!.latitude.toString();
    _long = _position!.longitude.toString();
    notifyListeners();
  }

  Future<void> setLat({required String? value}) async {
    _lat = value!;
    notifyListeners();
  }
}
