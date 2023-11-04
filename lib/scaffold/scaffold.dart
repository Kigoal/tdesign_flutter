import 'package:flutter/material.dart';

import '../theme/export.dart';

typedef TdScaffoldCallback = Widget Function(int index);

class TdScaffold extends StatelessWidget {
  const TdScaffold({
    super.key,
    this.bottomNavigationBar,
    required this.body,
    this.floatingActionButton,
    this.backgroundColor,
    this.resizeToAvoidBottomInset,
    this.appBar,
  });

  /// 标题栏
  final PreferredSizeWidget? appBar;

  /// 底部导航栏
  final Widget? bottomNavigationBar;

  /// 悬浮按钮
  final Widget? floatingActionButton;

  /// 背景颜色
  final Color? backgroundColor;

  /// 弹出软键盘时是否重置尺寸
  final bool? resizeToAvoidBottomInset;

  /// 子元素
  final Widget body;

  @override
  Widget build(BuildContext context) {
    final theme = TdTheme.of(context);

    return Scaffold(
      backgroundColor: backgroundColor ?? theme.backgroundColorPage,
      appBar: appBar,
      body: body,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
    );
  }
}
