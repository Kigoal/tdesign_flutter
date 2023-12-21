import 'package:flutter/widgets.dart';

class TdFocus extends StatefulWidget {
  const TdFocus({
    super.key,
    this.onTapDown,
    this.onTapUp,
    this.onTap,
    this.onTapCancel,
    this.debugLabel,
    this.focusNode,
    this.canRequestFocus,
    this.skipTraversal,
    required this.child,
  });

  final GestureTapCallback? onTap;

  final GestureTapDownCallback? onTapDown;

  final GestureTapUpCallback? onTapUp;

  final GestureTapCallback? onTapCancel;

  /// 标签
  final String? debugLabel;

  /// 焦点控制器
  final FocusNode? focusNode;

  /// 是否能获取焦点
  final bool? canRequestFocus;

  /// 是否跳过焦点
  final bool? skipTraversal;

  /// 子元素
  final Widget child;

  @override
  State<TdFocus> createState() => _TdFocusState();
}

class _TdFocusState extends State<TdFocus> {
  FocusNode? _focus;

  FocusNode? get _effectiveFocus => widget.focusNode ?? _focus;

  String get _debugLabel => widget.debugLabel ?? 'TdFocus';

  @override
  void initState() {
    super.initState();

    if (widget.focusNode == null) {
      _focus = FocusNode();
    }
  }

  @override
  void didUpdateWidget(TdFocus oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.focusNode == null && oldWidget.focusNode != null) {
      _focus = FocusNode();
    } else if (widget.focusNode != null && oldWidget.focusNode == null) {
      _focus!.dispose();
      _focus = null;
    }
  }

  @override
  void dispose() {
    _focus?.dispose();

    super.dispose();
  }

  /// 请求焦点
  void _requestFocus() {
    if (_effectiveFocus!.canRequestFocus) {
      _effectiveFocus!.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _requestFocus();

        widget.onTap?.call();
      },
      onTapDown: widget.onTapDown,
      onTapUp: widget.onTapUp,
      onTapCancel: widget.onTapCancel,
      behavior: HitTestBehavior.opaque,
      child: Focus(
        debugLabel: _debugLabel,
        focusNode: _effectiveFocus!,
        canRequestFocus: widget.canRequestFocus,
        skipTraversal: widget.skipTraversal,
        child: widget.child,
      ),
    );
  }
}
