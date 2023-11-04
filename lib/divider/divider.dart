import 'package:flutter/material.dart';

import '../theme/export.dart';

class TdDivider extends StatelessWidget {
  const TdDivider({
    super.key,
    this.height,
    this.thickness,
    this.indent,
    this.endIndent,
    this.color,
  });

  /// 高度
  final double? height;

  /// 线条尺寸
  final double? thickness;

  /// 左侧缩进`
  final double? indent;

  /// 右侧缩进
  final double? endIndent;

  /// 分割线的颜色
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = TdTheme.of(context);

    return SizedBox(
      height: height ?? 0.5,
      child: Center(
        child: Container(
          height: thickness ?? 0.5,
          margin: EdgeInsets.only(
            left: indent ?? theme.spacer2,
            right: endIndent ?? 0.0,
          ),
          color: color ?? theme.componentStroke,
        ),
      ),
    );
  }
}
