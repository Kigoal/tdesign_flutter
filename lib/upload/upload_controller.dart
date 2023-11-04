import 'package:flutter/foundation.dart';

import './interface.dart';

class TdUploadController with ChangeNotifier {
  TdUploadController({
    required List<TdUploadData> value,
  }) : _value = value;

  /// 文件列表
  List<TdUploadData> _value;

  List<TdUploadData> get value => _value;

  set value(List<TdUploadData> newValue) {
    if (newValue == _value) {
      return;
    }

    _value = newValue;

    notifyListeners();
  }

  void remove(int index) {
    _value.removeAt(index);

    notifyListeners();
  }

  void add(TdUploadData data) {
    _value.add(data);

    notifyListeners();
  }
}
