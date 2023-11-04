import 'package:flutter/foundation.dart';

typedef TdMessageClose = void Function();

class TdMessageController {
  TdMessageController({
    required this.itemHeight,
    required this.itemSpacer,
  });

  int _stackIndex  = 0;

  /// 项目高度
  final double itemHeight;

  /// 项目间隔
  final double itemSpacer;

  final _listeners = ObserverList<VoidCallback>();

  int create() {
    return _stackIndex++;
  }

  void directory() {
    _stackIndex--;

    notifyListeners();
  }

  void addListener(VoidCallback listener) {
    _listeners.add(listener);
  }

  void removeListener(VoidCallback listener) {
    _listeners.remove(listener);
  }

  @protected
  @pragma('vm:notify-debugger-on-exception')
  void notifyListeners() {
    final localListeners = _listeners.toList();
    for (final listener in localListeners) {
      listener.call();
    }
  }
}
