import 'package:flutter/material.dart';

import '../picker/export.dart';
import '../popup/export.dart';

enum TdDateTimePickerMode {
  date,
  hourAndMinute,
}

class TdDateTimePicker extends StatefulWidget {
  const TdDateTimePicker({
    super.key,
    this.initialValue,
    this.start,
    this.end,
    this.mode = TdDateTimePickerMode.values,
    this.onChanged,
    this.onSelectedItemChanged,
  });

  TdDateTimePicker.date({
    super.key,
    this.initialValue,
    this.start,
    this.end,
    this.onChanged,
    this.onSelectedItemChanged,
  }) : mode = [TdDateTimePickerMode.date];

  TdDateTimePicker.time({
    super.key,
    this.initialValue,
    this.start,
    this.end,
    this.onChanged,
    this.onSelectedItemChanged,
  }) : mode = [TdDateTimePickerMode.hourAndMinute];

  /// 选中值
  final DateTime? initialValue;

  /// 最小可选择日期
  final DateTime? start;

  /// 最大可选择日期
  final DateTime? end;

  /// 显示的模式
  final List<TdDateTimePickerMode> mode;

  /// 确认事件
  final ValueChanged<DateTime>? onChanged;

  /// 选择项改变事件
  final TdPickerSelectedItemChange? onSelectedItemChanged;

  static String format(DateTime date, List<TdDateTimePickerMode> mode) {
    List<String> list = [];

    if (mode.any((item) => item == TdDateTimePickerMode.date)) {
      list.add([
        date.year.toString(),
        date.month.toString().padLeft(2, '0'),
        date.day.toString().padLeft(2, '0'),
      ].join('-'));
    }

    if (mode.any((item) => item == TdDateTimePickerMode.hourAndMinute)) {
      list.add([
        date.hour.toString().padLeft(2, '0'),
        date.minute.toString().padLeft(2, '0'),
      ].join(':'));
    }

    return list.join(' ');
  }

  static String formatDate(DateTime date) {
    return format(date, [TdDateTimePickerMode.date]);
  }

    static String formatHourAndMinute(DateTime date) {
    return format(date, [TdDateTimePickerMode.hourAndMinute]);
  }

  /// 获取下一个月的第0天，也就是当月的最后一天
  static int lastDayOfMonth(int year, int month) {
    return DateTime(year, month + 1, 0).day;
  }

  @override
  State<TdDateTimePicker> createState() => _TdDateTimePickerState();
}

class _TdDateTimePickerState extends State<TdDateTimePicker> {
  late final FixedExtentScrollController _dayController;

  late final DateTime _effectiveStart;
  late final DateTime _effectiveEnd;

  late DateTime _selectedValue;
  late int _maxDay;

  bool _hasMode(TdDateTimePickerMode mode) => widget.mode.any((item) => item == mode);

  bool get _isDateMode => _hasMode(TdDateTimePickerMode.date);

  bool get _isTimeMode => _hasMode(TdDateTimePickerMode.hourAndMinute);

  @override
  void initState() {
    super.initState();

    _selectedValue = widget.initialValue ?? DateTime.now();
    _maxDay = TdDateTimePicker.lastDayOfMonth(_selectedValue.year, _selectedValue.month);

    _dayController = FixedExtentScrollController(initialItem: _selectedValue.day - 1);

    _effectiveStart = widget.start ?? DateTime(1900);
    _effectiveEnd = widget.end ?? DateTime(2099, 12, 31, 23, 59, 59);

    if (widget.initialValue == null) {
      _handleChanged();
    }
  }

  @override
  void dispose() {
    _dayController.dispose();

    super.dispose();
  }

  void _handleChanged() {
    widget.onChanged?.call(_selectedValue);
  }

  TdPickerColumn _buildColumn({
    required int start,
    required int count,
    required String label,
    int? initialValue,
    FixedExtentScrollController? controller,
    required ValueChanged<int> onSelectedItemChanged,
  }) {
    final List<TdPickerItem<int>> list = [];

    for (var i = 0; i < count; i++) {
      final value = start + i;

      list.add(TdPickerItem(value: value, label: Text('$value$label')));
    }

    return TdPickerColumn<int>(
      initialValue: initialValue,
      controller: controller,
      onSelectedItemChanged: onSelectedItemChanged,
      children: list,
    );
  }

  TdPickerColumn _buildYearColumn() {
    final start = _effectiveStart.year;
    final count = _effectiveEnd.year - _effectiveStart.year + 1;

    return _buildColumn(
      start: start,
      count: count,
      label: '年',
      initialValue: _selectedValue.year,
      onSelectedItemChanged: (value) {
        final oldMaxDay = _maxDay;

        _maxDay = TdDateTimePicker.lastDayOfMonth(value, _selectedValue.month);

        final hasUpdate = _selectedValue.day > _maxDay;

        _selectedValue = _selectedValue.copyWith(
          year: value,
          day: hasUpdate ? _maxDay : null,
        );

        if (hasUpdate) {
          _dayController.jumpToItem(_maxDay - 1);
        }

        if (oldMaxDay != _maxDay) {
          setState(() {});
        }
      },
    );
  }

  TdPickerColumn _buildMonthColumn() {
    return _buildColumn(
      start: 1,
      count: 12,
      label: '月',
      initialValue: _selectedValue.month,
      onSelectedItemChanged: (value) {
        final oldMaxDay = _maxDay;

        _maxDay = TdDateTimePicker.lastDayOfMonth(_selectedValue.year, value);

        final hasUpdate = _selectedValue.day > _maxDay;

        _selectedValue = _selectedValue.copyWith(
          month: value,
          day: hasUpdate ? _maxDay : null,
        );

        if (hasUpdate) {
          _dayController.jumpToItem(_maxDay - 1);
        }

        if (oldMaxDay != _maxDay) {
          setState(() {});
        }
      },
    );
  }

  TdPickerColumn _buildDayColumn() {
    return _buildColumn(
      start: 1,
      count: _maxDay,
      label: '日',
      // initialValue: _selectedValue.day,
      controller: _dayController,
      onSelectedItemChanged: (value) {
        _selectedValue = _selectedValue.copyWith(day: value);
      },
    );
  }

  TdPickerColumn _buildHourColumn() {
    return _buildColumn(
      start: 0,
      count: 24,
      label: '时',
      initialValue: _selectedValue.hour,
      onSelectedItemChanged: (value) {
        _selectedValue = _selectedValue.copyWith(hour: value);
      },
    );
  }

  TdPickerColumn _buildMinuteColumn() {
    return _buildColumn(
      start: 0,
      count: 60,
      label: '分',
      initialValue: _selectedValue.minute,
      onSelectedItemChanged: (value) {
        _selectedValue = _selectedValue.copyWith(minute: value);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<TdPickerColumn> list = [];

    if (_isDateMode) {
      list.add(_buildYearColumn());
      list.add(_buildMonthColumn());
      list.add(_buildDayColumn());
    }

    if (_isTimeMode) {
      list.add(_buildHourColumn());
      list.add(_buildMinuteColumn());
    }

    return TdPicker<int>.multiple(
      onChanged: (value) {
        _handleChanged();
      },
      children: list,
    );
  }
}

void showTdDateTimePicker({
  required BuildContext context,
  DateTime? initialValue,
  ValueChanged<DateTime?>? onChanged,
  List<TdDateTimePickerMode> mode = TdDateTimePickerMode.values,
  Widget? title,
}) {
  DateTime? value = initialValue;

  showTdPopup(
    context: context,
    builder: (context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TdPopupAppbar(
            title: title,
            confirm: const Text('确定'),
            onConfirm: () {
              onChanged?.call(value);

              popTdPopup(context);
            },
            cancel: const Text('取消'),
            onCancel: () {
              popTdPopup(context);
            },
          ),
          TdDateTimePicker(
            onChanged: (newValue) {
              value = newValue;
            },
            initialValue: initialValue,
            mode: mode,
          ),
        ],
      );
    },
  );
}
