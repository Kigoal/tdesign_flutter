import 'package:flutter/widgets.dart';

class TdTabBarController with ChangeNotifier {
  TdTabBarController({
    required int initialIndex,
    required List<bool> initialMap,
  })  : _index = initialIndex,
        selectedMap = initialMap;

  int _index;
  int get index => _index;
  set index(int value) {
    if (value == _index) {
      return;
    }

    selectedMap[_index] = false;
    selectedMap[value] = true;

    _index = value;

    notifyListeners();
  }

  List<bool> selectedMap;

  static List<bool> makeSelectedMap(int length, int selectedIndex) {
    return List.generate(length, (index) => index == selectedIndex);
  }
}
