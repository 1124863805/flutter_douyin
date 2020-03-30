import 'package:flutter/cupertino.dart';

class DouYin with ChangeNotifier {
  int _state = 0;

  int get state => _state;

  void setState(int state) {
    _state = state;
    notifyListeners();
  }
}