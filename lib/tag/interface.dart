import 'dart:ui';

enum TdTagSize {
  small,
  medium,
  large,
  extraLarge,
}

enum TdTagType {
  normal,
  primary,
  warning,
  danger,
  success,
}

enum TdTagVariant {
  light,
  dart,
}

typedef TgTagColorRecord = (
  Color textColor,
  Color backgroundColor,
  Color borderColor,
);
