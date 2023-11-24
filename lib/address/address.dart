import 'dart:async';

import 'package:flutter/widgets.dart';

import '../cascader/export.dart';
import './content.dart';

typedef TdAddressValue = int;

typedef TdAddressItem = TdCascaderItem<TdAddressValue>;

class TdAddressPlugin {
  /// 从json解析数据结构
  static TdAddressItem fromJson<T>(Map<String, dynamic> json) {
    return TdCascaderItem(
      value: json['value'] as int,
      label: json['label'] as String,
      children: (json['children'] as List?)?.map((e) => fromJson(e)).toList(),
    );
  }

  /// 深度匹配选项
  static List<TdAddressItem> matchSelector(TdAddressValue value) {
    return TdCascaderPlugin.matchSelector(value, kCityOptions);
  }

  /// 格式化文本内容
  static String? format(TdAddressValue value, [String separator = ' / ']) {
    return TdCascaderPlugin.format(value, kCityOptions, separator);
  }

  /// 弹出选择框
  static Future<TdAddressValue?> open(
    TdAddressValue? initialValue, {
    Text? title,
  }) {
    return TdCascaderPlugin.open(
      initialValue,
      title: title,
      options: kCityOptions,
    );
  }
}
