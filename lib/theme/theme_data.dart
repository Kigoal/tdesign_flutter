import 'package:flutter/material.dart';

import '../button/button_theme.dart';

@immutable
final class TdThemeData extends ThemeExtension<TdThemeData> {
  factory TdThemeData({
    Brightness? brightness,
    Color? brandColor1,
    Color? brandColor2,
    Color? brandColor3,
    Color? brandColor4,
    Color? brandColor5,
    Color? brandColor6,
    Color? brandColor7,
    Color? brandColor8,
    Color? brandColor9,
    Color? brandColor10,
    Color? warningColor1,
    Color? warningColor2,
    Color? warningColor3,
    Color? warningColor4,
    Color? warningColor5,
    Color? warningColor6,
    Color? warningColor7,
    Color? warningColor8,
    Color? warningColor9,
    Color? warningColor10,
    Color? errorColor1,
    Color? errorColor2,
    Color? errorColor3,
    Color? errorColor4,
    Color? errorColor5,
    Color? errorColor6,
    Color? errorColor7,
    Color? errorColor8,
    Color? errorColor9,
    Color? errorColor10,
    Color? successColor1,
    Color? successColor2,
    Color? successColor3,
    Color? successColor4,
    Color? successColor5,
    Color? successColor6,
    Color? successColor7,
    Color? successColor8,
    Color? successColor9,
    Color? successColor10,
    Color? grayColor1,
    Color? grayColor2,
    Color? grayColor3,
    Color? grayColor4,
    Color? grayColor5,
    Color? grayColor6,
    Color? grayColor7,
    Color? grayColor8,
    Color? grayColor9,
    Color? grayColor10,
    Color? grayColor11,
    Color? grayColor12,
    Color? grayColor13,
    Color? grayColor14,
    Color? fontGray1,
    Color? fontGray2,
    Color? fontGray3,
    Color? fontGray4,
    Color? fontWhite1,
    Color? fontWhite2,
    Color? fontWhite3,
    Color? fontWhite4,
    Color? brandColor,
    Color? brandColorActive,
    Color? brandColorDisabled,
    Color? brandColorFocus,
    Color? brandColorLight,
    Color? brandColorLightActive,
    Color? warningColor,
    Color? warningColorActive,
    Color? warningColorDisabled,
    Color? warningColorFocus,
    Color? warningColorLight,
    Color? warningColorLightActive,
    Color? errorColor,
    Color? errorColorActive,
    Color? errorColorDisabled,
    Color? errorColorFocus,
    Color? errorColorLight,
    Color? errorColorLightActive,
    Color? successColor,
    Color? successColorActive,
    Color? successColorDisabled,
    Color? successColorFocus,
    Color? successColorLight,
    Color? successColorLightActive,
    Color? backgroundColorPage,
    Color? backgroundColorContainer,
    Color? backgroundColorContainerActive,
    Color? backgroundColorSecondaryContainer,
    Color? backgroundColorSecondaryContainerActive,
    Color? backgroundColorComponent,
    Color? backgroundColorComponentActive,
    Color? backgroundColorComponentDisabled,
    Color? textColorPrimary,
    Color? textColorSecondary,
    Color? textColorPlaceholder,
    Color? textColorDisabled,
    Color? textColorAnti,
    Color? textColorBrand,
    Color? textColorLink,
    Color? componentStroke,
    Color? componentBorder,
    List<BoxShadow>? shadow1,
    List<BoxShadow>? shadow2,
    List<BoxShadow>? shadow3,
    List<BoxShadow>? shadow4,
    Color? maskActive,
    Color? maskDisabled,
    double? spacer,
    double? spacer1,
    double? spacer2,
    double? spacer3,
    double? spacer4,
    double? spacer5,
    double? spacer6,
    TextStyle? font,
    TextStyle? fontXs,
    TextStyle? fontS,
    TextStyle? fontBase,
    TextStyle? fontM,
    TextStyle? fontL,
    TextStyle? fontXl,
    BorderRadius? radiusSmall,
    BorderRadius? radiusDefault,
    BorderRadius? radiusLarge,
    BorderRadius? radiusExtraL,
    BorderRadius? radiusRound,
    BorderRadius? radiusCircle,
    TdButtonThemeData? buttonTheme,
  }) {
    brightness ??= Brightness.light;

    if (brightness == Brightness.light) {
      // Light Mode
      brandColor1 ??= const Color(0xFFF2F3FF);
      brandColor2 ??= const Color(0xFFD9E1FF);
      brandColor3 ??= const Color(0xFFB5C7FF);
      brandColor4 ??= const Color(0xFF8EABFF);
      brandColor5 ??= const Color(0xFF618DFF);
      brandColor6 ??= const Color(0xFF366EF4);
      brandColor7 ??= const Color(0xFF0052D9);
      brandColor8 ??= const Color(0xFF003CAB);
      brandColor9 ??= const Color(0xFF002A7C);
      brandColor10 ??= const Color(0xFF001A57);

      warningColor1 ??= const Color(0xFFFFF1E9);
      warningColor2 ??= const Color(0xFFFFD9C2);
      warningColor3 ??= const Color(0xFFFFB98C);
      warningColor4 ??= const Color(0xFFFA9550);
      warningColor5 ??= const Color(0xFFE37318);
      warningColor6 ??= const Color(0xFFBE5A00);
      warningColor7 ??= const Color(0xFF954500);
      warningColor8 ??= const Color(0xFF713300);
      warningColor9 ??= const Color(0xFF532300);
      warningColor10 ??= const Color(0xFF3B1700);

      errorColor1 ??= const Color(0xFFFFF0ED);
      errorColor2 ??= const Color(0xFFFFD8D2);
      errorColor3 ??= const Color(0xFFFFB9B0);
      errorColor4 ??= const Color(0xFFFF9285);
      errorColor5 ??= const Color(0xFFF6685D);
      errorColor6 ??= const Color(0xFFD54941);
      errorColor7 ??= const Color(0xFFAD352F);
      errorColor8 ??= const Color(0xFF881F1C);
      errorColor9 ??= const Color(0xFF68070A);
      errorColor10 ??= const Color(0xFF490002);

      successColor1 ??= const Color(0xFFE3F9E9);
      successColor2 ??= const Color(0xFFC6F3D7);
      successColor3 ??= const Color(0xFF92DAB2);
      successColor4 ??= const Color(0xFF56C08D);
      successColor5 ??= const Color(0xFF2BA471);
      successColor6 ??= const Color(0xFF008858);
      successColor7 ??= const Color(0xFF006C45);
      successColor8 ??= const Color(0xFF005334);
      successColor9 ??= const Color(0xFF003B23);
      successColor10 ??= const Color(0xFF002515);

      grayColor1 ??= const Color(0xFFF3F3F3);
      grayColor2 ??= const Color(0xFFEEEEEE);
      grayColor3 ??= const Color(0xFFE7E7E7);
      grayColor4 ??= const Color(0xFFDCDCDC);
      grayColor5 ??= const Color(0xFFC5C5C5);
      grayColor6 ??= const Color(0xFFA6A6A6);
      grayColor7 ??= const Color(0xFF8B8B8B);
      grayColor8 ??= const Color(0xFF777777);
      grayColor9 ??= const Color(0xFF5E5E5E);
      grayColor10 ??= const Color(0xFF4B4B4B);
      grayColor11 ??= const Color(0xFF383838);
      grayColor12 ??= const Color(0xFF2C2C2C);
      grayColor13 ??= const Color(0xFF242424);
      grayColor14 ??= const Color(0xFF181818);

      // 文字 & 图标 颜色
      fontGray1 ??= const Color.fromRGBO(0, 0, 0, .9);
      fontGray2 ??= const Color.fromRGBO(0, 0, 0, .6);
      fontGray3 ??= const Color.fromRGBO(0, 0, 0, .4);
      fontGray4 ??= const Color.fromRGBO(0, 0, 0, .26);
      fontWhite1 ??= const Color.fromRGBO(255, 255, 255, 1);
      fontWhite2 ??= const Color.fromRGBO(255, 255, 255, .55);
      fontWhite3 ??= const Color.fromRGBO(255, 255, 255, .35);
      fontWhite4 ??= const Color.fromRGBO(255, 255, 255, .22);

      // 基础色扩展
      brandColor ??= brandColor7;
      brandColorActive ??= brandColor8;
      brandColorDisabled ??= brandColor3;
      brandColorFocus ??= brandColor1;
      brandColorLight ??= brandColor1;
      brandColorLightActive ??= brandColor2;

      // 警告色扩展
      warningColor ??= warningColor5;
      warningColorActive ??= warningColor6;
      warningColorDisabled ??= warningColor3;
      warningColorFocus ??= warningColor2;
      warningColorLight ??= warningColor1;
      warningColorLightActive ??= warningColor2;

      // 失败/错误色扩展
      errorColor ??= errorColor6;
      errorColorActive ??= errorColor7;
      errorColorDisabled ??= errorColor3;
      errorColorFocus ??= errorColor2;
      errorColorLight ??= errorColor1;
      errorColorLightActive ??= errorColor2;

      // 成功色扩展
      successColor ??= successColor5;
      successColorActive ??= successColor6;
      successColorDisabled ??= successColor3;
      successColorFocus ??= successColor2;
      successColorLight ??= successColor1;
      successColorLightActive ??= successColor2;

      // 背景色
      backgroundColorPage ??= grayColor1;
      backgroundColorContainer ??= fontWhite1;
      backgroundColorContainerActive ??= grayColor3;
      backgroundColorSecondaryContainer ??= grayColor1;
      backgroundColorSecondaryContainerActive ??= grayColor4;
      backgroundColorComponent ??= grayColor3;
      backgroundColorComponentActive ??= grayColor6;
      backgroundColorComponentDisabled ??= grayColor2;

      // 文本颜色
      textColorPrimary ??= fontGray1;
      textColorSecondary ??= fontGray2;
      textColorPlaceholder ??= fontGray3;
      textColorDisabled ??= fontGray4;
      textColorAnti ??= fontWhite1;
      textColorBrand ??= brandColor;
      textColorLink ??= brandColor;

      // 分割线 & 边框
      componentStroke ??= grayColor3;
      componentBorder ??= grayColor4;

      // 阴影
      shadow1 ??= const [
        BoxShadow(color: Color.fromRGBO(0, 0, 0, .05), offset: Offset(0.0, 1.0), blurRadius: 10.0),
        BoxShadow(color: Color.fromRGBO(0, 0, 0, .08), offset: Offset(0.0, 4.0), blurRadius: 5.0),
        BoxShadow(color: Color.fromRGBO(0, 0, 0, .12), offset: Offset(0.0, 2.0), blurRadius: 4.0, spreadRadius: -1.0),
      ];
      shadow2 ??= const [
        BoxShadow(color: Color.fromRGBO(0, 0, 0, .05), offset: Offset(0.0, 3.0), blurRadius: 14.0, spreadRadius: 2.0),
        BoxShadow(color: Color.fromRGBO(0, 0, 0, .06), offset: Offset(0.0, 8.0), blurRadius: 10.0, spreadRadius: 1.0),
        BoxShadow(color: Color.fromRGBO(0, 0, 0, .1), offset: Offset(0.0, 5.0), blurRadius: 5.0, spreadRadius: -3.0),
      ];
      shadow3 ??= const [
        BoxShadow(color: Color.fromRGBO(0, 0, 0, .05), offset: Offset(0.0, 6.0), blurRadius: 30.0, spreadRadius: 5.0),
        BoxShadow(color: Color.fromRGBO(0, 0, 0, .04), offset: Offset(0.0, 16.0), blurRadius: 24.0, spreadRadius: 2.0),
        BoxShadow(color: Color.fromRGBO(0, 0, 0, .08), offset: Offset(0.0, 8.0), blurRadius: 10.0, spreadRadius: -5.0),
      ];
      shadow4 ??= const [
        BoxShadow(color: Color.fromRGBO(0, 0, 0, .06), offset: Offset(0.0, 2.0), blurRadius: 8.0),
      ];

      // 遮罩
      maskActive ??= const Color.fromRGBO(0, 0, 0, .6);
      maskDisabled ??= const Color.fromRGBO(255, 255, 255, .6);
    } else {
      // Dark Mode
      brandColor1 ??= const Color(0xFF1B2F51);
      brandColor2 ??= const Color(0xFF173463);
      brandColor3 ??= const Color(0xFF143975);
      brandColor4 ??= const Color(0xFF103D88);
      brandColor5 ??= const Color(0xFF0D429A);
      brandColor6 ??= const Color(0xFF054BBE);
      brandColor7 ??= const Color(0xFF2667D4);
      brandColor8 ??= const Color(0xFF4582E6);
      brandColor9 ??= const Color(0xFF699EF5);
      brandColor10 ??= const Color(0xFF96BBF8);

      warningColor1 ??= const Color(0xFF4F2A1D);
      warningColor2 ??= const Color(0xFF582F21);
      warningColor3 ??= const Color(0xFF733C23);
      warningColor4 ??= const Color(0xFFA75D2B);
      warningColor5 ??= const Color(0xFFCF6E2D);
      warningColor6 ??= const Color(0xFFDC7633);
      warningColor7 ??= const Color(0xFFE8935C);
      warningColor8 ??= const Color(0xFFECBF91);
      warningColor9 ??= const Color(0xFFEED7BF);
      warningColor10 ??= const Color(0xFFF3E9DC);

      errorColor1 ??= const Color(0xFF472324);
      errorColor2 ??= const Color(0xFF5E2A2D);
      errorColor3 ??= const Color(0xFF703439);
      errorColor4 ??= const Color(0xFF83383E);
      errorColor5 ??= const Color(0xFFA03F46);
      errorColor6 ??= const Color(0xFFC64751);
      errorColor7 ??= const Color(0xFFDE6670);
      errorColor8 ??= const Color(0xFFEC888E);
      errorColor9 ??= const Color(0xFFEDB1B6);
      errorColor10 ??= const Color(0xFFEECED0);

      successColor1 ??= const Color(0xFF193A2A);
      successColor2 ??= const Color(0xFF1A4230);
      successColor3 ??= const Color(0xFF17533D);
      successColor4 ??= const Color(0xFF0D7A55);
      successColor5 ??= const Color(0xFF059465);
      successColor6 ??= const Color(0xFF43AF8A);
      successColor7 ??= const Color(0xFF46BF96);
      successColor8 ??= const Color(0xFF80D2B6);
      successColor9 ??= const Color(0xFFB4E1D3);
      successColor10 ??= const Color(0xFFDEEDE8);

      grayColor1 ??= const Color(0xFFF3F3F3);
      grayColor2 ??= const Color(0xFFEEEEEE);
      grayColor3 ??= const Color(0xFFE7E7E7);
      grayColor4 ??= const Color(0xFFDCDCDC);
      grayColor5 ??= const Color(0xFFC5C5C5);
      grayColor6 ??= const Color(0xFFA6A6A6);
      grayColor7 ??= const Color(0xFF8B8B8B);
      grayColor8 ??= const Color(0xFF777777);
      grayColor9 ??= const Color(0xFF5E5E5E);
      grayColor10 ??= const Color(0xFF4B4B4B);
      grayColor11 ??= const Color(0xFF383838);
      grayColor12 ??= const Color(0xFF2C2C2C);
      grayColor13 ??= const Color(0xFF242424);
      grayColor14 ??= const Color(0xFF181818);

      // 文字 & 图标 颜色
      fontWhite1 ??= const Color.fromRGBO(255, 255, 255, .9);
      fontWhite2 ??= const Color.fromRGBO(255, 255, 255, .6);
      fontWhite3 ??= const Color.fromRGBO(255, 255, 255, .4);
      fontWhite4 ??= const Color.fromRGBO(255, 255, 255, .26);
      fontGray1 ??= const Color.fromRGBO(0, 0, 0, .9);
      fontGray2 ??= const Color.fromRGBO(0, 0, 0, .6);
      fontGray3 ??= const Color.fromRGBO(0, 0, 0, .4);
      fontGray4 ??= const Color.fromRGBO(0, 0, 0, .26);

      // 基础色扩展
      brandColor ??= brandColor8;
      brandColorActive ??= brandColor9;
      brandColorDisabled ??= brandColor3;
      brandColorFocus ??= brandColor1;
      brandColorLight ??= brandColor1;
      brandColorLightActive ??= brandColor2;

      // 警告色扩展
      warningColor ??= warningColor5;
      warningColorActive ??= warningColor4;
      warningColorDisabled ??= warningColor3;
      warningColorFocus ??= warningColor2;
      warningColorLight ??= warningColor1;
      warningColorLightActive ??= warningColor2;

      // 失败/错误色扩展
      errorColor ??= errorColor6;
      errorColorActive ??= errorColor5;
      errorColorDisabled ??= errorColor3;
      errorColorFocus ??= errorColor2;
      errorColorLight ??= errorColor1;
      errorColorLightActive ??= errorColor2;

      // 成功色扩展
      successColor ??= successColor5;
      successColorActive ??= successColor4;
      successColorDisabled ??= successColor3;
      successColorFocus ??= successColor2;
      successColorLight ??= successColor1;
      successColorLightActive ??= successColor2;

      // 背景色
      backgroundColorPage ??= grayColor14;
      backgroundColorContainer ??= grayColor13;
      backgroundColorContainerActive ??= grayColor12;
      backgroundColorSecondaryContainer ??= grayColor12;
      backgroundColorSecondaryContainerActive ??= grayColor11;
      backgroundColorComponent ??= grayColor11;
      backgroundColorComponentActive ??= grayColor10;
      backgroundColorComponentDisabled ??= grayColor12;

      // 文本颜色
      textColorPrimary ??= fontWhite1;
      textColorSecondary ??= fontWhite2;
      textColorPlaceholder ??= fontWhite3;
      textColorDisabled ??= fontWhite4;
      textColorAnti ??= fontGray1;
      textColorBrand ??= brandColor;
      textColorLink ??= brandColor;

      // 分割线 & 边框
      componentStroke ??= grayColor11;
      componentBorder ??= grayColor9;

      // 阴影
      shadow1 ??= const [
        BoxShadow(color: Color.fromRGBO(0, 0, 0, .06), offset: Offset(0.0, 4.0), blurRadius: 6.0),
        BoxShadow(color: Color.fromRGBO(0, 0, 0, .08), offset: Offset(0.0, 1.0), blurRadius: 10.0),
        BoxShadow(color: Color.fromRGBO(0, 0, 0, .12), offset: Offset(0.0, 2.0), blurRadius: 4.0),
      ];
      shadow2 ??= const [
        BoxShadow(color: Color.fromRGBO(0, 0, 0, .12), offset: Offset(0.0, 8.0), blurRadius: 10.0),
        BoxShadow(color: Color.fromRGBO(0, 0, 0, .10), offset: Offset(0.0, 3.0), blurRadius: 14.0),
        BoxShadow(color: Color.fromRGBO(0, 0, 0, .16), offset: Offset(0.0, 5.0), blurRadius: 5.0),
      ];
      shadow3 ??= const [
        BoxShadow(color: Color.fromRGBO(0, 0, 0, .14), offset: Offset(0.0, 16.0), blurRadius: 24.0),
        BoxShadow(color: Color.fromRGBO(0, 0, 0, .12), offset: Offset(0.0, 6.0), blurRadius: 30.0),
        BoxShadow(color: Color.fromRGBO(0, 0, 0, .20), offset: Offset(0.0, 8.0), blurRadius: 10.0),
      ];
      shadow4 ??= const [
        BoxShadow(color: Color.fromRGBO(0, 0, 0, .06), offset: Offset(0.0, 2.0), blurRadius: 8.0),
      ];

      // 遮罩
      maskActive ??= const Color.fromRGBO(0, 0, 0, .4);
      maskDisabled ??= const Color.fromRGBO(0, 0, 0, .6);
    }

    // 间隔
    spacer ??= 8.0;
    spacer1 ??= 12.00;
    spacer2 ??= 16.00;
    spacer3 ??= 24.00;
    spacer4 ??= 32.00;
    spacer5 ??= 48.00;
    spacer6 ??= 80.00;

    // 字体
    font ??= const TextStyle(fontSize: 10.0, height: 16.0 / 10.0);
    fontXs ??= const TextStyle(fontSize: 10.0, height: 16.0 / 10.0);
    fontS ??= const TextStyle(fontSize: 12.0, height: 20.0 / 12.0);
    fontBase ??= const TextStyle(fontSize: 14.0, height: 22.0 / 14.0);
    fontM ??= const TextStyle(fontSize: 16.0, height: 24.0 / 16.0);
    fontL ??= const TextStyle(fontSize: 20.0, height: 28.0 / 20.0);
    fontXl ??= const TextStyle(fontSize: 36.0, height: 44.0 / 36.0);

    // 圆角
    radiusSmall ??= const BorderRadius.all(Radius.circular(3.0));
    radiusDefault ??= const BorderRadius.all(Radius.circular(6.0));
    radiusLarge ??= const BorderRadius.all(Radius.circular(9.0));
    radiusExtraL ??= const BorderRadius.all(Radius.circular(12.0));
    radiusRound ??= const BorderRadius.all(Radius.circular(999.0));
    radiusCircle ??= const BorderRadius.all(Radius.circular(999.0));

    buttonTheme ??= TdButtonThemeData.fallback();

    return TdThemeData.raw(
      brightness: brightness,
      brandColor1: brandColor1,
      brandColor2: brandColor2,
      brandColor3: brandColor3,
      brandColor4: brandColor4,
      brandColor5: brandColor5,
      brandColor6: brandColor6,
      brandColor7: brandColor7,
      brandColor8: brandColor8,
      brandColor9: brandColor9,
      brandColor10: brandColor10,
      warningColor1: warningColor1,
      warningColor2: warningColor2,
      warningColor3: warningColor3,
      warningColor4: warningColor4,
      warningColor5: warningColor5,
      warningColor6: warningColor6,
      warningColor7: warningColor7,
      warningColor8: warningColor8,
      warningColor9: warningColor9,
      warningColor10: warningColor10,
      errorColor1: errorColor1,
      errorColor2: errorColor2,
      errorColor3: errorColor3,
      errorColor4: errorColor4,
      errorColor5: errorColor5,
      errorColor6: errorColor6,
      errorColor7: errorColor7,
      errorColor8: errorColor8,
      errorColor9: errorColor9,
      errorColor10: errorColor10,
      successColor1: successColor1,
      successColor2: successColor2,
      successColor3: successColor3,
      successColor4: successColor4,
      successColor5: successColor5,
      successColor6: successColor6,
      successColor7: successColor7,
      successColor8: successColor8,
      successColor9: successColor9,
      successColor10: successColor10,
      grayColor1: grayColor1,
      grayColor2: grayColor2,
      grayColor3: grayColor3,
      grayColor4: grayColor4,
      grayColor5: grayColor5,
      grayColor6: grayColor6,
      grayColor7: grayColor7,
      grayColor8: grayColor8,
      grayColor9: grayColor9,
      grayColor10: grayColor10,
      grayColor11: grayColor11,
      grayColor12: grayColor12,
      grayColor13: grayColor13,
      grayColor14: grayColor14,
      fontGray1: fontGray1,
      fontGray2: fontGray2,
      fontGray3: fontGray3,
      fontGray4: fontGray4,
      fontWhite1: fontWhite1,
      fontWhite2: fontWhite2,
      fontWhite3: fontWhite3,
      fontWhite4: fontWhite4,
      brandColor: brandColor,
      brandColorActive: brandColorActive,
      brandColorDisabled: brandColorDisabled,
      brandColorFocus: brandColorFocus,
      brandColorLight: brandColorLight,
      brandColorLightActive: brandColorLightActive,
      warningColor: warningColor,
      warningColorActive: warningColorActive,
      warningColorDisabled: warningColorDisabled,
      warningColorFocus: warningColorFocus,
      warningColorLight: warningColorLight,
      warningColorLightActive: warningColorLightActive,
      errorColor: errorColor,
      errorColorActive: errorColorActive,
      errorColorDisabled: errorColorDisabled,
      errorColorFocus: errorColorFocus,
      errorColorLight: errorColorLight,
      errorColorLightActive: errorColorLightActive,
      successColor: successColor,
      successColorActive: successColorActive,
      successColorDisabled: successColorDisabled,
      successColorFocus: successColorFocus,
      successColorLight: successColorLight,
      successColorLightActive: successColorLightActive,
      backgroundColorPage: backgroundColorPage,
      backgroundColorContainer: backgroundColorContainer,
      backgroundColorContainerActive: backgroundColorContainerActive,
      backgroundColorSecondaryContainer: backgroundColorSecondaryContainer,
      backgroundColorSecondaryContainerActive: backgroundColorSecondaryContainerActive,
      backgroundColorComponent: backgroundColorComponent,
      backgroundColorComponentActive: backgroundColorComponentActive,
      backgroundColorComponentDisabled: backgroundColorComponentDisabled,
      textColorPrimary: textColorPrimary,
      textColorSecondary: textColorSecondary,
      textColorPlaceholder: textColorPlaceholder,
      textColorDisabled: textColorDisabled,
      textColorAnti: textColorAnti,
      textColorBrand: textColorBrand,
      textColorLink: textColorLink,
      componentStroke: componentStroke,
      componentBorder: componentBorder,
      shadow1: shadow1,
      shadow2: shadow2,
      shadow3: shadow3,
      shadow4: shadow4,
      maskActive: maskActive,
      maskDisabled: maskDisabled,
      spacer: spacer,
      spacer1: spacer1,
      spacer2: spacer2,
      spacer3: spacer3,
      spacer4: spacer4,
      spacer5: spacer5,
      spacer6: spacer6,
      font: font,
      fontXs: fontXs,
      fontS: fontS,
      fontBase: fontBase,
      fontM: fontM,
      fontL: fontL,
      fontXl: fontXl,
      radiusSmall: radiusSmall,
      radiusDefault: radiusDefault,
      radiusLarge: radiusLarge,
      radiusExtraL: radiusExtraL,
      radiusRound: radiusRound,
      radiusCircle: radiusCircle,
      buttonTheme: buttonTheme,
    );
  }

  const TdThemeData.raw({
    required this.brightness,
    required this.brandColor1,
    required this.brandColor2,
    required this.brandColor3,
    required this.brandColor4,
    required this.brandColor5,
    required this.brandColor6,
    required this.brandColor7,
    required this.brandColor8,
    required this.brandColor9,
    required this.brandColor10,
    required this.warningColor1,
    required this.warningColor2,
    required this.warningColor3,
    required this.warningColor4,
    required this.warningColor5,
    required this.warningColor6,
    required this.warningColor7,
    required this.warningColor8,
    required this.warningColor9,
    required this.warningColor10,
    required this.errorColor1,
    required this.errorColor2,
    required this.errorColor3,
    required this.errorColor4,
    required this.errorColor5,
    required this.errorColor6,
    required this.errorColor7,
    required this.errorColor8,
    required this.errorColor9,
    required this.errorColor10,
    required this.successColor1,
    required this.successColor2,
    required this.successColor3,
    required this.successColor4,
    required this.successColor5,
    required this.successColor6,
    required this.successColor7,
    required this.successColor8,
    required this.successColor9,
    required this.successColor10,
    required this.grayColor1,
    required this.grayColor2,
    required this.grayColor3,
    required this.grayColor4,
    required this.grayColor5,
    required this.grayColor6,
    required this.grayColor7,
    required this.grayColor8,
    required this.grayColor9,
    required this.grayColor10,
    required this.grayColor11,
    required this.grayColor12,
    required this.grayColor13,
    required this.grayColor14,
    required this.fontGray1,
    required this.fontGray2,
    required this.fontGray3,
    required this.fontGray4,
    required this.fontWhite1,
    required this.fontWhite2,
    required this.fontWhite3,
    required this.fontWhite4,
    required this.brandColor,
    required this.brandColorActive,
    required this.brandColorDisabled,
    required this.brandColorFocus,
    required this.brandColorLight,
    required this.brandColorLightActive,
    required this.warningColor,
    required this.warningColorActive,
    required this.warningColorDisabled,
    required this.warningColorFocus,
    required this.warningColorLight,
    required this.warningColorLightActive,
    required this.errorColor,
    required this.errorColorActive,
    required this.errorColorDisabled,
    required this.errorColorFocus,
    required this.errorColorLight,
    required this.errorColorLightActive,
    required this.successColor,
    required this.successColorActive,
    required this.successColorDisabled,
    required this.successColorFocus,
    required this.successColorLight,
    required this.successColorLightActive,
    required this.backgroundColorPage,
    required this.backgroundColorContainer,
    required this.backgroundColorContainerActive,
    required this.backgroundColorSecondaryContainer,
    required this.backgroundColorSecondaryContainerActive,
    required this.backgroundColorComponent,
    required this.backgroundColorComponentActive,
    required this.backgroundColorComponentDisabled,
    required this.textColorPrimary,
    required this.textColorSecondary,
    required this.textColorPlaceholder,
    required this.textColorDisabled,
    required this.textColorAnti,
    required this.textColorBrand,
    required this.textColorLink,
    required this.componentStroke,
    required this.componentBorder,
    required this.shadow1,
    required this.shadow2,
    required this.shadow3,
    required this.shadow4,
    required this.maskActive,
    required this.maskDisabled,
    required this.spacer,
    required this.spacer1,
    required this.spacer2,
    required this.spacer3,
    required this.spacer4,
    required this.spacer5,
    required this.spacer6,
    required this.font,
    required this.fontXs,
    required this.fontS,
    required this.fontBase,
    required this.fontM,
    required this.fontL,
    required this.fontXl,
    required this.radiusSmall,
    required this.radiusDefault,
    required this.radiusLarge,
    required this.radiusExtraL,
    required this.radiusRound,
    required this.radiusCircle,
    required this.buttonTheme,
  });

  factory TdThemeData.light() => TdThemeData(
        brightness: Brightness.light,
      );

  factory TdThemeData.dark() => TdThemeData(
        brightness: Brightness.dark,
      );

  factory TdThemeData.fallback() => TdThemeData.light();

  final Brightness brightness;

  final Color brandColor1;
  final Color brandColor2;
  final Color brandColor3;
  final Color brandColor4;
  final Color brandColor5;
  final Color brandColor6;
  final Color brandColor7;
  final Color brandColor8;
  final Color brandColor9;
  final Color brandColor10;

  final Color warningColor1;
  final Color warningColor2;
  final Color warningColor3;
  final Color warningColor4;
  final Color warningColor5;
  final Color warningColor6;
  final Color warningColor7;
  final Color warningColor8;
  final Color warningColor9;
  final Color warningColor10;

  final Color errorColor1;
  final Color errorColor2;
  final Color errorColor3;
  final Color errorColor4;
  final Color errorColor5;
  final Color errorColor6;
  final Color errorColor7;
  final Color errorColor8;
  final Color errorColor9;
  final Color errorColor10;

  final Color successColor1;
  final Color successColor2;
  final Color successColor3;
  final Color successColor4;
  final Color successColor5;
  final Color successColor6;
  final Color successColor7;
  final Color successColor8;
  final Color successColor9;
  final Color successColor10;

  final Color grayColor1;
  final Color grayColor2;
  final Color grayColor3;
  final Color grayColor4;
  final Color grayColor5;
  final Color grayColor6;
  final Color grayColor7;
  final Color grayColor8;
  final Color grayColor9;
  final Color grayColor10;
  final Color grayColor11;
  final Color grayColor12;
  final Color grayColor13;
  final Color grayColor14;

  final Color fontGray1;
  final Color fontGray2;
  final Color fontGray3;
  final Color fontGray4;
  final Color fontWhite1;
  final Color fontWhite2;
  final Color fontWhite3;
  final Color fontWhite4;

  // 主要色扩展
  final Color brandColor;
  final Color brandColorActive;
  final Color brandColorDisabled;
  final Color brandColorFocus;
  final Color brandColorLight;
  final Color brandColorLightActive;

  // 警告色扩展
  final Color warningColor;
  final Color warningColorActive;
  final Color warningColorDisabled;
  final Color warningColorFocus;
  final Color warningColorLight;
  final Color warningColorLightActive;

  // 失败/错误色扩展
  final Color errorColor;
  final Color errorColorActive;
  final Color errorColorDisabled;
  final Color errorColorFocus;
  final Color errorColorLight;
  final Color errorColorLightActive;

  // 成功色扩展
  final Color successColor;
  final Color successColorActive;
  final Color successColorDisabled;
  final Color successColorFocus;
  final Color successColorLight;
  final Color successColorLightActive;

  // 背景色

  /// page
  final Color backgroundColorPage;

  /// 容器
  final Color backgroundColorContainer;

  /// 容器 - active
  final Color backgroundColorContainerActive;

  /// 次级容器
  final Color backgroundColorSecondaryContainer;

  /// 次级容器 - active
  final Color backgroundColorSecondaryContainerActive;

  /// 组件
  final Color backgroundColorComponent;

  /// 组件 - active
  final Color backgroundColorComponentActive;

  /// 组件 - disabled
  final Color backgroundColorComponentDisabled;

  // 文本颜色

  /// 文字-主要
  final Color textColorPrimary;

  /// 文字-次要
  final Color textColorSecondary;

  /// 文字-占位符/说明
  final Color textColorPlaceholder;

  /// 文字-禁用
  final Color textColorDisabled;

  /// 文字-反色
  final Color textColorAnti;

  /// 文字-品牌
  final Color textColorBrand;

  /// 文字-链接
  final Color textColorLink;

  // 分割线 & 边框

  /// 分割线
  final Color componentStroke;

  /// 边框
  final Color componentBorder;

  // 阴影

  /// 基础/下层 投影 hover 使用的组件包括：表格
  final List<BoxShadow> shadow1;

  /// 中层投影 下拉 使用的组件包括：下拉菜单 / 气泡确认框 / 选择器
  final List<BoxShadow> shadow2;

  /// 上层投影（警示/弹窗）使用的组件包括：全局提示 / 消息通知
  final List<BoxShadow> shadow3;

  /// 内投影 用于弹窗类组件（气泡确认框 / 全局提示 / 消息通知）的内描边
  final List<BoxShadow> shadow4;

  // 遮罩

  /// 遮罩-弹出
  final Color maskActive;

  /// 遮罩-禁用
  final Color maskDisabled;

  // 边距

  /// 8.0
  final double spacer;

  /// 12.0
  final double spacer1;

  /// 16.0
  final double spacer2;

  /// 24.0
  final double spacer3;

  /// 32.0
  final double spacer4;

  /// 48.0
  final double spacer5;

  /// 80.0
  final double spacer6;

  // 字体

  /// 10.0 / 16.0
  final TextStyle font;

  /// 10.0 / 16.0
  final TextStyle fontXs;

  /// 12.0 / 20.0
  final TextStyle fontS;

  /// 14.0 / 22.0
  final TextStyle fontBase;

  /// 16.0 / 24.0
  final TextStyle fontM;

  /// 20.0 / 28.0
  final TextStyle fontL;

  /// 36.0 / 44.0
  final TextStyle fontXl;

  // 圆角

  /// 3.0
  final BorderRadius radiusSmall;

  /// 6.0
  final BorderRadius radiusDefault;

  /// 9.0
  final BorderRadius radiusLarge;

  /// 12.0
  final BorderRadius radiusExtraL;

  /// 999.0
  final BorderRadius radiusRound;

  /// 999.0
  final BorderRadius radiusCircle;

  // Components
  final TdButtonThemeData buttonTheme;

  @override
  ThemeExtension<TdThemeData> copyWith({
    Color? brandColor1,
    Color? brandColor2,
    Color? brandColor3,
    Color? brandColor4,
    Color? brandColor5,
    Color? brandColor6,
    Color? brandColor7,
    Color? brandColor8,
    Color? brandColor9,
    Color? brandColor10,
    Color? warningColor1,
    Color? warningColor2,
    Color? warningColor3,
    Color? warningColor4,
    Color? warningColor5,
    Color? warningColor6,
    Color? warningColor7,
    Color? warningColor8,
    Color? warningColor9,
    Color? warningColor10,
    Color? errorColor1,
    Color? errorColor2,
    Color? errorColor3,
    Color? errorColor4,
    Color? errorColor5,
    Color? errorColor6,
    Color? errorColor7,
    Color? errorColor8,
    Color? errorColor9,
    Color? errorColor10,
    Color? successColor1,
    Color? successColor2,
    Color? successColor3,
    Color? successColor4,
    Color? successColor5,
    Color? successColor6,
    Color? successColor7,
    Color? successColor8,
    Color? successColor9,
    Color? successColor10,
    Color? grayColor1,
    Color? grayColor2,
    Color? grayColor3,
    Color? grayColor4,
    Color? grayColor5,
    Color? grayColor6,
    Color? grayColor7,
    Color? grayColor8,
    Color? grayColor9,
    Color? grayColor10,
    Color? grayColor11,
    Color? grayColor12,
    Color? grayColor13,
    Color? grayColor14,
    Color? fontGray1,
    Color? fontGray2,
    Color? fontGray3,
    Color? fontGray4,
    Color? fontWhite1,
    Color? fontWhite2,
    Color? fontWhite3,
    Color? fontWhite4,
    List<BoxShadow>? shadow1,
    List<BoxShadow>? shadow2,
    List<BoxShadow>? shadow3,
    List<BoxShadow>? shadow4,
    Color? maskActive,
    Color? maskDisabled,
    double? spacer,
    double? spacer1,
    double? spacer2,
    double? spacer3,
    double? spacer4,
    double? spacer5,
    double? spacer6,
    TextStyle? font,
    TextStyle? fontXs,
    TextStyle? fontS,
    TextStyle? fontBase,
    TextStyle? fontM,
    TextStyle? fontL,
    TextStyle? fontXl,
    BorderRadius? radiusSmall,
    BorderRadius? radiusDefault,
    BorderRadius? radiusLarge,
    BorderRadius? radiusExtraL,
    BorderRadius? radiusRound,
    BorderRadius? radiusCircle,
  }) {
    return TdThemeData(
      brandColor1: brandColor1 ?? this.brandColor1,
      brandColor2: brandColor2 ?? this.brandColor2,
      brandColor3: brandColor3 ?? this.brandColor3,
      brandColor4: brandColor4 ?? this.brandColor4,
      brandColor5: brandColor5 ?? this.brandColor5,
      brandColor6: brandColor6 ?? this.brandColor6,
      brandColor7: brandColor7 ?? this.brandColor7,
      brandColor8: brandColor8 ?? this.brandColor8,
      brandColor9: brandColor9 ?? this.brandColor9,
      brandColor10: brandColor10 ?? this.brandColor10,
      warningColor1: warningColor1 ?? this.warningColor1,
      warningColor2: warningColor2 ?? this.warningColor2,
      warningColor3: warningColor3 ?? this.warningColor3,
      warningColor4: warningColor4 ?? this.warningColor4,
      warningColor5: warningColor5 ?? this.warningColor5,
      warningColor6: warningColor6 ?? this.warningColor6,
      warningColor7: warningColor7 ?? this.warningColor7,
      warningColor8: warningColor8 ?? this.warningColor8,
      warningColor9: warningColor9 ?? this.warningColor9,
      warningColor10: warningColor10 ?? this.warningColor10,
      errorColor1: errorColor1 ?? this.errorColor1,
      errorColor2: errorColor2 ?? this.errorColor2,
      errorColor3: errorColor3 ?? this.errorColor3,
      errorColor4: errorColor4 ?? this.errorColor4,
      errorColor5: errorColor5 ?? this.errorColor5,
      errorColor6: errorColor6 ?? this.errorColor6,
      errorColor7: errorColor7 ?? this.errorColor7,
      errorColor8: errorColor8 ?? this.errorColor8,
      errorColor9: errorColor9 ?? this.errorColor9,
      errorColor10: errorColor10 ?? this.errorColor10,
      successColor1: successColor1 ?? this.successColor1,
      successColor2: successColor2 ?? this.successColor2,
      successColor3: successColor3 ?? this.successColor3,
      successColor4: successColor4 ?? this.successColor4,
      successColor5: successColor5 ?? this.successColor5,
      successColor6: successColor6 ?? this.successColor6,
      successColor7: successColor7 ?? this.successColor7,
      successColor8: successColor8 ?? this.successColor8,
      successColor9: successColor9 ?? this.successColor9,
      successColor10: successColor10 ?? this.successColor10,
      grayColor1: grayColor1 ?? this.grayColor1,
      grayColor2: grayColor2 ?? this.grayColor2,
      grayColor3: grayColor3 ?? this.grayColor3,
      grayColor4: grayColor4 ?? this.grayColor4,
      grayColor5: grayColor5 ?? this.grayColor5,
      grayColor6: grayColor6 ?? this.grayColor6,
      grayColor7: grayColor7 ?? this.grayColor7,
      grayColor8: grayColor8 ?? this.grayColor8,
      grayColor9: grayColor9 ?? this.grayColor9,
      grayColor10: grayColor10 ?? this.grayColor10,
      grayColor11: grayColor11 ?? this.grayColor11,
      grayColor12: grayColor12 ?? this.grayColor12,
      grayColor13: grayColor13 ?? this.grayColor13,
      grayColor14: grayColor14 ?? this.grayColor14,
      fontGray1: fontGray1 ?? this.fontGray1,
      fontGray2: fontGray2 ?? this.fontGray2,
      fontGray3: fontGray3 ?? this.fontGray3,
      fontGray4: fontGray4 ?? this.fontGray4,
      fontWhite1: fontWhite1 ?? this.fontWhite1,
      fontWhite2: fontWhite2 ?? this.fontWhite2,
      fontWhite3: fontWhite3 ?? this.fontWhite3,
      fontWhite4: fontWhite4 ?? this.fontWhite4,
      shadow1: shadow1 ?? this.shadow1,
      shadow2: shadow2 ?? this.shadow2,
      shadow3: shadow3 ?? this.shadow3,
      shadow4: shadow4 ?? this.shadow4,
      maskActive: maskActive ?? this.maskActive,
      maskDisabled: maskDisabled ?? this.maskDisabled,
      spacer: spacer ?? this.spacer,
      spacer1: spacer1 ?? this.spacer1,
      spacer2: spacer2 ?? this.spacer2,
      spacer3: spacer3 ?? this.spacer3,
      spacer4: spacer4 ?? this.spacer4,
      spacer5: spacer5 ?? this.spacer5,
      spacer6: spacer6 ?? this.spacer6,
      font: font ?? this.font,
      fontXs: fontXs ?? this.fontXs,
      fontS: fontS ?? this.fontS,
      fontBase: fontBase ?? this.fontBase,
      fontM: fontM ?? this.fontM,
      fontL: fontL ?? this.fontL,
      fontXl: fontXl ?? this.fontXl,
      radiusSmall: radiusSmall ?? this.radiusSmall,
      radiusDefault: radiusDefault ?? this.radiusDefault,
      radiusLarge: radiusLarge ?? this.radiusLarge,
      radiusExtraL: radiusExtraL ?? this.radiusExtraL,
      radiusRound: radiusRound ?? this.radiusRound,
      radiusCircle: radiusCircle ?? this.radiusCircle,
    );
  }

  @override
  ThemeExtension<TdThemeData> lerp(covariant ThemeExtension<TdThemeData>? other, double t) {
    if (other is! TdThemeData) {
      return this;
    }

    return TdThemeData.raw(
      brightness: other.brightness,
      brandColor1: other.brandColor1,
      brandColor2: other.brandColor2,
      brandColor3: other.brandColor3,
      brandColor4: other.brandColor4,
      brandColor5: other.brandColor5,
      brandColor6: other.brandColor6,
      brandColor7: other.brandColor7,
      brandColor8: other.brandColor8,
      brandColor9: other.brandColor9,
      brandColor10: other.brandColor10,
      warningColor1: other.warningColor1,
      warningColor2: other.warningColor2,
      warningColor3: other.warningColor3,
      warningColor4: other.warningColor4,
      warningColor5: other.warningColor5,
      warningColor6: other.warningColor6,
      warningColor7: other.warningColor7,
      warningColor8: other.warningColor8,
      warningColor9: other.warningColor9,
      warningColor10: other.warningColor10,
      errorColor1: other.errorColor1,
      errorColor2: other.errorColor2,
      errorColor3: other.errorColor3,
      errorColor4: other.errorColor4,
      errorColor5: other.errorColor5,
      errorColor6: other.errorColor6,
      errorColor7: other.errorColor7,
      errorColor8: other.errorColor8,
      errorColor9: other.errorColor9,
      errorColor10: other.errorColor10,
      successColor1: other.successColor1,
      successColor2: other.successColor2,
      successColor3: other.successColor3,
      successColor4: other.successColor4,
      successColor5: other.successColor5,
      successColor6: other.successColor6,
      successColor7: other.successColor7,
      successColor8: other.successColor8,
      successColor9: other.successColor9,
      successColor10: other.successColor10,
      grayColor1: other.grayColor1,
      grayColor2: other.grayColor2,
      grayColor3: other.grayColor3,
      grayColor4: other.grayColor4,
      grayColor5: other.grayColor5,
      grayColor6: other.grayColor6,
      grayColor7: other.grayColor7,
      grayColor8: other.grayColor8,
      grayColor9: other.grayColor9,
      grayColor10: other.grayColor10,
      grayColor11: other.grayColor11,
      grayColor12: other.grayColor12,
      grayColor13: other.grayColor13,
      grayColor14: other.grayColor14,
      fontGray1: other.fontGray1,
      fontGray2: other.fontGray2,
      fontGray3: other.fontGray3,
      fontGray4: other.fontGray4,
      fontWhite1: other.fontWhite1,
      fontWhite2: other.fontWhite2,
      fontWhite3: other.fontWhite3,
      fontWhite4: other.fontWhite4,
      brandColor: other.brandColor,
      brandColorActive: other.brandColorActive,
      brandColorDisabled: other.brandColorDisabled,
      brandColorFocus: other.brandColorFocus,
      brandColorLight: other.brandColorLight,
      brandColorLightActive: other.brandColorLightActive,
      warningColor: other.warningColor,
      warningColorActive: other.warningColorActive,
      warningColorDisabled: other.warningColorDisabled,
      warningColorFocus: other.warningColorFocus,
      warningColorLight: other.warningColorLight,
      warningColorLightActive: other.warningColorLightActive,
      errorColor: other.errorColor,
      errorColorActive: other.errorColorActive,
      errorColorDisabled: other.errorColorDisabled,
      errorColorFocus: other.errorColorFocus,
      errorColorLight: other.errorColorLight,
      errorColorLightActive: other.errorColorLightActive,
      successColor: other.successColor,
      successColorActive: other.successColorActive,
      successColorDisabled: other.successColorDisabled,
      successColorFocus: other.successColorFocus,
      successColorLight: other.successColorLight,
      successColorLightActive: other.successColorLightActive,
      backgroundColorPage: other.backgroundColorPage,
      backgroundColorContainer: other.backgroundColorContainer,
      backgroundColorContainerActive: other.backgroundColorContainerActive,
      backgroundColorSecondaryContainer: other.backgroundColorSecondaryContainer,
      backgroundColorSecondaryContainerActive: other.backgroundColorSecondaryContainerActive,
      backgroundColorComponent: other.backgroundColorComponent,
      backgroundColorComponentActive: other.backgroundColorComponentActive,
      backgroundColorComponentDisabled: other.backgroundColorComponentDisabled,
      textColorPrimary: other.textColorPrimary,
      textColorSecondary: other.textColorSecondary,
      textColorPlaceholder: other.textColorPlaceholder,
      textColorDisabled: other.textColorDisabled,
      textColorAnti: other.textColorAnti,
      textColorBrand: other.textColorBrand,
      textColorLink: other.textColorLink,
      componentStroke: other.componentStroke,
      componentBorder: other.componentBorder,
      shadow1: other.shadow1,
      shadow2: other.shadow2,
      shadow3: other.shadow3,
      shadow4: other.shadow4,
      maskActive: other.maskActive,
      maskDisabled: other.maskDisabled,
      spacer: other.spacer,
      spacer1: other.spacer1,
      spacer2: other.spacer2,
      spacer3: other.spacer3,
      spacer4: other.spacer4,
      spacer5: other.spacer5,
      spacer6: other.spacer6,
      font: other.font,
      fontXs: other.fontXs,
      fontS: other.fontS,
      fontBase: other.fontBase,
      fontM: other.fontM,
      fontL: other.fontL,
      fontXl: other.fontXl,
      radiusSmall: other.radiusSmall,
      radiusDefault: other.radiusDefault,
      radiusLarge: other.radiusLarge,
      radiusExtraL: other.radiusExtraL,
      radiusRound: other.radiusRound,
      radiusCircle: other.radiusCircle,
      buttonTheme: other.buttonTheme,
    );
  }
}
