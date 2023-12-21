import 'package:flutter/material.dart';

import '../theme/export.dart';
import './interface.dart';

class TdAvatar extends StatelessWidget {
  const TdAvatar({
    super.key,
    required this.delegate,
    this.shape = BoxShape.circle,
    this.size = TdAvatarSize.medium,
  });

  TdAvatar.text({
    super.key,
    this.shape = BoxShape.circle,
    this.size = TdAvatarSize.medium,
    required Widget child,
  }) : delegate = _TdAvatarTextDelegate(
          shape: shape,
          size: size,
          child: child,
        );

  TdAvatar.icon({
    super.key,
    this.shape = BoxShape.circle,
    this.size = TdAvatarSize.medium,
    required Widget child,
  }) : delegate = _TdAvatarIconDelegate(
          shape: shape,
          size: size,
          child: child,
        );

  TdAvatar.image({
    super.key,
    this.shape = BoxShape.circle,
    this.size = TdAvatarSize.medium,
    required ImageProvider image,
  }) : delegate = _TdAvatarImageDelegate(
          image: image,
          shape: shape,
          size: size,
        );

  /// 委托
  final TdAvatarDelegate delegate;

  /// 形状
  final BoxShape shape;

  /// 尺寸
  final TdAvatarSize size;

  double _getContainerSize(TdThemeData theme) {
    switch (size) {
      case TdAvatarSize.small:
        return 40.0;
      case TdAvatarSize.medium:
        return 48.0;
      case TdAvatarSize.large:
        return 64.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = TdTheme.of(context);

    final size = _getContainerSize(theme);

    final backgroundColor = delegate.getBackgroundColor(context);

    final child = delegate.build(context);

    return Align(
      alignment: Alignment.center,
      child: Container(
        alignment: Alignment.center,
        constraints: BoxConstraints.expand(
          width: size,
          height: size,
        ),
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: shape,
          borderRadius: shape == BoxShape.rectangle ? theme.radiusDefault : null,
        ),
        clipBehavior: Clip.antiAlias,
        child: child,
      ),
    );
  }
}

abstract class TdAvatarDelegate {
  const TdAvatarDelegate({
    required this.shape,
    required this.size,
  });

  /// 形状
  final BoxShape shape;

  /// 尺寸
  final TdAvatarSize size;

  Color? getBackgroundColor(BuildContext context);

  Widget build(BuildContext context);
}

class _TdAvatarTextDelegate extends TdAvatarDelegate {
  const _TdAvatarTextDelegate({
    required this.child,
    required super.shape,
    required super.size,
  });

  final Widget child;

  @override
  Color? getBackgroundColor(BuildContext context) {
    final theme = TdTheme.of(context);

    return theme.brandColor;
  }

  @override
  Widget build(BuildContext context) {
    final theme = TdTheme.of(context);

    return DefaultTextStyle(
      style: theme.fontM.copyWith(color: theme.textColorAnti),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      child: child,
    );
  }
}

class _TdAvatarIconDelegate extends TdAvatarDelegate {
  const _TdAvatarIconDelegate({
    required this.child,
    required super.shape,
    required super.size,
  });

  final Widget child;

  @override
  Color? getBackgroundColor(BuildContext context) {
    final theme = TdTheme.of(context);

    return theme.brandColorLight;
  }

  double _getIconSize(TdThemeData theme) {
    switch (size) {
      case TdAvatarSize.small:
        return 20.0;
      case TdAvatarSize.medium:
        return 24.0;
      case TdAvatarSize.large:
        return 32.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = TdTheme.of(context);

    final size = _getIconSize(theme);

    return IconTheme(
      data: IconThemeData(
        size: size,
        color: theme.brandColor,
      ),
      child: child,
    );
  }
}

class _TdAvatarImageDelegate extends TdAvatarDelegate {
  const _TdAvatarImageDelegate({
    required this.image,
    required super.shape,
    required super.size,
  });

  final ImageProvider image;

  @override
  Color? getBackgroundColor(BuildContext context) => null;

  @override
  Widget build(BuildContext context) {
    return Image(
      image: image,
      errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
    );
  }
}
