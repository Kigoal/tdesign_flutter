import 'package:flutter/widgets.dart';
import 'package:tdesign_icons_flutter/tdesign_icons_flutter.dart';

import '../theme/export.dart';
import './interface.dart';

class TdRawTag extends StatelessWidget {
  const TdRawTag({
    super.key,
    required this.size,
    required this.textColor,
    required this.backgroundColor,
    required this.borderColor,
    this.leading,
    this.trailing,
    required this.child,
  });

  /// 尺寸类型
  final TdTagSize size;

  /// 文字颜色
  final Color textColor;

  /// 背景颜色
  final Color backgroundColor;

  /// 边框颜色
  final Color borderColor;

  /// 左侧图标
  final Widget? leading;

  /// 右侧图标
  final Widget? trailing;

  /// 子元素
  final Widget child;

  /// 获取文本字体
  TextStyle _getTextStyle(TdThemeData theme) {
    return switch (size) {
      TdTagSize.small => theme.font,
      TdTagSize.medium => theme.fontS,
      TdTagSize.large => theme.fontBase,
      TdTagSize.extraLarge => theme.fontBase,
    };
  }

  /// 获取图标数据
  IconThemeData _getIconTheme(TdThemeData theme) {
    return switch (size) {
      TdTagSize.small => const IconThemeData(size: 12.0),
      TdTagSize.medium => const IconThemeData(size: 14.0),
      TdTagSize.large => const IconThemeData(size: 16.0),
      TdTagSize.extraLarge => const IconThemeData(size: 16.0),
    };
  }

  /// 获取高度
  double _getHeight(TdThemeData theme) {
    return switch (size) {
      TdTagSize.small => 20.0,
      TdTagSize.medium => 24.0,
      TdTagSize.large => 28.0,
      TdTagSize.extraLarge => 40.0,
    };
  }

  /// 获取内边距
  EdgeInsets _getPadding(TdThemeData theme) {
    return switch (size) {
      TdTagSize.small => const EdgeInsets.symmetric(horizontal: 5.0),
      TdTagSize.medium => const EdgeInsets.symmetric(horizontal: 7.0),
      TdTagSize.large => const EdgeInsets.symmetric(horizontal: 7.0),
      TdTagSize.extraLarge => const EdgeInsets.symmetric(horizontal: 15.0),
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = TdTheme.of(context);

    final textStyle = _getTextStyle(theme).copyWith(
      color: textColor,
    );
    final iconTheme = _getIconTheme(theme).copyWith(
      color: textColor,
    );
    final height = _getHeight(theme);
    final padding = _getPadding(theme);

    Widget? leadingWidth;
    if (leading != null) {
      leadingWidth = Padding(
        padding: EdgeInsets.only(
          right: theme.spacer / 2,
        ),
        child: leading!,
      );
    }

    Widget? trailingWidth;
    if (trailing != null) {
      trailingWidth = Padding(
        padding: EdgeInsets.only(
          left: theme.spacer / 2,
        ),
        child: trailing!,
      );
    }

    return Container(
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: theme.radiusDefault,
        border: Border.all(
          color: borderColor,
          width: 1.0,
        ),
      ),
      child: DefaultTextStyle(
        style: textStyle,
        child: IconTheme(
          data: iconTheme,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (leadingWidth != null) leadingWidth,
              child,
              if (trailingWidth != null) trailingWidth,
            ],
          ),
        ),
      ),
    );
  }
}

class TdTag extends StatelessWidget {
  const TdTag({
    super.key,
    this.onClosed,
    this.closable = false,
    this.size = TdTagSize.medium,
    this.type = TdTagType.normal,
    this.variant = TdTagVariant.light,
    this.icon,
    required this.child,
  });

  const TdTag.primary({
    super.key,
    this.onClosed,
    this.closable = false,
    this.size = TdTagSize.medium,
    this.variant = TdTagVariant.light,
    this.icon,
    required this.child,
  }) : type = TdTagType.primary;

  const TdTag.warning({
    super.key,
    this.onClosed,
    this.closable = false,
    this.size = TdTagSize.medium,
    this.variant = TdTagVariant.light,
    this.icon,
    required this.child,
  }) : type = TdTagType.warning;

  const TdTag.danger({
    super.key,
    this.onClosed,
    this.closable = false,
    this.size = TdTagSize.medium,
    this.variant = TdTagVariant.light,
    this.icon,
    required this.child,
  }) : type = TdTagType.danger;

  const TdTag.success({
    super.key,
    this.onClosed,
    this.closable = false,
    this.size = TdTagSize.medium,
    this.variant = TdTagVariant.light,
    this.icon,
    required this.child,
  }) : type = TdTagType.success;

  /// 点击关闭按钮事件
  final GestureTapCallback? onClosed;

  /// 是否可以关闭
  final bool closable;

  /// 尺寸类型
  final TdTagSize size;

  /// 标签类型
  final TdTagType type;

  /// 风格类型
  final TdTagVariant variant;

  /// 图标
  final Widget? icon;

  /// 子元素
  final Widget child;

  TgTagColorRecord _getLightColor(TdThemeData theme) {
    return switch (type) {
      TdTagType.normal => (
          theme.textColorPrimary,
          theme.backgroundColorSecondaryContainer,
          theme.backgroundColorSecondaryContainer
        ),
      TdTagType.primary => (
          theme.brandColor,
          theme.brandColorLight,
          theme.brandColorLight
        ),
      TdTagType.warning => (
          theme.warningColor,
          theme.warningColor1,
          theme.warningColor1
        ),
      TdTagType.danger => (
          theme.errorColor,
          theme.errorColor1,
          theme.errorColor1
        ),
      TdTagType.success => (
          theme.successColor,
          theme.successColor1,
          theme.successColor1
        ),
    };
  }

  TgTagColorRecord _getDarkColor(TdThemeData theme) {
    return switch (type) {
      TdTagType.normal => (
          theme.textColorPrimary,
          theme.backgroundColorComponent,
          theme.backgroundColorComponent
        ),
      TdTagType.primary => (
          theme.fontWhite1,
          theme.brandColor,
          theme.brandColor
        ),
      TdTagType.warning => (
          theme.fontWhite1,
          theme.warningColor,
          theme.warningColor
        ),
      TdTagType.danger => (
          theme.fontWhite1,
          theme.errorColor,
          theme.errorColor
        ),
      TdTagType.success => (
          theme.fontWhite1,
          theme.successColor,
          theme.successColor
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

    Widget? closeWidth;
    if (closable) {
      closeWidth = GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onClosed,
        child: const Icon(TdIcons.close),
      );
    }

    return TdRawTag(
      size: size,
      textColor: textColor,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      leading: icon,
      trailing: closeWidth,
      child: child,
    );
  }
}
