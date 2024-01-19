import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/export.dart';
import './picker_notification.dart';
import './picker_item.dart';
import './interface.dart';

class TdPickerColumn<T> extends StatefulWidget {
  const TdPickerColumn({
    super.key,
    this.initialValue,
    this.onSelectedItemChanged,
    this.controller,
    required this.children,
  });

  /// 初始值
  final T? initialValue;

  /// 选择项改变事件
  final ValueChanged<T>? onSelectedItemChanged;

  /// 控制器
  final FixedExtentScrollController? controller;

  /// 子元素
  final List<TdPickerItem<T>> children;

  @override
  State<TdPickerColumn<T>> createState() => _TdPickerColumnState<T>();
}

class _TdPickerColumnState<T> extends State<TdPickerColumn<T>> {
  FixedExtentScrollController? _controller;

  FixedExtentScrollController? get _effectiveController =>
      widget.controller ?? _controller;

  bool isEmpty = false;

  @override
  void initState() {
    super.initState();

    if (widget.controller == null) {
      final initialValue = widget.initialValue;

      _controller = FixedExtentScrollController(
          initialItem: initialValue != null ? _getIndex(initialValue) : 0);

      /// 如果没有初始值时默认使用第一条数据
      if (initialValue == null) {
        _handleNotification(0);
      }
    }
  }

  @override
  void didUpdateWidget(TdPickerColumn<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.controller != oldWidget.controller) {
      if (oldWidget.controller != null && widget.controller == null) {
        _controller = FixedExtentScrollController(
            initialItem: oldWidget.controller!.selectedItem);
      }

      if (oldWidget.controller == null && widget.controller != null) {
        _controller = null;
      }
    }
  }

  int _getIndex(T value, [int defaultValue = 0]) {
    final list = widget.children;

    for (var i = 0; i < list.length; i++) {
      if (list[i].value == value) {
        return i;
      }
    }

    return defaultValue;
  }

  T _getValue(int index) {
    return widget.children[index].value;
  }

  void _handleSelectedItemChanged(int index) {
    _handleHaptic();

    _handleNotification(index);

    setState(() {});
  }

  void _handleNotification(int index) {
    final value = _getValue(index);

    widget.onSelectedItemChanged?.call(value);

    /// 向上冒泡通知
    TdPickerNotification(value: value).dispatch(context);
  }

  void _handleHaptic() {
    final bool hasSuitableHapticHardware;

    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
        hasSuitableHapticHardware = true;
        break;
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
        hasSuitableHapticHardware = false;
        break;
    }

    if (hasSuitableHapticHardware) {
      HapticFeedback.selectionClick();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = TdTheme.of(context);

    return ListWheelScrollView.useDelegate(
      controller: _effectiveController,
      physics: const FixedExtentScrollPhysics(),
      itemExtent: kPickerItemHeight,
      onSelectedItemChanged: _handleSelectedItemChanged,
      childDelegate: ListWheelChildBuilderDelegate(
        childCount: widget.children.length,
        builder: (context, index) {
          final selectedIndex = _effectiveController!.selectedItem;
          final item = widget.children[index];

          final fontWeight =
              selectedIndex == index ? FontWeight.w600 : FontWeight.normal;

          final child = item.label;

          return Center(
            child: DefaultTextStyle(
              style: theme.fontM.copyWith(
                color: theme.textColorPrimary,
                fontWeight: fontWeight,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              child: child,
            ),
          );
        },
      ),
    );
  }
}
