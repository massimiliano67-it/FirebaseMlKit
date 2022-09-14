import 'package:flutter/cupertino.dart';

class AppStateProvider with ChangeNotifier {
  bool _isBusy = false;
  bool _canProcess = true;

  bool get isBusy => _isBusy;
  bool get canProcess => _canProcess;

  Future<void> setIsBusy({required bool value}) async {
    _isBusy = value;
    notifyListeners();
  }

  Future<void> setCanProcess({required bool value}) async {
    _canProcess = value;
    notifyListeners();
  }
}
