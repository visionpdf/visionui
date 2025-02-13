import 'package:flutter/material.dart';

class SearchProvider extends ChangeNotifier {
  bool _showSearch = false;

  bool get showSearch => _showSearch;

  void show() {
    _showSearch = true;
    notifyListeners();
  }

  void hide() {
    _showSearch = false;
    notifyListeners();
  }
}
