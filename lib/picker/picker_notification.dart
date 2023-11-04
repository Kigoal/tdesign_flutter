import 'package:flutter/widgets.dart';

class TdPickerNotification<T> extends Notification {
  const TdPickerNotification({
    required this.value,
  });

  final T value;
}
