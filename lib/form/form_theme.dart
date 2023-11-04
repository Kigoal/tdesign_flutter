import 'package:flutter/material.dart';

class TdFormTheme extends InheritedTheme {
  const TdFormTheme({
    super.key,
    required this.data,
    required super.child,
  });

  final TdFormThemeData data;

  static TdFormThemeData of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TdFormTheme>()?.data ??
        const TdFormThemeData.fallback();
  }

  @override
  bool updateShouldNotify(covariant TdFormTheme oldWidget) =>
      data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) {
    return TdFormTheme(
      data: data,
      child: child,
    );
  }
}

class TdFormThemeData {
  const TdFormThemeData({
    this.requiredMark,
    this.labelWidth,
    this.labelAlign,
  });

  const TdFormThemeData.fallback()
      : requiredMark = null,
        labelWidth = null,
        labelAlign = null;

  /// 是否显示必填符号（*)
  final bool? requiredMark;

  /// 字段标签的宽度
  final double? labelWidth;

  /// 字段标签的对齐方式
  final TextAlign? labelAlign;
}
