import 'package:flutter/widgets.dart';

class TdTabController extends ChangeNotifier {
  TdTabController({
    int initialIndex = 0,
    required this.length,
    required TickerProvider vsync,
  })  : _index = initialIndex,
        _animationController = AnimationController.unbounded(
          value: initialIndex.toDouble(),
          duration: const Duration(milliseconds: 300),
          vsync: vsync,
        );

  int _index;
  int get index => _index;
  set index(int value) {
    animateTo(value);
  }

  int length;

  bool get indexIsChanging => _indexIsChangingCount != 0;
  int _indexIsChangingCount = 0;

  Animation<double>? get animation => _animationController?.view;
  final AnimationController? _animationController;

  void animateTo(int value, {Duration? duration, Curve curve = Curves.ease}) {
    if (value == _index) {
      return;
    }

    _index = value;

    _indexIsChangingCount += 1;

    notifyListeners();

    _animationController!
        .animateTo(
      _index.toDouble(),
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    )
        .whenCompleteOrCancel(() {
      if (_animationController != null) {
        _indexIsChangingCount -= 1;

        notifyListeners();
      }
    });
  }

  double get offset => _animationController!.value - _index.toDouble();
  set offset(double value) {
    if (value == offset) {
      return;
    }
    _animationController!.value = value + _index.toDouble();
  }
}
