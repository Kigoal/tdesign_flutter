import 'package:flutter/widgets.dart';

class TdChangeNotifierSelector<T extends Listenable, S> extends StatefulWidget {
  const TdChangeNotifierSelector({
    super.key,
    required this.selector,
    required this.listenable,
    required this.builder,
    this.child,
  });

  /// 更新状态
  final S Function(BuildContext context, T model) selector;

  /// 当前值
  final T listenable;

  /// 子元素
  final ValueWidgetBuilder<S> builder;

  /// 子元素
  final Widget? child;

  @override
  State<TdChangeNotifierSelector<T, S>> createState() => _TdChangeNotifierSelectorState<T, S>();
}

class _TdChangeNotifierSelectorState<T extends Listenable, S> extends State<TdChangeNotifierSelector<T, S>> {
  /// 缓存状态
  S? _value;

  /// 缓存元素
  Widget? _child;

  /// 旧的元素
  Widget? _oldWidget;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.listenable,
      builder: (context, child) {
        final selector = widget.selector(context, widget.listenable);

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
