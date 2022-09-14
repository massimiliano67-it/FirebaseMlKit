import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class VisioPositionProvider with ChangeNotifier {
  XFile? _image = null;
  String? _textCustomPanelControl;
  String _lableresult = "";


  XFile? get image => _image;
  String? get textCustomPanelControl => _textCustomPanelControl;
  String? get lableresult => _lableresult;




  Future<void> setImage({required XFile? value}) async {
    _image = value;
    notifyListeners();
  }

  Future<void> setLableresult({required String value}) async {
    _lableresult = value;
    notifyListeners();
  }

  Future<void> setTextCustomPanelControl({required String? value}) async {
    _textCustomPanelControl = value;
    notifyListeners();
  }

  Future<void> clearTextCustomPanelControl() async {
    _textCustomPanelControl = "";
    notifyListeners();
  }
}
