import 'package:flutter/widgets.dart';

class TdConfig {
  /// 单例
  static final TdConfig instance = TdConfig();

  TdConfig({
    GlobalKey? key,
  }) : _key = key;

  GlobalKey? _key;

  BuildContext get context {
    final context = _key?.currentContext;

    assert(context != null, '请设置全局Key!');

    return context!;
  }

  void setGlobalKey(GlobalKey key) {
    _key = key;
  }
}
