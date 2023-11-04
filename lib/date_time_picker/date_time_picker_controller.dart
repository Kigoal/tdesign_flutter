import 'package:flutter/widgets.dart';

typedef DateTimeRangeValue = (DateTime? start, DateTime? end);

class TdDateTimeRangeController with ChangeNotifier {
  TdDateTimeRangeController({
    DateTimeRangeValue initialValue = (null, null),
  }) : _value = initialValue;

  DateTimeRangeValue _value;
  DateTimeRangeValue get value => _value;

  DateTime? get startValue => _value.$1;
  DateTime? get endValue => _value.$2;

  void setValue(DateTime? start, DateTime? end) {
    _value = (start, end);

    notifyListeners();
  }

  void setStartValue(DateTime? value) {
    setValue(value, endValue);
  }

  void setEndValue(DateTime? value) {
    setValue(startValue, value);
  }

  void empty() {
    setValue(null, null);
  }
}
