import 'package:flutter/cupertino.dart';

class UIProvider extends ChangeNotifier {
  int _index = 0;

  int get selectOnTap => _index;

  set selectOnTap(int i) {
    _index = i;
    notifyListeners();
  }
}
