import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:tdesign_icons_flutter/tdesign_icons_flutter.dart';

import '../focus/export.dart';
import '../theme/export.dart';

typedef TdCheckboxChangedCallback<T> = void Function(bool checked, T? value);

class TdCheckbox<T> extends StatefulWidget {
  const TdCheckbox({
    super.key,
    this.initialChecked,
    required this.onChanged,
    this.value,
    this.disabled = false,
    this.block = true,
    this.padding,
    required this.child,
  });

  /// 初始是否选中
  final bool? initialChecked;

  /// 点击事件
  final TdCheckboxChangedCallback<T> onChanged;

  /// 绑定值
  final T? value;

  /// 是否禁用
  final bool disabled;

  /// 是否为块级元素
  final bool block;

  /// 内边距
  final EdgeInsetsGeometry? padding;

  /// 子元素
  final Widget child;

  @override
  State<TdCheckbox<T>> createState() => _TdCheckboxState<T>();
}

class _TdCheckboxState<T> extends State<TdCheckbox<T>> {
  bool _isActive = false;

  late final ValueNotifier<bool> _checked;

  @override
  void initState() {
    super.initState();

    _checked = ValueNotifier(widget.initialChecked ?? false);
  }

  @override
  void dispose() {
    _checked.dispose();

    super.dispose();
  }

  void _setActive(bool value) {
    if (!widget.disabled && _isActive != value) {
      setState(() {
        _isActive = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = TdTheme.of(context);

    return TdFocus(
      onTap: () {
        if (!widget.disabled) {
          _checked.value = !_checked.value;
          widget.onChanged(_checked.value, widget.value);
        }
      },
      onTapDown: (details) {
        _setActive(true);
      },
      onTapUp: (details) {
        _setActive(false);
      },
      onTapCancel: () {
        _setActive(false);
      },
      debugLabel: 'TdCheckbox',
      canRequestFocus: !widget.disabled,
      child: ColoredBox(
        color: _isActive ? theme.backgroundColorContainerActive : theme.backgroundColorContainer,
        child: Padding(
          padding: widget.padding ?? EdgeInsets.all(theme.spacer2),
          child: Row(
            mainAxisSize: widget.block ? MainAxisSize.max : MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  right: theme.spacer,
                ),
                child: ValueListenableBuilder(
                  valueListenable: _checked,
                  builder: (context, value, child) {
                    return switch (value) {
                      true => IconTheme(
                          data: IconThemeData(
                            color: theme.textColorBrand,
                            size: theme.spacer3,
                          ),
                          child: const Icon(TdIcons.check_circle_filled),
                        ),
                      false => IconTheme(
                          data: IconThemeData(
                            color: theme.textColorSecondary,
                            size: theme.spacer3,
                          ),
                          child: const Icon(TdIcons.circle),
                        ),
                    };
                  },
                ),
              ),
              Expanded(
                child: DefaultTextStyle(
                  style: theme.fontM.copyWith(
                    color: theme.textColorPrimary,
                  ),
                  child: widget.child,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
