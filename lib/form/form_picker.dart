import 'package:flutter/material.dart';

import '../picker/export.dart';
import './form_item.dart';
import './form_picker_view.dart';

class TdFormPicker<T> extends FormField<T> {
  TdFormPicker({
    super.key,
    super.onSaved,
    super.validator,
    super.initialValue,
    required List<TdPickerItem<T>> options,
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
              for (var i = 0; i < options.length; i++) {
                if (options[i].value == field.value) {
                  hintTextWidget = options[i].label;

                  break;
                }
              }
            } else if (hintText != null) {
              hintTextWidget = Text(hintText);
            }

            final contentWidget = TdFormPickerView(
              onTap: () async {
                final result = await TdPickerPlugin.open(
                  field.value,
                  title: label,
                  options: options,
                );

                handleChanged(result);
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
