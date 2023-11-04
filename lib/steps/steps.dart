import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:tdesign_icons_flutter/tdesign_icons_flutter.dart';

import '../theme/export.dart';
import './step_item.dart';
import './interface.dart';

const kTdStepIconSize = 24.0;
const kTdStepItemWidth = 96.0;

class TdSteps extends StatelessWidget {
  const TdSteps({
    super.key,
    this.layout = Axis.horizontal,
    this.contentPadding,
    this.status,
    this.currentStep = 0,
    required this.steps,
  });

  /// 步骤条方向
  final Axis layout;

  /// 内容的边距
  final EdgeInsets? contentPadding;

  /// 当前步骤的状态
  final TdStepStatus? status;

  /// 当前步骤
  final int currentStep;

  /// 步骤元素
  final List<TdStepItem> steps;

  TdStepStatus _getStepStatus(int index) {
    if (index > currentStep) {
      return TdStepStatus.none;
    } else if (index == currentStep) {
      return status ?? TdStepStatus.process;
    } else {
      return TdStepStatus.finish;
    }
  }

  Widget _buildCircle(
    TdThemeData theme, {
    required Color foregroundColor,
    required Color backgroundColor,
    required Widget child,
  }) {
    return Container(
      width: kTdStepIconSize,
      height: kTdStepIconSize,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
      ),
      child: IconTheme(
        data: IconThemeData(
          color: foregroundColor,
          size: 14.0,
        ),
        child: DefaultTextStyle(
            style: theme.fontBase.copyWith(color: foregroundColor),
            textAlign: TextAlign.center,
            child: child),
      ),
    );
  }

  Widget _buildIcon(
    TdThemeData theme, {
    required TdStepStatus status,
    required int index,
    Widget? icon,
  }) {
    final (foregroundColor, backgroundColor, child) = switch (status) {
      TdStepStatus.none => (
          theme.textColorPlaceholder,
          theme.backgroundColorSecondaryContainer,
          Text('${index + 1}')
        ),
      TdStepStatus.process => (
          theme.fontWhite1,
          theme.brandColor,
          Text('${index + 1}')
        ),
      TdStepStatus.finish => (
          theme.brandColor,
          theme.brandColorLight,
          const Icon(TdIcons.check)
        ),
      TdStepStatus.error => (
          theme.errorColor,
          theme.errorColor1,
          const Icon(TdIcons.close)
        ),
    };

    return _buildCircle(
      theme,
      foregroundColor: foregroundColor,
      backgroundColor: backgroundColor,
      child: icon ?? child,
    );
  }

  Widget _buildLine(
    TdThemeData theme, {
    required TdStepStatus status,
  }) {
    return Container(
      height: 1.0,
      color: switch (status) {
        TdStepStatus.finish => theme.brandColor,
        _ => theme.componentBorder,
      },
    );
  }

  Widget _buildTitle(
    TdThemeData theme, {
    required TdStepStatus status,
    required Widget title,
  }) {
    final (color, fontWeight) = switch (status) {
      TdStepStatus.none => (theme.textColorPlaceholder, null),
      TdStepStatus.process => (theme.brandColor, FontWeight.w600),
      TdStepStatus.finish => (theme.textColorPrimary, null),
      TdStepStatus.error => (theme.errorColor1, null),
    };

    return DefaultTextStyle(
      style: theme.fontM.copyWith(
        color: color,
        fontWeight: fontWeight,
      ),
      textAlign: TextAlign.center,
      child: title,
    );
  }

  Widget _buildHorizontal(BuildContext context) {
    final theme = TdTheme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = max(
          constraints.maxWidth -
              (contentPadding != null
                  ? contentPadding!.left + contentPadding!.right
                  : 0),
          steps.length * kTdStepItemWidth,
        );

        /// 手动计算每个的宽度
        final padding = (maxWidth / steps.length - kTdStepIconSize) / 2;

        final List<Widget> iconList = [];
        final List<Widget> contentList = [];

        for (var i = 0; i < steps.length; i++) {
          final item = steps[i];
          final status = item.status ?? _getStepStatus(i);

          iconList.add(_buildIcon(
            theme,
            status: status,
            index: i,
            icon: item.icon,
          ));

          /// 添加连接线
          if (i != (steps.length - 1)) {
            iconList.add(Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: theme.spacer),
                child: _buildLine(theme, status: status),
              ),
            ));
          }

          contentList.add(Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: theme.spacer),
              child: Column(
                children: [
                  _buildTitle(
                    theme,
                    status: status,
                    title: item.title,
                  ),
                  if (item.content != null)
                    DefaultTextStyle(
                      style: theme.fontBase.copyWith(color: theme.textColorPlaceholder),
                      textAlign: TextAlign.center,
                      child: item.content!,
                    ),
                ],
              ),
            ),
          ));
        }

        final result = Padding(
          padding: contentPadding ?? EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: padding),
                child: Row(
                  children: iconList,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: theme.spacer / 2),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: contentList,
                ),
              ),
            ],
          ),
        );

        /// 最大宽度大于容器宽度时展示滚动条
        if (maxWidth > constraints.maxWidth) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: maxWidth,
              child: result,
            ),
          );
        }

        return result;
      },
    );
  }

  Widget _buildVertical(BuildContext context) {
    final theme = TdTheme.of(context);

    final List<Widget> list = [];

    for (var i = 0; i < steps.length; i++) {
      final item = steps[i];
      final status = item.status ?? _getStepStatus(i);

      /// header
      list.add(Row(
        children: [
          _buildIcon(
            theme,
            status: status,
            index: i,
            icon: item.icon,
          ),
          SizedBox(width: theme.spacer),
          _buildTitle(
            theme,
            status: status,
            title: item.title,
          ),
        ],
      ));

      /// 是否是最后一条
      final isLast = i == (steps.length - 1);

      /// 是否有内容
      final hasContent = item.content != null;

      /// content
      if (!isLast || hasContent) {
        list.add(Padding(
          padding: EdgeInsets.symmetric(vertical: theme.spacer),
          child: Stack(
            children: [
              /// 添加连接线
              if (!isLast)
                Positioned(
                  left: 0.0,
                  top: 0.0,
                  bottom: 0.0,
                  child: SizedBox(
                    width: kTdStepIconSize,
                    child: Center(
                      child: Container(
                        width: 1.0,
                        color: switch (status) {
                          TdStepStatus.finish => theme.brandColor,
                          _ => theme.componentBorder,
                        },
                      ),
                    ),
                  ),
                ),
              Padding(
                padding: EdgeInsets.only(
                  left: kTdStepIconSize + theme.spacer,
                  bottom: theme.spacer2,
                ),
                child: hasContent
                    ? DefaultTextStyle(
                        style: theme.fontBase.copyWith(color: theme.textColorPlaceholder),
                        child: item.content!,
                      )
                    : null,
              )
            ],
          ),
        ));
      }
    }

    return Padding(
      padding: contentPadding ?? EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: list,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return switch (layout) {
      Axis.horizontal => _buildHorizontal(context),
      Axis.vertical => _buildVertical(context),
    };
  }
}
