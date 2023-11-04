import 'package:flutter/widgets.dart';

class TdCascaderItem<T> {
  const TdCascaderItem({
    required this.value,
    required this.label,
    this.child,
    this.children,
  });

  const TdCascaderItem.value({
    required this.value,
    required this.children,
  })  : label = '',
        child = null;

  const TdCascaderItem.custom({
    required this.value,
    String? label,
    required this.child,
    required this.children,
  }) : label = label ?? '';

  /// 值
  final T value;

  /// 标签
  final String label;

  /// 自定义元素
  final Widget? child;

  /// 子元素
  final List<TdCascaderItem<T>>? children;
}
