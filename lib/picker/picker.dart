import 'dart:async';

import 'package:flutter/widgets.dart';

import '../theme/export.dart';
import '../popup/export.dart';
import './picker_notification.dart';
import './picker_column.dart';
import './picker_item.dart';
import './interface.dart';

typedef TdPickerChange<T> = void Function(List<T?> value);

typedef TdPickerSelectedItemChange = void Function(int index, int value);

class TdPicker<T> extends StatefulWidget {
  factory TdPicker({
    Key? key,
    ValueChanged<T>? onChanged,
    T? initialValue,
    required List<TdPickerItem<T>> children,
  }) {
    return TdPicker.multiple(
      key: key,
      onChanged: (value) {
        onChanged?.call(value[0] as T);
      },
      children: [
        TdPickerColumn<T>(
          initialValue: initialValue,
          children: children,
        ),
      ],
    );
  }

  const TdPicker.multiple({
    super.key,
    this.onChanged,
    required this.children,
  });

  /// 确认事件
  final TdPickerChange<T>? onChanged;

  /// 子元素
  final List<Widget> children;

  @override
  State<TdPicker> createState() => _TdPickerState<T>();
}

class _TdPickerState<T> extends State<TdPicker<T>> {
  late List<T?> _selectedIndex;

  @override
  void initState() {
    super.initState();

    _selectedIndex = List.generate(widget.children.length, (index) => null);
  }

  Widget _buildSelectionOverlay(TdThemeData theme) {
    return IgnorePointer(
      child: Container(
        height: kPickerItemHeight,
        margin: EdgeInsets.symmetric(horizontal: theme.spacer2),
        decoration: BoxDecoration(
          color: theme.backgroundColorSecondaryContainer,
          borderRadius: theme.radiusDefault,
        ),
      ),
    );
  }

  Widget _buildColumn(int index) {
    return NotificationListener<TdPickerNotification<T>>(
      onNotification: (notification) {
        _selectedIndex[index] = notification.value;

        widget.onChanged?.call(_selectedIndex);

        return true;
      },
      child: widget.children[index],
    );
  }

  Widget _buildContent(TdThemeData theme) {
    const height = kPickerItemHeight * kPickerItemCount;

    final List<Widget> list = [];

    for (var i = 0; i < widget.children.length; i++) {
      list.add(Expanded(
        child: _buildColumn(i),
      ));
    }

    return Container(
      height: height,
      padding: EdgeInsets.symmetric(
        horizontal: theme.spacer4,
      ),
      child: Row(
        children: list,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = TdTheme.of(context);

    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        _buildSelectionOverlay(theme),
        _buildContent(theme),
      ],
    );
  }
}

class TdPickerPlugin {
  static Future<T?> open<T>(
    T? initialValue, {
    Widget? title,
    required List<TdPickerItem<T>> options,
  }) {
    final completer = Completer<T?>();

    T? value = initialValue;

    TdPopupPlugin.open(
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TdPopupAppbar(
              title: title,
              confirm: const Text('确定'),
              onConfirm: () {
                TdPopupPlugin.pop();

                completer.complete(value);
              },
              cancel: const Text('取消'),
              onCancel: () {
                TdPopupPlugin.pop();

                completer.complete();
              },
            ),
            TdPicker<T>(
              onChanged: (newValue) {
                value = newValue;
              },
              initialValue: initialValue,
              children: options,
            ),
          ],
        );
      },
    );

    return completer.future;
  }
}
