import 'package:flutter/widgets.dart';

class TdPickerItem<T> {
  const TdPickerItem({
    required this.value,
    required this.label,
  });

  TdPickerItem.value(this.value) : label = Text(value.toString());

  TdPickerItem.text(String label)
      : value = label as T,
        label = Text(label);

  final T value;

  final Widget label;
}
