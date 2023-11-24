import 'package:flutter/material.dart';

import '../date_time_picker/export.dart';
import './form_item.dart';
import './form_picker_view.dart';

class TdFormDateTimePicker extends FormField<DateTime> {
  TdFormDateTimePicker({
    super.key,
    super.onSaved,
    super.validator,
    super.initialValue,
    super.autovalidateMode,
    ValueChanged<DateTime?>? onChanged,
    Widget? label,
    double? labelWidth,
    TextAlign? labelAlign,
    Widget? help,
    String? hintText,
    List<TdDateTimePickerMode> mode = TdDateTimePickerMode.values,
  }) : super(
          builder: (field) {
            void handleChanged(DateTime? value) {
              field.didChange(value);

              onChanged?.call(value);
            }

            Widget? errorTextWidget;
            if (field.errorText != null) {
              errorTextWidget = Text(field.errorText!);
            }

            Widget? hintTextWidget;
            if (field.value != null) {
              hintTextWidget = Text(TdDateTimePicker.format(field.value!, mode));
            } else if (hintText != null) {
              hintTextWidget = Text(hintText);
            }

            final contentWidget = TdFormPickerView(
              onTap: () async {
                final result = await TdDateTimePickerPlugin.open(
                  field.value,
                  mode: mode,
                  title: label,
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
