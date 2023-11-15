import 'package:flutter/material.dart';
import 'package:tdesign_icons_flutter/tdesign_icons_flutter.dart';

import '../theme/export.dart';
import './text_editing_controller.dart';

const kTdTextFieldMultipleMinLine = 3;
const kTdTextFieldMultipleMaxLine = 10;

class TdTextField extends StatefulWidget {
  TdTextField({
    super.key,
    this.onChanged,
    this.initialValue,
    this.controller,
    this.textAlign = TextAlign.start,
    this.readOnly = false,
    this.clearable = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.textCapitalization = TextCapitalization.none,
    this.maxLength,
    Icon? prefixIcon,
    Icon? suffixIcon,
    String? hintText,
    this.contentPadding,
    InputDecoration? decoration,
    this.autofocus = false,
    this.focusNode,
  })  : minLines = null,
        maxLines = 1,
        decoration = decoration ??
            InputDecoration(
              hintText: hintText,
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              border: InputBorder.none,
            );

  TdTextField.multiple({
    super.key,
    this.onChanged,
    this.initialValue,
    this.controller,
    this.textAlign = TextAlign.start,
    this.readOnly = false,
    this.clearable = false,
    this.keyboardType = TextInputType.multiline,
    this.textInputAction = TextInputAction.newline,
    this.textCapitalization = TextCapitalization.none,
    this.maxLength,
    this.minLines = kTdTextFieldMultipleMinLine,
    this.maxLines = kTdTextFieldMultipleMaxLine,
    Icon? prefixIcon,
    Icon? suffixIcon,
    String? hintText,
    this.contentPadding,
    InputDecoration? decoration,
    this.autofocus = false,
    this.focusNode,
  }) : decoration = decoration ??
            InputDecoration(
              hintText: hintText,
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              border: InputBorder.none,
            );

  /// 输入文本变化时回调
  final ValueChanged<String>? onChanged;

  /// 初始值
  final String? initialValue;

  /// 控制器
  final TextEditingController? controller;

  /// 文本内容位置
  final TextAlign textAlign;

  /// 是否只读输入框
  final bool readOnly;

  /// 是否可清空
  final bool clearable;

  /// 键盘输入类型
  final TextInputType keyboardType;

  /// 键盘主要按钮类型
  final TextInputAction textInputAction;

  /// 键盘大写模式
  final TextCapitalization textCapitalization;

  /// 最多允许输入字符数
  final int? maxLength;

  /// 最小行数
  final int? minLines;

  /// 最大行数
  final int? maxLines;

  /// 获取焦点
  final bool autofocus;

  /// 获取或者取消焦点使用
  final FocusNode? focusNode;

  /// 编辑框内边距
  final EdgeInsets? contentPadding;

  /// 输入框样式
  final InputDecoration decoration;

  @override
  State<TdTextField> createState() => _TdTextFieldState();
}

class _TdTextFieldState extends State<TdTextField> {
  TextEditingController? _controller;
  FocusNode? _focusNode;

  TextEditingController get _effectiveController => widget.controller ?? _controller!;
  FocusNode get _effectiveFocusNode => widget.focusNode ?? _focusNode!;

  /// 是否需要显示清除图标
  bool _showClearable = false;

  /// 是否需要显示密码图标
  bool _showPassword = false;

  /// 显示密码图标的状态
  bool _passwordState = false;

  /// 是否是多行文本
  bool get _isMultiple => (widget.maxLines ?? 1) > 1;

  /// 是否隐藏输入内容
  bool get _obscureText => widget.keyboardType == TextInputType.visiblePassword;

  @override
  void initState() {
    super.initState();

    if (widget.controller == null) {
      _controller = TdTextEditingController(text: widget.initialValue);
    }

    if (widget.focusNode == null) {
      _focusNode = FocusNode();
    }

    _effectiveController.addListener(_updateState);
    _effectiveFocusNode.addListener(_updateState);
  }

  @override
  void dispose() {
    _controller?.dispose();
    _focusNode?.dispose();

    super.dispose();
  }

  @override
  void didUpdateWidget(TdTextField oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.controller != null && oldWidget.controller == null) {
      _controller!.dispose();
      _controller = null;
    }

    if (widget.focusNode != null && oldWidget.focusNode == null) {
      _focusNode!.dispose();
      _focusNode = null;
    }
  }

  /// 更新图标状态
  void _updateState() {
    final clearableState = widget.clearable && _effectiveController.text.isNotEmpty && _effectiveFocusNode.hasFocus;

    final passwordState = widget.keyboardType == TextInputType.visiblePassword && _effectiveFocusNode.hasFocus;

    if (_showClearable != clearableState || _showPassword != passwordState) {
      setState(() {
        _showClearable = clearableState;
        _showPassword = passwordState;
      });
    }
  }

  /// 清除输入框内容
  void _hanldeClearable() {
    _effectiveController.clear();

    if (!_effectiveFocusNode.hasFocus && _effectiveFocusNode.canRequestFocus) {
      _effectiveFocusNode.requestFocus();
    }
  }

  /// 清除图标
  Widget _buildClearableIcon(TdThemeData theme) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _hanldeClearable,
      child: Icon(
        TdIcons.close_circle_filled,
        size: theme.spacer3,
        color: theme.textColorPlaceholder,
      ),
    );
  }

  /// 显示密码图标
  Widget _buildPasswordIcon(TdThemeData theme) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        setState(() {
          _passwordState = !_passwordState;
        });
      },
      child: Icon(
        _passwordState ? TdIcons.browse : TdIcons.browse_off,
        size: theme.spacer3,
        color: theme.textColorPlaceholder,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = TdTheme.of(context);

    Widget? suffixIcon;
    if (_showPassword) {
      suffixIcon = _buildPasswordIcon(theme);
    } else if (_showClearable) {
      suffixIcon = _buildClearableIcon(theme);
    }

    final decoration = widget.decoration
        .applyDefaults(InputDecorationTheme(
          isCollapsed: !_isMultiple,
          contentPadding: widget.contentPadding ?? EdgeInsets.all(theme.spacer1),
          hintStyle: theme.fontM.copyWith(
            color: theme.textColorPlaceholder,
          ),
        ))
        .copyWith(
          suffixIcon: suffixIcon,
          counterText: '',
        );

    return TextField(
      onChanged: widget.onChanged,
      controller: _effectiveController,
      focusNode: _effectiveFocusNode,
      style: theme.fontM.copyWith(
        color: theme.textColorPrimary,
      ),
      cursorColor: theme.brandColor,
      textAlign: widget.textAlign,
      decoration: decoration,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      textCapitalization: widget.textCapitalization,
      obscureText: _passwordState ? false : _obscureText,
      maxLength: widget.maxLength,
      minLines: widget.minLines,
      maxLines: widget.maxLines,
      readOnly: widget.readOnly,
    );
  }
}
