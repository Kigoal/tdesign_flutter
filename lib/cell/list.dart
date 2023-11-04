import 'package:flutter/material.dart';

import '../theme/export.dart';
// import './section.dart';
import './interface.dart';

class TdList extends StatelessWidget {
  const TdList({
    super.key,
    this.type,
    this.iconTheme,
    this.labelStyle,
    this.badgeStyle,
    this.minimum,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    required this.children,
  });

  /// 单元格风格
  final TdCellGroupType? type;

  /// 图标主题
  final IconThemeData? iconTheme;

  /// 文本风格
  final TextStyle? labelStyle;

  /// 标记风格
  final TextStyle? badgeStyle;

  /// 安全边距
  final EdgeInsets? minimum;

  /// 软键盘关闭类型
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;

  /// 子元素
  final List<Widget> children;

  static TdListInheritedWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TdListInheritedWidget>();
  }

  @override
  Widget build(BuildContext context) {
    final theme = TdTheme.of(context);

    List<Widget> list = [];

    for (var i = 0; i < children.length; i++) {
      if (i != 0) {
        list.add(SizedBox(height: theme.spacer2));
      }

      list.add(children[i]);
    }

    return TdListInheritedWidget(
      type: type,
      iconTheme: iconTheme,
      labelStyle: labelStyle,
      badgeStyle: badgeStyle,
      child: SingleChildScrollView(
        keyboardDismissBehavior: keyboardDismissBehavior,
        child: SafeArea(
          minimum: minimum ??
              EdgeInsets.symmetric(
                vertical: theme.spacer2,
              ),
          child: Column(
            children: list,
          ),
        ),
      ),
    );
  }
}

class TdListInheritedWidget extends InheritedWidget {
  const TdListInheritedWidget({
    super.key,
    this.type,
    this.iconTheme,
    this.labelStyle,
    this.badgeStyle,
    required super.child,
  });

  /// 单元格风格
  final TdCellGroupType? type;

  /// 图标主题
  final IconThemeData? iconTheme;

  /// 文本风格
  final TextStyle? labelStyle;

  /// 标记风格
  final TextStyle? badgeStyle;

  static TdListInheritedWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TdListInheritedWidget>();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;
}
