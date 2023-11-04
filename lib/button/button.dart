import 'package:flutter/material.dart';

import '../theme/export.dart';
import './button_theme.dart';
import './interface.dart';

class TdRawButton extends StatefulWidget {
  const TdRawButton({
    super.key,
    required this.onPressed,
    this.disabled = false,
    this.alignment,
    this.width,
    this.height,
    this.padding,
    this.borderRadius,
    this.boxShadow,
    this.textStyle,
    this.iconTheme,
    required this.textColor,
    this.actionTextColor,
    this.disabledTextColor,
    required this.backgroundColor,
    this.actionBackgroundColor,
    this.disabledBackgroundColor,
    this.borderColor,
    this.actionBorderColor,
    this.disabledBorderColor,
    required this.child,
  });

  /// 点击事件
  final VoidCallback onPressed;

  /// 是否禁用按钮
  final bool disabled;

  /// 对齐方式
  final Alignment? alignment;

  /// 宽度尺寸
  final double? width;

  /// 高度尺寸
  final double? height;

  /// 内边距
  final EdgeInsets? padding;

  /// 边框圆角
  final BorderRadius? borderRadius;

  /// 边框阴影
  final List<BoxShadow>? boxShadow;

  /// 字体样式
  final TextStyle? textStyle;

  /// 图标样式
  final IconThemeData? iconTheme;

  /// 文字颜色
  final Color textColor;

  /// 激活时文本颜色
  final Color? actionTextColor;

  /// 禁用时文本颜色
  final Color? disabledTextColor;

  /// 背景颜色
  final Color backgroundColor;

  /// 激活时背景颜色
  final Color? actionBackgroundColor;

  /// 禁用时背景颜色
  final Color? disabledBackgroundColor;

  /// 边框颜色
  final Color? borderColor;

  /// 激活时边框颜色
  final Color? actionBorderColor;

  /// 禁用时边框颜色
  final Color? disabledBorderColor;

  /// 子元素
  final Widget child;

  @override
  State<TdRawButton> createState() => _TdRawButtonState();
}

class _TdRawButtonState extends State<TdRawButton> {
  bool _tapped = false;

  void _setTapped(bool value) {
    if (_tapped != value) {
      setState(() {
        _tapped = value;
      });
    }
  }

  /// 选择当前状态的颜色
  Color? _selectColor({
    Color? color,
    Color? actionColor,
    Color? disabledColor,
  }) {
    final Color? currentColor;

    if (widget.disabled) {
      currentColor = disabledColor;
    } else if (_tapped) {
      currentColor = actionColor;
    } else {
      currentColor = color;
    }

    return currentColor ?? color;
  }

  @override
  Widget build(BuildContext context) {
    final textColor = _selectColor(
      color: widget.textColor,
      actionColor: widget.actionTextColor,
      disabledColor: widget.disabledTextColor,
    );

    final backgroundColor = _selectColor(
      color: widget.backgroundColor,
      actionColor: widget.actionBackgroundColor,
      disabledColor: widget.disabledBackgroundColor,
    );

    final borderColor = _selectColor(
      color: widget.borderColor,
      actionColor: widget.actionBorderColor,
      disabledColor: widget.disabledBorderColor,
    );

    Border? border;
    if (borderColor != null) {
      border = Border.all(
        color: borderColor,
        width: 1.0,
      );
    }

    return GestureDetector(
      onTap: () {
        if (!widget.disabled) {
          widget.onPressed();
        }
      },
      onTapDown: (details) {
        _setTapped(true);
      },
      onTapUp: (details) {
        _setTapped(false);
      },
      onTapCancel: () {
        _setTapped(false);
      },
      child: Container(
        alignment: widget.alignment,
        width: widget.width,
        height: widget.height,
        padding: widget.padding,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: widget.borderRadius,
          border: border,
          boxShadow: widget.boxShadow,
        ),
        child: IconTheme(
          data: (widget.iconTheme ?? const IconThemeData()).copyWith(
            color: textColor,
            weight: 600.0,
          ),
          child: DefaultTextStyle(
            style: (widget.textStyle ?? const TextStyle()).copyWith(
              color: textColor,
              fontWeight: FontWeight.w600,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}

class _TdButtonContainer extends StatelessWidget {
  const _TdButtonContainer({
    required this.onPressed,
    this.disabled = false,
    this.block = true,
    this.size = TdButtonSize.large,
    this.shape = TdButtonShape.rectangle,
    this.borderRadius,
    required this.textColor,
    this.actionTextColor,
    this.disabledTextColor,
    required this.backgroundColor,
    this.actionBackgroundColor,
    this.disabledBackgroundColor,
    this.borderColor,
    this.actionBorderColor,
    this.disabledBorderColor,
    this.icon,
    required this.child,
  });

  /// 点击事件
  final VoidCallback onPressed;

  /// 是否禁用按钮
  final bool disabled;

  /// 是否为块级元素
  final bool block;

  /// 尺寸类型
  final TdButtonSize size;

  /// 形状类型
  final TdButtonShape shape;

  /// 边框圆角
  final BorderRadius? borderRadius;

  /// 文字颜色
  final Color textColor;

  /// 激活时文本颜色
  final Color? actionTextColor;

  /// 禁用时文本颜色
  final Color? disabledTextColor;

  /// 背景颜色
  final Color backgroundColor;

  /// 激活时背景颜色
  final Color? actionBackgroundColor;

  /// 禁用时背景颜色
  final Color? disabledBackgroundColor;

  /// 边框颜色
  final Color? borderColor;

  /// 激活时边框颜色
  final Color? actionBorderColor;

  /// 禁用时边框颜色
  final Color? disabledBorderColor;

  /// 图标
  final Widget? icon;

  /// 子元素
  final Widget child;

  /// 获取文本字体
  TextStyle _getTextStyle(TdThemeData theme) {
    switch (size) {
      case TdButtonSize.extraSmal:
      case TdButtonSize.small:
        return theme.fontBase;
      case TdButtonSize.medium:
      case TdButtonSize.large:
        return theme.fontM;
    }
  }

  /// 获取图标数据
  IconThemeData _getIconTheme(TdThemeData theme) {
    switch (size) {
      case TdButtonSize.extraSmal:
      case TdButtonSize.small:
        return IconThemeData(size: theme.spacer2);
      case TdButtonSize.medium:
      case TdButtonSize.large:
        return IconThemeData(size: theme.spacer3);
    }
  }

  /// 获取高度
  double _getHeight(TdButtonThemeData buttonTheme) {
    switch (size) {
      case TdButtonSize.extraSmal:
        return buttonTheme.extraSmallHeight;
      case TdButtonSize.small:
        return buttonTheme.smallHeight;
      case TdButtonSize.medium:
        return buttonTheme.mediumHeight;
      case TdButtonSize.large:
        return buttonTheme.largeHeight;
    }
  }

  /// 获取内边距
  EdgeInsets _getPadding(TdThemeData theme) {
    if (shape == TdButtonShape.square || shape == TdButtonShape.circle) {
      return EdgeInsets.zero;
    }

    switch (size) {
      case TdButtonSize.extraSmal:
        return EdgeInsets.symmetric(
          horizontal: theme.spacer,
        );
      case TdButtonSize.small:
        return EdgeInsets.symmetric(
          horizontal: theme.spacer1,
        );
      case TdButtonSize.medium:
        return EdgeInsets.symmetric(
          horizontal: theme.spacer2,
        );
      case TdButtonSize.large:
        return EdgeInsets.symmetric(
          horizontal: theme.spacer3 - (theme.spacer / 2),
        );
    }
  }

  /// 获取圆角
  BorderRadius _getBorderRadius(TdThemeData theme) {
    switch (shape) {
      case TdButtonShape.rectangle:
      case TdButtonShape.square:
        return theme.radiusDefault;
      case TdButtonShape.round:
      case TdButtonShape.circle:
        return theme.radiusCircle;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = TdTheme.of(context);
    final buttonTheme = TdButtonTheme.of(context);

    Widget? iconWidget;
    if (icon != null) {
      iconWidget = Padding(
        padding: EdgeInsets.only(right: theme.spacer / 2),
        child: icon!,
      );
    }

    final size = _getHeight(buttonTheme);

    return TdRawButton(
      onPressed: onPressed,
      disabled: disabled,
      alignment: block ? Alignment.center : null,
      width: shape == TdButtonShape.square || shape == TdButtonShape.circle ? size : null,
      height: size,
      padding: _getPadding(theme),
      borderRadius: _getBorderRadius(theme),
      textStyle: _getTextStyle(theme),
      iconTheme: _getIconTheme(theme),
      textColor: textColor,
      actionTextColor: actionTextColor,
      disabledTextColor: disabledTextColor,
      backgroundColor: backgroundColor,
      actionBackgroundColor: actionBackgroundColor,
      disabledBackgroundColor: disabledBackgroundColor,
      borderColor: borderColor,
      actionBorderColor: actionBorderColor,
      disabledBorderColor: disabledBorderColor,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (iconWidget != null) iconWidget,
          child,
        ],
      ),
    );
  }
}

class TdButton extends StatelessWidget {
  const TdButton({
    super.key,
    required this.onPressed,
    this.disabled = false,
    this.block = true,
    this.size = TdButtonSize.large,
    this.shape = TdButtonShape.rectangle,
    this.type = TdButtonType.normal,
    this.icon,
    required this.child,
  });

  const TdButton.primary({
    super.key,
    required this.onPressed,
    this.disabled = false,
    this.block = true,
    this.size = TdButtonSize.large,
    this.shape = TdButtonShape.rectangle,
    this.icon,
    required this.child,
  }) : type = TdButtonType.primary;

  const TdButton.danger({
    super.key,
    required this.onPressed,
    this.disabled = false,
    this.block = true,
    this.size = TdButtonSize.large,
    this.shape = TdButtonShape.rectangle,
    this.icon,
    required this.child,
  }) : type = TdButtonType.danger;

  const TdButton.light({
    super.key,
    required this.onPressed,
    this.disabled = false,
    this.block = true,
    this.size = TdButtonSize.large,
    this.shape = TdButtonShape.rectangle,
    this.icon,
    required this.child,
  }) : type = TdButtonType.light;

  /// 点击事件
  final VoidCallback onPressed;

  /// 是否禁用按钮
  final bool disabled;

  /// 是否为块级元素
  final bool block;

  /// 尺寸类型
  final TdButtonSize size;

  /// 形状类型
  final TdButtonShape shape;

  /// 按钮类型
  final TdButtonType type;

  /// 图标
  final Widget? icon;

  /// 子元素
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = TdTheme.of(context);

    final Color textColor;
    final Color backgroundColor;
    final Color actionBackgroundColor;
    final Color disabledBackgroundColor;

    switch (type) {
      case TdButtonType.normal:
        textColor = theme.textColorPrimary;
        backgroundColor = theme.backgroundColorComponent;
        actionBackgroundColor = theme.backgroundColorComponentActive;
        disabledBackgroundColor = theme.backgroundColorComponentDisabled;
      case TdButtonType.primary:
        textColor = theme.fontWhite1;
        backgroundColor = theme.brandColor;
        actionBackgroundColor = theme.brandColorActive;
        disabledBackgroundColor = theme.brandColorDisabled;
      case TdButtonType.danger:
        textColor = theme.fontWhite1;
        backgroundColor = theme.errorColor;
        actionBackgroundColor = theme.errorColorActive;
        disabledBackgroundColor = theme.errorColorDisabled;
      case TdButtonType.light:
        textColor = theme.brandColor;
        backgroundColor = theme.brandColorLight;
        actionBackgroundColor = theme.brandColorLightActive;
        disabledBackgroundColor = theme.brandColorLightActive;
    }

    return _TdButtonContainer(
      onPressed: onPressed,
      disabled: disabled,
      block: block,
      size: size,
      shape: shape,
      textColor: textColor,
      backgroundColor: backgroundColor,
      actionBackgroundColor: actionBackgroundColor,
      disabledBackgroundColor: disabledBackgroundColor,
      borderRadius: theme.radiusDefault,
      icon: icon,
      child: child,
    );
  }
}

class TdTextButton extends StatelessWidget {
  const TdTextButton({
    super.key,
    required this.onPressed,
    this.disabled = false,
    this.block = true,
    this.size = TdButtonSize.large,
    this.shape = TdButtonShape.rectangle,
    this.type = TdButtonType.normal,
    this.icon,
    required this.child,
  });

  const TdTextButton.primary({
    super.key,
    required this.onPressed,
    this.disabled = false,
    this.block = true,
    this.size = TdButtonSize.large,
    this.shape = TdButtonShape.rectangle,
    this.icon,
    required this.child,
  }) : type = TdButtonType.primary;

  const TdTextButton.danger({
    super.key,
    required this.onPressed,
    this.disabled = false,
    this.block = true,
    this.size = TdButtonSize.large,
    this.shape = TdButtonShape.rectangle,
    this.icon,
    required this.child,
  }) : type = TdButtonType.danger;

  const TdTextButton.light({
    super.key,
    required this.onPressed,
    this.disabled = false,
    this.block = true,
    this.size = TdButtonSize.large,
    this.shape = TdButtonShape.rectangle,
    this.icon,
    required this.child,
  }) : type = TdButtonType.light;

  /// 点击事件
  final VoidCallback onPressed;

  /// 是否禁用按钮
  final bool disabled;

  /// 是否为块级元素
  final bool block;

  /// 尺寸类型
  final TdButtonSize size;

  /// 形状类型
  final TdButtonShape shape;

  /// 按钮类型
  final TdButtonType type;

  /// 图标
  final Widget? icon;

  /// 子元素
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = TdTheme.of(context);

    final Color textColor;
    final Color disabledTextColor;
    final Color backgroundColor;
    final Color actionBackgroundColor;
    final Color disabledBackgroundColor;

    switch (type) {
      case TdButtonType.normal:
        textColor = theme.textColorPrimary;
        disabledTextColor = theme.fontGray4;
      case TdButtonType.primary:
      case TdButtonType.light:
        textColor = theme.brandColor;
        disabledTextColor = theme.brandColorDisabled;
      case TdButtonType.danger:
        textColor = theme.errorColor;
        disabledTextColor = theme.errorColorDisabled;
    }
    backgroundColor = Colors.transparent;
    actionBackgroundColor = theme.backgroundColorComponent;
    disabledBackgroundColor = Colors.transparent;

    return _TdButtonContainer(
      onPressed: onPressed,
      disabled: disabled,
      block: block,
      size: size,
      shape: shape,
      textColor: textColor,
      disabledTextColor: disabledTextColor,
      backgroundColor: backgroundColor,
      actionBackgroundColor: actionBackgroundColor,
      disabledBackgroundColor: disabledBackgroundColor,
      borderRadius: theme.radiusDefault,
      icon: icon,
      child: child,
    );
  }
}

class TdOutlineButton extends StatelessWidget {
  const TdOutlineButton({
    super.key,
    required this.onPressed,
    this.disabled = false,
    this.block = true,
    this.size = TdButtonSize.large,
    this.shape = TdButtonShape.rectangle,
    this.type = TdButtonType.normal,
    this.icon,
    required this.child,
  });

  const TdOutlineButton.primary({
    super.key,
    required this.onPressed,
    this.disabled = false,
    this.block = true,
    this.size = TdButtonSize.large,
    this.shape = TdButtonShape.rectangle,
    this.icon,
    required this.child,
  }) : type = TdButtonType.primary;

  const TdOutlineButton.danger({
    super.key,
    required this.onPressed,
    this.disabled = false,
    this.block = true,
    this.size = TdButtonSize.large,
    this.shape = TdButtonShape.rectangle,
    this.icon,
    required this.child,
  }) : type = TdButtonType.danger;

  const TdOutlineButton.light({
    super.key,
    required this.onPressed,
    this.disabled = false,
    this.block = true,
    this.size = TdButtonSize.large,
    this.shape = TdButtonShape.rectangle,
    this.icon,
    required this.child,
  }) : type = TdButtonType.light;

  /// 点击事件
  final VoidCallback onPressed;

  /// 是否禁用按钮
  final bool disabled;

  /// 是否为块级元素
  final bool block;

  /// 尺寸类型
  final TdButtonSize size;

  /// 形状类型
  final TdButtonShape shape;

  /// 按钮类型
  final TdButtonType type;

  /// 图标
  final Widget? icon;

  /// 子元素
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = TdTheme.of(context);

    final Color textColor;
    final Color actionTextColor;
    final Color disabledTextColor;
    final Color backgroundColor;
    final Color actionBackgroundColor;
    final Color disabledBackgroundColor;
    final Color borderColor;
    final Color actionBorderColor;
    final Color disabledBorderColor;

    switch (type) {
      case TdButtonType.normal:
        textColor = theme.textColorPrimary;
        actionTextColor = theme.textColorPrimary;
        disabledTextColor = theme.fontGray4;
        backgroundColor = Colors.transparent;
        actionBackgroundColor = theme.backgroundColorComponent;
        disabledBackgroundColor = theme.backgroundColorComponentDisabled;
        borderColor = theme.componentBorder;
        actionBorderColor = theme.componentBorder;
        disabledBorderColor = theme.componentBorder;
      case TdButtonType.primary:
        textColor = theme.brandColor;
        actionTextColor = theme.brandColorActive;
        disabledTextColor = theme.brandColorDisabled;
        backgroundColor = Colors.transparent;
        actionBackgroundColor = theme.backgroundColorComponent;
        disabledBackgroundColor = Colors.transparent;
        borderColor = theme.brandColor;
        actionBorderColor = theme.brandColorActive;
        disabledBorderColor = theme.brandColorDisabled;
      case TdButtonType.danger:
        textColor = theme.errorColor;
        actionTextColor = theme.errorColorActive;
        disabledTextColor = theme.errorColorDisabled;
        backgroundColor = Colors.transparent;
        actionBackgroundColor = theme.backgroundColorComponent;
        disabledBackgroundColor = Colors.transparent;
        borderColor = theme.errorColor;
        actionBorderColor = theme.errorColorActive;
        disabledBorderColor = theme.errorColorDisabled;
      case TdButtonType.light:
        textColor = theme.brandColor;
        actionTextColor = theme.brandColorActive;
        disabledTextColor = theme.brandColorActive;
        backgroundColor = theme.brandColorLight;
        actionBackgroundColor = theme.brandColorDisabled;
        disabledBackgroundColor = Colors.transparent;
        borderColor = theme.brandColor;
        actionBorderColor = theme.brandColorActive;
        disabledBorderColor = theme.brandColorActive;
    }

    return _TdButtonContainer(
      onPressed: onPressed,
      disabled: disabled,
      block: block,
      size: size,
      shape: shape,
      textColor: textColor,
      actionTextColor: actionTextColor,
      disabledTextColor: disabledTextColor,
      backgroundColor: backgroundColor,
      actionBackgroundColor: actionBackgroundColor,
      disabledBackgroundColor: disabledBackgroundColor,
      borderColor: borderColor,
      actionBorderColor: actionBorderColor,
      disabledBorderColor: disabledBorderColor,
      borderRadius: theme.radiusDefault,
      icon: icon,
      child: child,
    );
  }
}

class TdIconButton extends StatelessWidget {
  const TdIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
  });

  /// 点击事件
  final VoidCallback onPressed;

  /// 图标
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    final theme = TdTheme.of(context);

    return TdRawButton(
      onPressed: onPressed,
      padding: EdgeInsets.all(theme.spacer1),
      borderRadius: theme.radiusDefault,
      iconTheme: IconThemeData(
        size: theme.spacer3,
      ),
      textColor: theme.textColorPrimary,
      backgroundColor: Colors.transparent,
      actionBackgroundColor: theme.backgroundColorComponent,
      child: icon,
    );
  }
}
