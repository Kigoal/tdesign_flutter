import 'package:flutter/material.dart';

import '../theme/export.dart';
import '../cell/export.dart';
import './form_theme.dart';

enum TdFormItemAlign {
  start,
  center,
  end,
}

class TdFormItem extends StatelessWidget {
  const TdFormItem({
    super.key,
    this.direction,
    this.label,
    this.labelWidth,
    this.labelAlign,
    this.help,
    this.errorMessage,
    this.contentAlign = TdFormItemAlign.start,
    required this.child,
  });

  /// 布局方式
  final Axis? direction;

  /// 字段标签名称
  final Widget? label;

  /// 字段标签的宽度
  final double? labelWidth;

  /// 字段标签的对齐方式
  final TextAlign? labelAlign;

  /// 表单项说明内容
  final Widget? help;

  /// 校验失败的错误提示
  final Widget? errorMessage;

  /// 表单内容对齐方式
  final TdFormItemAlign contentAlign;

  /// 子控件
  final Widget child;

  CrossAxisAlignment get _contentAlign {
    switch (contentAlign) {
      case TdFormItemAlign.start:
        return CrossAxisAlignment.start;
      case TdFormItemAlign.center:
        return CrossAxisAlignment.center;
      case TdFormItemAlign.end:
        return CrossAxisAlignment.end;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = TdTheme.of(context);

    final formTheme = TdFormTheme.of(context);

    Widget? labelWidget;
    if (label != null) {
      labelWidget = DefaultTextStyle(
        textAlign: labelAlign ?? formTheme.labelAlign,
        style: theme.fontM.copyWith(color: theme.textColorPrimary),
        child: label!,
      );
    }

    Widget? helpWidget;
    if (help != null) {
      helpWidget = Padding(
        padding: EdgeInsets.only(top: theme.spacer / 2),
        child: DefaultTextStyle(
          style: theme.fontBase.copyWith(
            color: theme.textColorPlaceholder,
          ),
          child: help!,
        ),
      );
    }

    Widget? errorMessageWidget;
    if (errorMessage != null) {
      errorMessageWidget = Padding(
        padding: EdgeInsets.only(top: theme.spacer / 2),
        child: DefaultTextStyle(
          style: theme.fontBase.copyWith(color: theme.errorColor),
          child: errorMessage!,
        ),
      );
    }

    final Widget childWidget;
    switch (direction ?? Axis.horizontal) {
      case Axis.horizontal:
        childWidget = _TdFormItemHorizontalStyle(
          contentAlign: _contentAlign,
          label: labelWidget,
          labelWidth: labelWidth ?? formTheme.labelWidth,
          labelAlign: labelAlign ?? formTheme.labelAlign,
          help: helpWidget,
          errorMessage: errorMessageWidget,
          child: child,
        );
      case Axis.vertical:
        childWidget = _TdFormItemVerticalStyle(
          contentAlign: _contentAlign,
          label: labelWidget,
          labelAlign: labelAlign ?? formTheme.labelAlign,
          help: helpWidget,
          errorMessage: errorMessageWidget,
          child: child,
        );
    }

    return TdCellView(
      padding: EdgeInsets.symmetric(
        horizontal: theme.spacer2,
      ),
      child: childWidget,
    );
  }
}

class _TdFormItemHorizontalStyle extends StatelessWidget {
  const _TdFormItemHorizontalStyle({
    required this.contentAlign,
    this.label,
    this.labelWidth,
    this.labelAlign,
    this.help,
    this.errorMessage,
    required this.child,
  });

  final CrossAxisAlignment contentAlign;

  final Widget? label;

  final double? labelWidth;

  final TextAlign? labelAlign;

  final Widget? help;

  final Widget? errorMessage;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = TdTheme.of(context);

    Widget? labelWidget;
    if (label != null) {
      labelWidget = Container(
        width: labelWidth,
        margin: EdgeInsets.only(right: theme.spacer2),
        padding: EdgeInsets.symmetric(vertical: theme.spacer1),
        child: label,
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelWidget != null) labelWidget,
        Expanded(
          child: Column(
            crossAxisAlignment: contentAlign,
            children: [
              child,
              if (help != null) help!,
              if (errorMessage != null) errorMessage!,
            ],
          ),
        ),
      ],
    );
  }
}

class _TdFormItemVerticalStyle extends StatelessWidget {
  const _TdFormItemVerticalStyle({
    required this.contentAlign,
    this.label,
    this.labelAlign,
    this.help,
    this.errorMessage,
    required this.child,
  });

  final CrossAxisAlignment contentAlign;

  final Widget? label;

  final TextAlign? labelAlign;

  final Widget? help;

  final Widget? errorMessage;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = TdTheme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Padding(
            padding: EdgeInsets.only(
              top: theme.spacer1,
              bottom: theme.spacer / 2,
            ),
            child: label!,
          ),
        Column(
          crossAxisAlignment: contentAlign,
          children: [
            child,
            if (help != null) help!,
            if (errorMessage != null) errorMessage!,
          ],
        ),
      ],
    );
  }
}
