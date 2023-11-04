import 'dart:ui';

import 'package:flutter/material.dart';

import './tab_controller.dart';

class TdTabsView extends StatefulWidget {
  const TdTabsView({
    super.key,
    this.controller,
    required this.children,
  });

  final TdTabController? controller;

  final List<Widget> children;

  @override
  State<TdTabsView> createState() => _TdTabsViewState();
}

class _TdTabsViewState extends State<TdTabsView> {
  late List<Widget> _childrenWithKey;
  late PageController _pageController;

  /// 防止页面切换时事件同时触发
  int _warpUnderwayCount = 0;

  /// 防止页面滚动时事件同时触发
  int _scrollUnderwayCount = 0;

  TdTabController? get _effectiveController => widget.controller;

  int? _currentIndex;

  bool get _controllerIsValid => _effectiveController?.animation != null;

  @override
  void initState() {
    super.initState();

    _updateChildren();

    // _currentIndex = _effectiveController!.index;
    // _pageController = PageController(initialPage: _currentIndex!);

    // _effectiveController!.animation!
    //     .addListener(_handleTabControllerAnimationTick);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // _updateTabController();
    _currentIndex = _effectiveController!.index;

    _pageController = PageController(initialPage: _currentIndex!);

    _effectiveController!.animation!
        .addListener(_handleTabControllerAnimationTick);
  }

  @override
  void didUpdateWidget(TdTabsView oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleTabControllerAnimationTick);
      widget.controller?.addListener(_handleTabControllerAnimationTick);

      _currentIndex = _effectiveController!.index;
      _jumpToPage(_currentIndex!);
    }

    // While a warp is under way, we stop updating the tab page contents.
    // This is tracked in https://github.com/flutter/flutter/issues/31269.
    if (widget.children != oldWidget.children && _warpUnderwayCount == 0) {
      _updateChildren();
    }
  }

  @override
  void dispose() {
    _effectiveController?.removeListener(_handleTabControllerAnimationTick);

    _pageController.dispose();

    super.dispose();
  }

  /// 更新子元素，用key进行包裹
  void _updateChildren() {
    _childrenWithKey = KeyedSubtree.ensureUniqueKeysForList(widget.children);
  }

  /// 跳转页面
  void _jumpToPage(int page) {
    _warpUnderwayCount += 1;

    _pageController.jumpToPage(page);

    _warpUnderwayCount -= 1;
  }

  /// 动画跳转页面
  Future<void> _animateToPage(int page) async {
    _warpUnderwayCount += 1;

    await _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );

    _warpUnderwayCount -= 1;
  }

  /// tabController的动画事件
  void _handleTabControllerAnimationTick() {
    // 在滚动中或动画中时忽略处理
    if (_scrollUnderwayCount > 0 || !_effectiveController!.indexIsChanging) {
      return;
    }

    // 跳转到新页面
    if (_effectiveController!.index != _currentIndex) {
      _currentIndex = _effectiveController!.index;

      _animateToPage(_currentIndex!);
    }
  }

  /// 更新tabController的偏移位置
  void _syncControllerOffset() {
    _effectiveController!.offset = clampDouble(
        _pageController.page! - _effectiveController!.index, -1.0, 1.0);
  }

  /// 页面滚动事件
  bool _handleScrollNotification(ScrollNotification notification) {
    if (_warpUnderwayCount > 0 || _scrollUnderwayCount > 0) {
      return false;
    }

    if (!_controllerIsValid) {
      return false;
    }

    if (notification.depth != 0) {
      return false;
    }

    _scrollUnderwayCount += 1;

    if (notification is ScrollUpdateNotification) {
      // 当滑动距离大于一页的时候更新tab索引
      final hasPageChanged =
          (_pageController.page! - _effectiveController!.index).abs() > 1.0;

      if (hasPageChanged) {
        final pageIndex = _pageController.page!.round();

        _effectiveController!.index = pageIndex;
        _currentIndex = pageIndex;
      }

      _syncControllerOffset();
    } else if (notification is ScrollEndNotification) {
      final pageIndex = _pageController.page!.round();

      _effectiveController!.index = pageIndex;
      _currentIndex = pageIndex;

      if (!_effectiveController!.indexIsChanging) {
        _syncControllerOffset();
      }
    }

    _scrollUnderwayCount -= 1;

    return false;
  }

  @override
  Widget build(BuildContext context) {
    // TabBarView();

    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: PageView(
        controller: _pageController,
        children: _childrenWithKey,
      ),
    );
  }
}
