import 'package:flutter/material.dart';

@immutable
class TdButtonTheme extends InheritedTheme {
  const TdButtonTheme({
    super.key,
    required this.data,
    required super.child,
  });

  final TdButtonThemeData data;

  static TdButtonThemeData of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TdButtonTheme>()?.data ??
        TdButtonThemeData.fallback();
  }

  @override
  bool updateShouldNotify(covariant TdButtonTheme oldWidget) =>
      data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) {
    return TdButtonTheme(
      data: data,
      child: child,
    );
  }
}

@immutable
class TdButtonThemeData extends ThemeExtension<TdButtonThemeData> {
  factory TdButtonThemeData({
    double? extraSmallHeight,
    double? smallHeight,
    double? mediumHeight,
    double? largeHeight,
    EdgeInsets? extraSmallPadding,
    EdgeInsets? smallPadding,
    EdgeInsets? mediumPadding,
    EdgeInsets? largePadding,
    IconThemeData? extraSmallIcon,
    IconThemeData? smallIcon,
    IconThemeData? mediumIcon,
    IconThemeData? largeIcon,
    Radius? radius,
  }) {
    extraSmallHeight ??= 28.0;
    smallHeight ??= 32.0;
    mediumHeight ??= 40.0;
    largeHeight ??= 48.0;
    extraSmallPadding ??= const EdgeInsets.symmetric(horizontal: 8.0);
    smallPadding ??= const EdgeInsets.symmetric(horizontal: 12.0);
    mediumPadding ??= const EdgeInsets.symmetric(horizontal: 16.0);
    largePadding ??= const EdgeInsets.symmetric(horizontal: 20.0);
    extraSmallIcon ??= const IconThemeData(size: 18.0);
    smallIcon ??= const IconThemeData(size: 18.0);
    mediumIcon ??= const IconThemeData(size: 20.0);
    largeIcon ??= const IconThemeData(size: 24.0);
    radius ??= const Radius.circular(8.0);

    return TdButtonThemeData.raw(
      extraSmallHeight: extraSmallHeight,
      smallHeight: smallHeight,
      mediumHeight: mediumHeight,
      largeHeight: largeHeight,
      extraSmallPadding: extraSmallPadding,
      smallPadding: smallPadding,
      mediumPadding: mediumPadding,
      largePadding: largePadding,
      extraSmallIcon: extraSmallIcon,
      smallIcon: smallIcon,
      mediumIcon: mediumIcon,
      largeIcon: largeIcon,
      radius: radius,
    );
  }

  factory TdButtonThemeData.fallback() => TdButtonThemeData();

  // Height
  final double extraSmallHeight;
  final double smallHeight;
  final double mediumHeight;
  final double largeHeight;

  // Padding
  final EdgeInsets extraSmallPadding;
  final EdgeInsets smallPadding;
  final EdgeInsets mediumPadding;
  final EdgeInsets largePadding;

  // Icon Theme
  final IconThemeData extraSmallIcon;
  final IconThemeData smallIcon;
  final IconThemeData mediumIcon;
  final IconThemeData largeIcon;

  // Radius
  final Radius radius;

  const TdButtonThemeData.raw({
    required this.extraSmallHeight,
    required this.smallHeight,
    required this.mediumHeight,
    required this.largeHeight,
    required this.extraSmallPadding,
    required this.smallPadding,
    required this.mediumPadding,
    required this.largePadding,
    required this.extraSmallIcon,
    required this.smallIcon,
    required this.mediumIcon,
    required this.largeIcon,
    required this.radius,
  });

  @override
  ThemeExtension<TdButtonThemeData> copyWith({
    double? extraSmallHeight,
    double? smallHeight,
    double? mediumHeight,
    double? largeHeight,
    EdgeInsets? extraSmallPadding,
    EdgeInsets? smallPadding,
    EdgeInsets? mediumPadding,
    EdgeInsets? largePadding,
    IconThemeData? extraSmallIcon,
    IconThemeData? smallIcon,
    IconThemeData? mediumIcon,
    IconThemeData? largeIcon,
    Radius? radius,
  }) {
    return TdButtonThemeData(
      extraSmallHeight: extraSmallHeight ?? this.extraSmallHeight,
      smallHeight: smallHeight ?? this.smallHeight,
      mediumHeight: mediumHeight ?? this.mediumHeight,
      largeHeight: largeHeight ?? this.largeHeight,
      extraSmallPadding: extraSmallPadding ?? this.extraSmallPadding,
      smallPadding: smallPadding ?? this.smallPadding,
      mediumPadding: mediumPadding ?? this.mediumPadding,
      largePadding: largePadding ?? this.largePadding,
      extraSmallIcon: extraSmallIcon ?? this.extraSmallIcon,
      smallIcon: smallIcon ?? this.smallIcon,
      mediumIcon: mediumIcon ?? this.mediumIcon,
      largeIcon: largeIcon ?? this.largeIcon,
      radius: radius ?? this.radius,
    );
  }

  @override
  ThemeExtension<TdButtonThemeData> lerp(
      covariant ThemeExtension<TdButtonThemeData>? other, double t) {
    if (other is! TdButtonThemeData) {
      return this;
    }

    return TdButtonThemeData.raw(
      extraSmallHeight: other.extraSmallHeight,
      smallHeight: other.smallHeight,
      mediumHeight: other.mediumHeight,
      largeHeight: other.largeHeight,
      extraSmallPadding: other.extraSmallPadding,
      smallPadding: other.smallPadding,
      mediumPadding: other.mediumPadding,
      largePadding: other.largePadding,
      extraSmallIcon: other.extraSmallIcon,
      smallIcon: other.smallIcon,
      mediumIcon: other.mediumIcon,
      largeIcon: other.largeIcon,
      radius: other.radius,
    );
  }
}
