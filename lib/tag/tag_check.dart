import 'package:flutter/material.dart';

import '../theme/export.dart';
import './tag.dart';
import './interface.dart';

class TdRawCheckTag extends StatelessWidget {
  const TdRawCheckTag({
    super.key,
    required this.chekced,
    this.size = TdTagSize.medium,
    this.variant = TdTagVariant.light,
    this.icon,
    required this.child,
  });

  /// 选中状态
  final bool chekced;

  /// 尺寸类型
  final TdTagSize size;

  /// 风格类型
  final TdTagVariant variant;

  /// 图标
  final Widget? icon;

  /// 子元素
  final Widget child;

  TgTagColorRecord _getLightColor(TdThemeData theme) {
    return switch (chekced) {
      false => (
          theme.textColorPrimary,
          theme.backgroundColorSecondaryContainer,
          theme.backgroundColorSecondaryContainer,
        ),
      true => (
          theme.brandColor,
          theme.brandColorLight,
          theme.brandColorLight,
        ),
    };
  }

  TgTagColorRecord _getDarkColor(TdThemeData theme) {
    return switch (chekced) {
      false => (
          theme.textColorPrimary,
          theme.backgroundColorComponent,
          theme.backgroundColorComponent,
        ),
      true => (
          theme.fontWhite1,
          theme.brandColor,
          theme.brandColor,
        ),
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = TdTheme.of(context);

    final (textColor, backgroundColor, borderColor) = switch (variant) {
      TdTagVariant.light => _getLightColor(theme),
      TdTagVariant.dart => _getDarkColor(theme),
    };

    return TdRawTag(
      size: size,
      textColor: textColor,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      leading: icon,
      child: child,
    );
  }
}

class TdCheckTag extends StatefulWidget {
  const TdCheckTag({
    super.key,
    required this.onChanged,
    this.initialValue = false,
    this.size = TdTagSize.medium,
    this.variant = TdTagVariant.light,
    this.icon,
    required this.child,
  });

  /// 选中改变事件
  final ValueChanged<bool> onChanged;

  /// 初始值
  final bool initialValue;

  /// 尺寸类型
  final TdTagSize size;

  /// 风格类型
  final TdTagVariant variant;

  /// 图标
  final Widget? icon;

  /// 子元素
  final Widget child;

  @override
  State<TdCheckTag> createState() => _TdCheckTagState();
}

class _TdCheckTagState extends State<TdCheckTag> {
  late bool _value;

  @override
  void initState() {
    super.initState();

    _value = widget.initialValue;
  }

  void _handleChecked() {
    _value = !_value;

    widget.onChanged(_value);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _handleChecked,
      child: TdRawCheckTag(
        chekced: _value,
        size: widget.size,
        icon: widget.icon,
        child: widget.child,
      ),
    );
  }
}
