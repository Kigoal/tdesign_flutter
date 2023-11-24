import 'package:flutter/widgets.dart';

class TdConfigProvide {
  /// 单例
  static TdConfigProvide instance = TdConfigProvide();

  TdConfigProvide({
    GlobalKey? key,
  }) : _key = key;

  GlobalKey? _key;

  BuildContext get context {
    final context = _key?.currentContext;

    assert(context != null, '请先传递router key!');

    return context!;
  }

  void setGlobalKey(GlobalKey key) {
    _key = key;
  }
}
