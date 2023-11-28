import 'package:flutter/widgets.dart';

class TdValueNotifierSelector<T, S> extends StatefulWidget {
  const TdValueNotifierSelector({
    super.key,
    required this.selector,
    required this.value,
    required this.builder,
    this.child,
  });

  /// 更新状态
  final S Function(BuildContext context) selector;

  /// 当前值
  final ValueNotifier<T> value;

  /// 子元素
  final ValueWidgetBuilder<S> builder;

  /// 子元素
  final Widget? child;

  @override
  State<TdValueNotifierSelector<T, S>> createState() => _TdValueNotifierSelectorState<T, S>();
}

class _TdValueNotifierSelectorState<T, S> extends State<TdValueNotifierSelector<T, S>> {
  /// 缓存状态
  S? _value;

  /// 缓存元素
  Widget? _child;

  /// 旧的元素
  Widget? _oldWidget;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.value,
      builder: (context, value, child) {
        final selector = widget.selector(context);

        if (widget != _oldWidget || selector != _value) {
          _value = selector;
          _oldWidget = widget;
          _child = widget.builder(context, selector, child!);
        }

        return _child!;
      },
      child: widget.child,
    );
  }
}
