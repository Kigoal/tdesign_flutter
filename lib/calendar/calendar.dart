import 'package:flutter/widgets.dart';
import 'package:tdesign_icons_flutter/tdesign_icons_flutter.dart';

import '../common/export.dart' show TdValueNotifierSelector;
import '../date_time_picker/export.dart';
import '../theme/export.dart';

/// 默认星期文本
const _kCalendarWeekList = [
  Text('周日'),
  Text('周一'),
  Text('周二'),
  Text('周三'),
  Text('周四'),
  Text('周五'),
  Text('周六'),
];

/// 每行显示条数
const _kCalendarCrossAxisCount = 7;

enum _TdCalendarDayState {
  /// 默认样式，工作日
  normal,

  /// 提示样式，周末
  placeholder,

  /// 激活样式，当前选中
  activation,

  /// 高亮样式，当前日期
  highlight,
}

class TdCalendar extends StatefulWidget {
  const TdCalendar({
    super.key,
    this.onChanged,
    this.initialValue,
  });

  /// 改变事件
  final ValueChanged<DateTime>? onChanged;

  /// 当前选择日期
  final DateTime? initialValue;

  @override
  State<TdCalendar> createState() => _TdCalendarState();
}

class _TdCalendarState extends State<TdCalendar> {
  /// 当前选择日期
  late ValueNotifier<DateTime> _value;

  /// 现在日期
  late DateTime _currentDate;

  late PageController _pageController;

  late ValueNotifier<int> _page;

  late ValueNotifier<DateTime> _pageDate;

  @override
  void initState() {
    super.initState();

    _currentDate = DateTime.now();

    _value = ValueNotifier(widget.initialValue ?? _currentDate)..addListener(_handleSelected);

    _pageController = PageController(
      initialPage: _dateToPage(_value.value),
    );

    _page = ValueNotifier(_pageController.initialPage);
    _pageDate = ValueNotifier(_value.value);
  }

  @override
  void dispose() {
    _value.removeListener(_handleSelected);
    _value.dispose();

    _pageController.dispose();
    _page.dispose();
    _pageDate.dispose();

    super.dispose();
  }

  /// 日期转索引
  int _dateToPage(DateTime date) {
    return (date.year - 1900) * 12 + date.month - 1;
  }

  /// 索引转日期
  DateTime _pageToDate(int page) {
    return DateTime(1900 + (page / 12).truncate(), page % 12 + 1);
  }

  /// 1900-1 至 2099-12
  int get _getPageCount => 200 * 12;

  /// 当前选中值改变事件
  void _handleSelected() {
    widget.onChanged?.call(_value.value);
  }

  /// 更新当前选中值
  void _updateValue(DateTime newValue) {
    _value.value = newValue;
  }

  /// 更新当前页数信息
  void _updatePageByIndex(int newValue) {
    _page.value = newValue;
    _pageDate.value = _pageToDate(newValue);
  }

  /// 更新当前页数信息
  void _updatePageByDate(DateTime newValue) {
    _pageDate.value = newValue;
    _page.value = _dateToPage(newValue);

    _animateToPage(_page.value);
  }

  /// 动画滚动页面
  void _animateToPage(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = TdTheme.of(context);

    final spacing = theme.spacer;

    return LayoutBuilder(
      builder: (context, constraints) {
        const count = _kCalendarCrossAxisCount;
        final itemWidth = ((constraints.maxWidth - (count - 1) * spacing) / count).floorToDouble();
        final size = Size(itemWidth, itemWidth);

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _TdCalendarHeader(
              onChanged: _updatePageByDate,
              value: _pageDate,
            ),
            _TdCalendarWeek(
              size: size,
              crossAxisCount: _kCalendarCrossAxisCount,
              spacing: spacing,
              runSpacing: spacing,
              children: _kCalendarWeekList,
            ),
            ValueListenableBuilder(
              valueListenable: _page,
              builder: (context, value, child) {
                final line = _TdCalendarMonth.getLineCont(_pageToDate(value));

                return SizedBox(
                  height: line * size.height + (line - 1) * spacing,
                  child: child,
                );
              },
              child: PageView.builder(
                onPageChanged: _updatePageByIndex,
                controller: _pageController,
                itemCount: _getPageCount,
                itemBuilder: (context, index) {
                  return _TdCalendarMonth(
                    onChanged: _updateValue,
                    value: _value,
                    date: _pageToDate(index),
                    currentDate: _currentDate,
                    size: size,
                    crossAxisCount: _kCalendarCrossAxisCount,
                    spacing: spacing,
                    runSpacing: spacing,
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class _TdCalendarHeader extends StatelessWidget {
  const _TdCalendarHeader({
    required this.onChanged,
    required this.value,
  });

  /// 点击事件
  final ValueChanged<DateTime> onChanged;

  /// 当前选中的值
  final ValueNotifier<DateTime> value;

  Widget _buildAction({
    required GestureTapCallback onPressed,
    required Widget child,
  }) {
    return GestureDetector(
      onTap: onPressed,
      behavior: HitTestBehavior.opaque,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = TdTheme.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: theme.spacer / 2,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DefaultTextStyle(
            style: theme.fontM.copyWith(
              color: theme.textColorPrimary,
              fontWeight: FontWeight.w600,
            ),
            child: ValueListenableBuilder(
              valueListenable: value,
              builder: (context, value, child) {
                return Text('${value.year}年${value.month}月');
              },
            ),
          ),
          IconTheme(
            data: IconThemeData(
              size: theme.spacer3,
              color: theme.textColorBrand,
            ),
            child: Row(
              children: [
                _buildAction(
                  onPressed: () {
                    // 上一个月
                    onChanged(value.value.copyWith(
                      month: value.value.month - 1,
                    ));
                  },
                  child: const Icon(TdIcons.chevron_left),
                ),
                SizedBox(width: theme.spacer1),
                _buildAction(
                  onPressed: () {
                    // 下一个月
                    onChanged(value.value.copyWith(
                      month: value.value.month + 1,
                    ));
                  },
                  child: const Icon(TdIcons.chevron_right),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _TdCalendarWeek extends StatelessWidget {
  const _TdCalendarWeek({
    required this.size,
    required this.crossAxisCount,
    required this.spacing,
    required this.runSpacing,
    required this.children,
  });

  /// 尺寸大小
  final Size size;

  /// 每行个数
  final int crossAxisCount;

  /// 横向间距
  final double spacing;

  /// 纵向间距
  final double runSpacing;

  /// 子元素
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final theme = TdTheme.of(context);

    return DefaultTextStyle(
      style: theme.fontBase.copyWith(
        color: theme.textColorPlaceholder,
      ),
      child: Wrap(
        spacing: theme.spacer,
        runSpacing: theme.spacer,
        children: [
          for (final child in children)
            SizedBox.fromSize(
              size: size,
              child: Center(
                child: child,
              ),
            ),
        ],
      ),
    );
  }
}

class _TdCalendarMonth extends StatelessWidget {
  const _TdCalendarMonth({
    required this.onChanged,
    required this.value,
    required this.date,
    required this.currentDate,
    required this.size,
    required this.crossAxisCount,
    required this.spacing,
    required this.runSpacing,
  });

  /// 点击事件
  final ValueChanged<DateTime> onChanged;

  /// 当前选中的值
  final ValueNotifier<DateTime> value;

  /// 当前日期
  final DateTime date;

  /// 现在日期
  final DateTime currentDate;

  /// 尺寸大小
  final Size size;

  /// 每行个数
  final int crossAxisCount;

  /// 横向间距
  final double spacing;

  /// 纵向间距
  final double runSpacing;

  /// 判断是否选中
  bool _isSelected(int year, int month, int day) {
    final date = value.value;

    return year == date.year && month == date.month && day == date.day;
  }

  /// 判断年月日是否是现在日期
  bool _isNow(int year, int month, int day) {
    return year == currentDate.year && month == currentDate.month && day == currentDate.day;
  }

  /// 判断索引是否是周末
  bool _isWeekDay(int index) {
    final mode = index % 7;

    return mode == 0 || mode == 6;
  }

  /// 获取指定日期的前面占位数量
  static int getSpan(DateTime date) {
    return date.weekday == DateTime.sunday ? 0 : date.weekday;
  }

  /// 获取指定日期的最大天数
  static int getMaxDay(DateTime date) {
    return TdDateTimePicker.lastDayOfMonth(date.year, date.month);
  }

  /// 获取指定日期实际占用的行数
  static int getLineCont(DateTime date) {
    return ((getSpan(date) + getMaxDay(date)) / _kCalendarCrossAxisCount).ceil();
  }

  List<Widget> _buildSpan(int count) {
    return [
      for (var i = 0; i < count; i++)
        SizedBox.fromSize(
          size: size,
        ),
    ];
  }

  Widget _buildDay({
    required int index,
    required int day,
  }) {
    return TdValueNotifierSelector(
      value: value,
      selector: (context) {
        return _isSelected(date.year, date.month, day)
            ? _TdCalendarDayState.activation
            : _isNow(date.year, date.month, day)
                ? _TdCalendarDayState.highlight
                : _isWeekDay(index)
                    ? _TdCalendarDayState.placeholder
                    : _TdCalendarDayState.normal;
      },
      builder: (context, value, child) {
        return _TdCalendarDay(
          onPressed: () {
            onChanged(date.copyWith(
              day: day,
            ));
          },
          state: value,
          child: child!,
        );
      },
      child: Text('$day'),
    );
  }

  List<Widget> _buildMonth(int count, int span) {
    return [
      for (var i = 0; i < count; i++)
        SizedBox.fromSize(
          size: size,
          child: _buildDay(
            index: i + span,
            day: i + 1,
          ),
        ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final span = getSpan(date);
    final maxDay = getMaxDay(date);

    return Wrap(
      spacing: spacing,
      runSpacing: runSpacing,
      children: [
        ..._buildSpan(span),
        ..._buildMonth(maxDay, span),
      ],
    );
  }
}

class _TdCalendarDay extends StatelessWidget {
  const _TdCalendarDay({
    required this.onPressed,
    this.state = _TdCalendarDayState.normal,
    required this.child,
  });

  /// 点击事件
  final GestureTapCallback onPressed;

  /// 当前状态
  final _TdCalendarDayState state;

  /// 子元素
  final Widget child;

  Decoration? _getDecoration(TdThemeData theme) {
    return switch (state) {
      _TdCalendarDayState.normal || _TdCalendarDayState.placeholder => null,
      _TdCalendarDayState.activation => BoxDecoration(
          color: theme.brandColor,
          borderRadius: theme.radiusCircle,
        ),
      _TdCalendarDayState.highlight => BoxDecoration(
          color: theme.brandColorLight,
          borderRadius: theme.radiusCircle,
        ),
    };
  }

  TextStyle _getTextStyle(TdThemeData theme) {
    final textStyle = theme.fontM.copyWith(
      color: theme.textColorPrimary,
      fontWeight: FontWeight.w600,
    );

    return switch (state) {
      _TdCalendarDayState.normal => textStyle,
      _TdCalendarDayState.placeholder => textStyle.copyWith(
          color: theme.textColorPlaceholder,
        ),
      _TdCalendarDayState.activation => textStyle.copyWith(
          color: theme.textColorAnti,
        ),
      _TdCalendarDayState.highlight => textStyle.copyWith(
          color: theme.textColorBrand,
        ),
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = TdTheme.of(context);

    final decoration = _getDecoration(theme);
    final textStyle = _getTextStyle(theme);

    return GestureDetector(
      onTap: onPressed,
      behavior: HitTestBehavior.opaque,
      child: Container(
        alignment: Alignment.center,
        decoration: decoration,
        child: DefaultTextStyle(
          style: textStyle,
          child: child,
        ),
      ),
    );
  }
}
