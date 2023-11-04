import 'package:flutter/material.dart';

import '../cascader/export.dart';
import './form_item.dart';
import './form_picker_view.dart';

/// 根据值获取完整的标签
bool _queryStack<T>(
    List<TdCascaderItem<T>> list, T value, List<String> defaultList) {
  for (var i = 0; i < list.length; i++) {
    final item = list[i];

    if (item.value == value) {
      defaultList.add(item.label);

      return true;
    } else if (item.children != null) {
      if (_queryStack(
        item.children!,
        value,
        defaultList,
      )) {
        defaultList.insert(0, item.label);

        return true;
      }
    }
  }

  return false;
}

class TdFormCascader<T> extends FormField<T> {
  TdFormCascader({
    super.key,
    super.onSaved,
    super.validator,
    super.initialValue,
    required List<TdCascaderItem<T>> options,
    super.autovalidateMode,
    ValueChanged<T?>? onChanged,
    Widget? label,
    double? labelWidth,
    TextAlign? labelAlign,
    Widget? help,
    String? hintText,
  }) : super(
          builder: (field) {
            void handleChanged(T? value) {
              field.didChange(value);

              onChanged?.call(value);
            }

            Widget? errorTextWidget;
            if (field.errorText != null) {
              errorTextWidget = Text(field.errorText!);
            }

            Widget? hintTextWidget;
            if (field.value != null) {
              final List<String> list = [];

              if (_queryStack(options, field.value, list)) {
                hintTextWidget = Text(list.join(' / '));
              }
            } else if (hintText != null) {
              hintTextWidget = Text(hintText);
            }

            final contentWidget = TdFormPickerView(
              onTap: () {
                showTdCascader<T>(
                  context: field.context,
                  initialValue: field.value,
                  onChanged: handleChanged,
                  title: label,
                  children: options,
                );
              },
              content: hintTextWidget,
            );

            return TdFormItem(
              label: label,
              labelWidth: labelWidth,
              labelAlign: labelAlign,
              help: help,
              errorMessage: errorTextWidget,
              contentAlign: TdFormItemAlign.end,
              child: contentWidget,
            );
          },
        );
}
