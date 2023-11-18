import 'package:flutter/widgets.dart';

import '../message/export.dart';

class TdGlobal extends StatefulWidget {
  const TdGlobal({
    super.key,
    this.child,
  });

  final Widget? child;

  @override
  State<TdGlobal> createState() => _TdGlobalState();
}

class _TdGlobalState extends State<TdGlobal> {
  @override
  void initState() {
    super.initState();

    TdMessagePlugin.context = context;
  }

  /// 初始化
  @override
  Widget build(BuildContext context) {
    return widget.child ?? const SizedBox.shrink();
  }
}
