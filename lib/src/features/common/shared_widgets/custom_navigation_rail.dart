import 'dart:ui';

import 'package:flutter/material.dart';

const double _kCircularIndicatorDiameter = 56;
const double _kIndicatorHeight = 32;

class CustomNavigationRail extends StatefulWidget {
  const CustomNavigationRail({
    super.key,
    this.backgroundColor,
    this.extended = false,
    this.leading,
    this.trailing,
    required this.destinations,
    required this.selectedIndex,
    this.onDestinationSelected,
    this.elevation,
    this.groupAlignment,
    this.labelType,
    this.unselectedLabelTextStyle,
    this.selectedLabelTextStyle,
    this.unselectedIconTheme,
    this.selectedIconTheme,
    this.minWidth,
    this.minExtendedWidth,
    this.useIndicator,
    this.indicatorColor,
    this.indicatorShape,
  }) : assert(selectedIndex == null || (0 <= selectedIndex && selectedIndex < destinations.length)),
       assert(elevation == null || elevation > 0),
       assert(minWidth == null || minWidth > 0),
       assert(minExtendedWidth == null || minExtendedWidth > 0),
       assert((minWidth == null || minExtendedWidth == null) || minExtendedWidth >= minWidth),
       assert(!extended || (labelType == null || labelType == NavigationRailLabelType.none));

  final Color? backgroundColor;

  final bool extended;

  final Widget? leading;

  final Widget? trailing;

  final List<NavigationRailDestination> destinations;

  final int? selectedIndex;

  final ValueChanged<int>? onDestinationSelected;

  final double? elevation;

  final double? groupAlignment;

  final NavigationRailLabelType? labelType;

  final TextStyle? unselectedLabelTextStyle;

  final TextStyle? selectedLabelTextStyle;

  final IconThemeData? unselectedIconTheme;

  final IconThemeData? selectedIconTheme;

  final double? minWidth;

  final double? minExtendedWidth;

  final bool? useIndicator;

  final Color? indicatorColor;

  final ShapeBorder? indicatorShape;

  static Animation<double> extendedAnimation(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_ExtendedNavigationRailAnimation>()!.animation;
  }

  @override
  State<CustomNavigationRail> createState() => _NavigationRailState();
}

class _NavigationRailState extends State<CustomNavigationRail> with TickerProviderStateMixin {
  late List<AnimationController> _destinationControllers;
  late List<Animation<double>> _destinationAnimations;
  late AnimationController _extendedController;
  late CurvedAnimation _extendedAnimation;

  @override
  void initState() {
    super.initState();
    _initControllers();
  }

  @override
  void dispose() {
    _disposeControllers();
    super.dispose();
  }

  @override
  void didUpdateWidget(CustomNavigationRail oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.extended != oldWidget.extended) {
      if (widget.extended) {
        _extendedController.forward();
      } else {
        _extendedController.reverse();
      }
    }

    if (widget.destinations.length != oldWidget.destinations.length) {
      _resetState();
      return;
    }

    if (widget.selectedIndex != oldWidget.selectedIndex) {
      if (oldWidget.selectedIndex != null) {
        _destinationControllers[oldWidget.selectedIndex!].reverse();
      }
      if (widget.selectedIndex != null) {
        _destinationControllers[widget.selectedIndex!].forward();
      }
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final NavigationRailThemeData navigationRailTheme = NavigationRailTheme.of(context);
    final NavigationRailThemeData defaults = Theme.of(context).useMaterial3
        ? _NavigationRailDefaultsM3(context)
        : _NavigationRailDefaultsM2(context);
    final MaterialLocalizations localizations = MaterialLocalizations.of(context);

    final Color backgroundColor =
        widget.backgroundColor ?? navigationRailTheme.backgroundColor ?? defaults.backgroundColor!;
    final double elevation = widget.elevation ?? navigationRailTheme.elevation ?? defaults.elevation!;
    final double minWidth = widget.minWidth ?? navigationRailTheme.minWidth ?? defaults.minWidth!;
    final double minExtendedWidth =
        widget.minExtendedWidth ?? navigationRailTheme.minExtendedWidth ?? defaults.minExtendedWidth!;
    final TextStyle unselectedLabelTextStyle =
        widget.unselectedLabelTextStyle ??
        navigationRailTheme.unselectedLabelTextStyle ??
        defaults.unselectedLabelTextStyle!;
    final TextStyle selectedLabelTextStyle =
        widget.selectedLabelTextStyle ?? navigationRailTheme.selectedLabelTextStyle ?? defaults.selectedLabelTextStyle!;
    final IconThemeData unselectedIconTheme =
        widget.unselectedIconTheme ?? navigationRailTheme.unselectedIconTheme ?? defaults.unselectedIconTheme!;
    final IconThemeData selectedIconTheme =
        widget.selectedIconTheme ?? navigationRailTheme.selectedIconTheme ?? defaults.selectedIconTheme!;
    final double groupAlignment =
        widget.groupAlignment ?? navigationRailTheme.groupAlignment ?? defaults.groupAlignment!;
    final NavigationRailLabelType labelType = widget.labelType ?? navigationRailTheme.labelType ?? defaults.labelType!;
    final bool useIndicator = widget.useIndicator ?? navigationRailTheme.useIndicator ?? defaults.useIndicator!;
    final Color? indicatorColor =
        widget.indicatorColor ?? navigationRailTheme.indicatorColor ?? defaults.indicatorColor;
    final ShapeBorder? indicatorShape =
        widget.indicatorShape ?? navigationRailTheme.indicatorShape ?? defaults.indicatorShape;

    final IconThemeData effectiveUnselectedIconTheme = Theme.of(context).useMaterial3
        ? unselectedIconTheme
        : unselectedIconTheme.copyWith(
            opacity: unselectedIconTheme.opacity ?? defaults.unselectedIconTheme!.opacity,
          );

    final bool isRTLDirection = Directionality.of(context) == TextDirection.rtl;

    return _ExtendedNavigationRailAnimation(
      animation: _extendedAnimation,
      child: Semantics(
        explicitChildNodes: true,
        child: Material(
          elevation: elevation,
          color: backgroundColor,
          child: SafeArea(
            right: isRTLDirection,
            left: !isRTLDirection,
            child: Column(
              children: <Widget>[
                _verticalSpacer,
                if (widget.leading != null) ...<Widget>[widget.leading!, _verticalSpacer],
                Expanded(
                  child: Align(
                    alignment: Alignment(0, groupAlignment),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        for (int i = 0; i < widget.destinations.length; i += 1)
                          _RailDestination(
                            minWidth: minWidth,
                            minExtendedWidth: minExtendedWidth,
                            extendedTransitionAnimation: _extendedAnimation,
                            selected: widget.selectedIndex == i,
                            icon: widget.selectedIndex == i
                                ? widget.destinations[i].selectedIcon
                                : widget.destinations[i].icon,
                            label: widget.destinations[i].label,
                            destinationAnimation: _destinationAnimations[i],
                            labelType: labelType,
                            iconTheme: widget.selectedIndex == i ? selectedIconTheme : effectiveUnselectedIconTheme,
                            labelTextStyle: widget.selectedIndex == i
                                ? selectedLabelTextStyle
                                : unselectedLabelTextStyle,
                            padding: widget.destinations[i].padding,
                            useIndicator: useIndicator,
                            indicatorColor: useIndicator ? indicatorColor : null,
                            indicatorShape: useIndicator ? indicatorShape : null,
                            onTap: () {
                              if (widget.onDestinationSelected != null) {
                                widget.onDestinationSelected!(i);
                              }
                            },
                            indexLabel: localizations.tabLabel(
                              tabIndex: i + 1,
                              tabCount: widget.destinations.length,
                            ),
                            disabled: widget.destinations[i].disabled,
                          ),
                        if (widget.trailing != null) widget.trailing!,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _disposeControllers() {
    for (final AnimationController controller in _destinationControllers) {
      controller.dispose();
    }
    _extendedController.dispose();
    _extendedAnimation.dispose();
  }

  void _initControllers() {
    _destinationControllers = List<AnimationController>.generate(widget.destinations.length, (
      int index,
    ) {
      return AnimationController(duration: kThemeAnimationDuration, vsync: this)..addListener(_rebuild);
    });
    _destinationAnimations = _destinationControllers.map((AnimationController controller) => controller.view).toList();
    if (widget.selectedIndex != null) {
      _destinationControllers[widget.selectedIndex!].value = 1.0;
    }
    _extendedController = AnimationController(
      duration: kThemeAnimationDuration,
      vsync: this,
      value: widget.extended ? 1.0 : 0.0,
    );
    _extendedAnimation = CurvedAnimation(parent: _extendedController, curve: Curves.easeInOut);
    _extendedController.addListener(() {
      _rebuild();
    });
  }

  void _resetState() {
    _disposeControllers();
    _initControllers();
  }

  void _rebuild() {
    setState(() {});
  }
}

class _RailDestination extends StatefulWidget {
  const _RailDestination({
    required this.minWidth,
    required this.minExtendedWidth,
    required this.icon,
    required this.label,
    required this.destinationAnimation,
    required this.extendedTransitionAnimation,
    required this.labelType,
    required this.selected,
    required this.iconTheme,
    required this.labelTextStyle,
    required this.onTap,
    required this.indexLabel,
    this.padding,
    required this.useIndicator,
    this.indicatorColor,
    this.indicatorShape,
    this.disabled = false,
  });

  final double minWidth;
  final double minExtendedWidth;
  final Widget icon;
  final Widget label;
  final Animation<double> destinationAnimation;
  final NavigationRailLabelType labelType;
  final bool selected;
  final Animation<double> extendedTransitionAnimation;
  final IconThemeData iconTheme;
  final TextStyle labelTextStyle;
  final VoidCallback onTap;
  final String indexLabel;
  final EdgeInsetsGeometry? padding;
  final bool useIndicator;
  final Color? indicatorColor;
  final ShapeBorder? indicatorShape;
  final bool disabled;

  @override
  State<_RailDestination> createState() => _RailDestinationState();
}

class _RailDestinationState extends State<_RailDestination> {
  late CurvedAnimation _positionAnimation;

  @override
  void initState() {
    super.initState();
    _setPositionAnimation();
  }

  @override
  void didUpdateWidget(_RailDestination oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.destinationAnimation != oldWidget.destinationAnimation) {
      _positionAnimation.dispose();
      _setPositionAnimation();
    }
  }

  void _setPositionAnimation() {
    _positionAnimation = CurvedAnimation(
      parent: ReverseAnimation(widget.destinationAnimation),
      curve: Curves.easeInOut,
      reverseCurve: Curves.easeInOut.flipped,
    );
  }

  @override
  void dispose() {
    _positionAnimation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    assert(
      widget.useIndicator || widget.indicatorColor == null,
      '[NavigationRail.indicatorColor] does not have an effect when [NavigationRail.useIndicator] is false',
    );

    final ThemeData theme = Theme.of(context);
    final TextDirection textDirection = Directionality.of(context);
    final bool material3 = theme.useMaterial3;
    final EdgeInsets destinationPadding = (widget.padding ?? EdgeInsets.zero).resolve(
      textDirection,
    );
    Offset indicatorOffset;
    bool applyXOffset = false;

    final Widget themedIcon = IconTheme(
      data: widget.disabled
          ? widget.iconTheme.copyWith(color: theme.colorScheme.onSurface.withOpacity(0.38))
          : widget.iconTheme,
      child: widget.icon,
    );
    final Widget styledLabel = DefaultTextStyle(
      style: widget.disabled
          ? widget.labelTextStyle.copyWith(color: theme.colorScheme.onSurface.withOpacity(0.38))
          : widget.labelTextStyle,
      child: widget.label,
    );

    Widget content;

    final bool isLargeIconSize = widget.iconTheme.size != null && widget.iconTheme.size! > _kIndicatorHeight;
    final double indicatorVerticalOffset = isLargeIconSize ? (widget.iconTheme.size! - _kIndicatorHeight) / 2 : 0;

    switch (widget.labelType) {
      case NavigationRailLabelType.none:
        final Widget? spacing = material3 ? const SizedBox(height: _verticalDestinationSpacingM3 / 2) : null;
        indicatorOffset = Offset(
          widget.minWidth / 2 + destinationPadding.left,
          _verticalDestinationSpacingM3 / 2 + destinationPadding.top + indicatorVerticalOffset,
        );
        final Widget iconPart = Column(
          children: <Widget>[
            if (spacing != null) spacing,
            SizedBox(
              width: widget.minWidth,
              height: material3 ? null : widget.minWidth,
              child: Center(
                child: _AddIndicator(
                  addIndicator: widget.useIndicator,
                  indicatorColor: widget.indicatorColor,
                  indicatorShape: widget.indicatorShape,
                  isCircular: !material3,
                  indicatorAnimation: widget.destinationAnimation,
                  child: themedIcon,
                ),
              ),
            ),
            if (spacing != null) spacing,
          ],
        );
        if (widget.extendedTransitionAnimation.value == 0) {
          content = Padding(
            padding: widget.padding ?? EdgeInsets.zero,
            child: Stack(
              children: <Widget>[
                iconPart,

                SizedBox.shrink(child: Visibility.maintain(visible: false, child: widget.label)),
              ],
            ),
          );
        } else {
          final Animation<double> labelFadeAnimation = widget.extendedTransitionAnimation.drive(
            CurveTween(curve: const Interval(0.0, 0.25)),
          );
          applyXOffset = true;
          content = Padding(
            padding: widget.padding ?? EdgeInsets.zero,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: lerpDouble(
                  widget.minWidth,
                  widget.minExtendedWidth,
                  widget.extendedTransitionAnimation.value,
                )!,
              ),
              child: ClipRect(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    iconPart,
                    Flexible(
                      child: Align(
                        heightFactor: 1.0,
                        widthFactor: widget.extendedTransitionAnimation.value,
                        alignment: AlignmentDirectional.centerStart,
                        child: FadeTransition(
                          alwaysIncludeSemantics: true,
                          opacity: labelFadeAnimation,
                          child: styledLabel,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: _horizontalDestinationPadding * widget.extendedTransitionAnimation.value,
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      case NavigationRailLabelType.selected:
        final double appearingAnimationValue = 1 - _positionAnimation.value;
        final double verticalPadding = lerpDouble(
          _verticalDestinationPaddingNoLabel,
          _verticalDestinationPaddingWithLabel,
          appearingAnimationValue,
        )!;
        final Interval interval = widget.selected ? const Interval(0.25, 0.75) : const Interval(0.75, 1.0);
        final Animation<double> labelFadeAnimation = widget.destinationAnimation.drive(
          CurveTween(curve: interval),
        );
        final double minHeight = material3 ? 0 : widget.minWidth;
        final Widget topSpacing = SizedBox(height: material3 ? 0 : verticalPadding);
        final Widget labelSpacing = SizedBox(
          height: material3 ? lerpDouble(0, _verticalIconLabelSpacingM3, appearingAnimationValue)! : 0,
        );
        final Widget bottomSpacing = SizedBox(
          height: material3 ? _verticalDestinationSpacingM3 : verticalPadding,
        );
        final double indicatorHorizontalPadding = (destinationPadding.left / 2) - (destinationPadding.right / 2);
        final double indicatorVerticalPadding = destinationPadding.top;
        indicatorOffset = Offset(
          widget.minWidth / 2 + indicatorHorizontalPadding,
          indicatorVerticalPadding + indicatorVerticalOffset,
        );
        if (widget.minWidth < _NavigationRailDefaultsM2(context).minWidth!) {
          indicatorOffset = Offset(
            widget.minWidth / 2 + _horizontalDestinationSpacingM3,
            indicatorVerticalPadding + indicatorVerticalOffset,
          );
        }
        content = ConstrainedBox(
          constraints: BoxConstraints(minWidth: widget.minWidth, minHeight: minHeight),
          child: Padding(
            padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: _horizontalDestinationPadding),
            child: ClipRect(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  topSpacing,
                  _AddIndicator(
                    addIndicator: widget.useIndicator,
                    indicatorColor: widget.indicatorColor,
                    indicatorShape: widget.indicatorShape,
                    isCircular: false,
                    indicatorAnimation: widget.destinationAnimation,
                    child: themedIcon,
                  ),
                  labelSpacing,
                  Align(
                    alignment: Alignment.topCenter,
                    heightFactor: appearingAnimationValue,
                    widthFactor: 1.0,
                    child: FadeTransition(
                      alwaysIncludeSemantics: true,
                      opacity: labelFadeAnimation,
                      child: styledLabel,
                    ),
                  ),
                  bottomSpacing,
                ],
              ),
            ),
          ),
        );
      case NavigationRailLabelType.all:
        final double minHeight = material3 ? 0 : widget.minWidth;
        final Widget topSpacing = SizedBox(
          height: material3 ? 0 : _verticalDestinationPaddingWithLabel,
        );
        final Widget labelSpacing = SizedBox(height: material3 ? _verticalIconLabelSpacingM3 : 0);
        final Widget bottomSpacing = SizedBox(
          height: material3 ? _verticalDestinationSpacingM3 : _verticalDestinationPaddingWithLabel,
        );
        final double indicatorHorizontalPadding = (destinationPadding.left / 2) - (destinationPadding.right / 2);
        final double indicatorVerticalPadding = destinationPadding.top;
        indicatorOffset = Offset(
          widget.minWidth / 2 + indicatorHorizontalPadding,
          indicatorVerticalPadding + indicatorVerticalOffset,
        );
        if (widget.minWidth < _NavigationRailDefaultsM2(context).minWidth!) {
          indicatorOffset = Offset(
            widget.minWidth / 2 + _horizontalDestinationSpacingM3,
            indicatorVerticalPadding + indicatorVerticalOffset,
          );
        }
        content = ConstrainedBox(
          constraints: BoxConstraints(minWidth: widget.minWidth, minHeight: minHeight),
          child: Padding(
            padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: _horizontalDestinationPadding),
            child: Column(
              children: <Widget>[
                topSpacing,
                _AddIndicator(
                  addIndicator: widget.useIndicator,
                  indicatorColor: widget.indicatorColor,
                  indicatorShape: widget.indicatorShape,
                  isCircular: false,
                  indicatorAnimation: widget.destinationAnimation,
                  child: themedIcon,
                ),
                labelSpacing,
                styledLabel,
                bottomSpacing,
              ],
            ),
          ),
        );
    }

    final ColorScheme colors = Theme.of(context).colorScheme;
    final bool primaryColorAlphaModified = colors.primary.alpha < 255.0;
    final Color effectiveSplashColor = primaryColorAlphaModified ? colors.primary : colors.primary.withOpacity(0.12);
    final Color effectiveHoverColor = primaryColorAlphaModified ? colors.primary : colors.primary.withOpacity(0.04);
    return Semantics(
      container: true,
      selected: widget.selected,
      child: Stack(
        children: <Widget>[
          Material(
            type: MaterialType.transparency,
            child: _IndicatorInkWell(
              onTap: widget.disabled ? null : widget.onTap,
              borderRadius: BorderRadius.all(Radius.circular(widget.minWidth / 2.0)),
              customBorder: widget.indicatorShape,
              splashColor: effectiveSplashColor,
              hoverColor: effectiveHoverColor,
              useMaterial3: material3,
              indicatorOffset: indicatorOffset,
              applyXOffset: applyXOffset,
              textDirection: textDirection,
              child: content,
            ),
          ),
          Semantics(label: widget.indexLabel),
        ],
      ),
    );
  }
}

class _IndicatorInkWell extends InkResponse {
  const _IndicatorInkWell({
    super.child,
    super.onTap,
    ShapeBorder? customBorder,
    BorderRadius? borderRadius,
    super.splashColor,
    super.hoverColor,
    required this.useMaterial3,
    required this.indicatorOffset,
    required this.applyXOffset,
    required this.textDirection,
  }) : super(
         containedInkWell: false,
         overlayColor: WidgetStateColor.transparent,
         highlightShape: BoxShape.rectangle,
         borderRadius: useMaterial3 ? null : borderRadius,
         customBorder: useMaterial3 ? customBorder : null,
       );

  final bool useMaterial3;

  final Offset indicatorOffset;

  final bool applyXOffset;

  final TextDirection textDirection;

  @override
  RectCallback? getRectCallback(RenderBox referenceBox) {
    if (useMaterial3) {
      final double boxWidth = referenceBox.size.width;
      double indicatorHorizontalCenter = applyXOffset ? indicatorOffset.dx : boxWidth / 2;
      if (textDirection == TextDirection.rtl) {
        indicatorHorizontalCenter = boxWidth - indicatorHorizontalCenter;
      }
      return () {
        return Rect.fromLTWH(
          indicatorHorizontalCenter - (_kCircularIndicatorDiameter / 2),
          indicatorOffset.dy,
          _kCircularIndicatorDiameter,
          _kIndicatorHeight,
        );
      };
    }
    return null;
  }
}

class _AddIndicator extends StatelessWidget {
  const _AddIndicator({
    required this.addIndicator,
    required this.isCircular,
    required this.indicatorColor,
    required this.indicatorShape,
    required this.indicatorAnimation,
    required this.child,
  });

  final bool addIndicator;
  final bool isCircular;
  final Color? indicatorColor;
  final ShapeBorder? indicatorShape;
  final Animation<double> indicatorAnimation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (!addIndicator) {
      return child;
    }
    late final Widget indicator;
    if (isCircular) {
      indicator = NavigationIndicator(
        animation: indicatorAnimation,
        height: _kCircularIndicatorDiameter,
        width: _kCircularIndicatorDiameter,
        borderRadius: BorderRadius.circular(_kCircularIndicatorDiameter / 2),
        color: indicatorColor,
      );
    } else {
      indicator = NavigationIndicator(
        animation: indicatorAnimation,
        width: _kCircularIndicatorDiameter,
        shape: indicatorShape,
        color: indicatorColor,
      );
    }

    return Stack(alignment: Alignment.center, children: <Widget>[indicator, child]);
  }
}

class _ExtendedNavigationRailAnimation extends InheritedWidget {
  const _ExtendedNavigationRailAnimation({required this.animation, required super.child});

  final Animation<double> animation;

  @override
  bool updateShouldNotify(_ExtendedNavigationRailAnimation old) => animation != old.animation;
}

const double _horizontalDestinationPadding = 8.0;
const double _verticalDestinationPaddingNoLabel = 24.0;
const double _verticalDestinationPaddingWithLabel = 16.0;
const Widget _verticalSpacer = SizedBox(height: 8.0);
const double _verticalIconLabelSpacingM3 = 4.0;
const double _verticalDestinationSpacingM3 = 12.0;
const double _horizontalDestinationSpacingM3 = 12.0;

class _NavigationRailDefaultsM2 extends NavigationRailThemeData {
  _NavigationRailDefaultsM2(BuildContext context)
    : _theme = Theme.of(context),
      _colors = Theme.of(context).colorScheme,
      super(
        elevation: 0,
        groupAlignment: -1,
        labelType: NavigationRailLabelType.none,
        useIndicator: false,
        minWidth: 72.0,
        minExtendedWidth: 256,
      );

  final ThemeData _theme;
  final ColorScheme _colors;

  @override
  Color? get backgroundColor => _colors.surface;

  @override
  TextStyle? get unselectedLabelTextStyle {
    return _theme.textTheme.bodyLarge!.copyWith(color: _colors.onSurface.withOpacity(0.64));
  }

  @override
  TextStyle? get selectedLabelTextStyle {
    return _theme.textTheme.bodyLarge!.copyWith(color: _colors.primary);
  }

  @override
  IconThemeData? get unselectedIconTheme {
    return IconThemeData(size: 24.0, color: _colors.onSurface, opacity: 0.64);
  }

  @override
  IconThemeData? get selectedIconTheme {
    return IconThemeData(size: 24.0, color: _colors.primary, opacity: 1.0);
  }
}

class _NavigationRailDefaultsM3 extends NavigationRailThemeData {
  _NavigationRailDefaultsM3(this.context)
    : super(
        elevation: 0.0,
        groupAlignment: -1,
        labelType: NavigationRailLabelType.none,
        useIndicator: true,
        minWidth: 80.0,
        minExtendedWidth: 256,
      );

  final BuildContext context;
  late final ColorScheme _colors = Theme.of(context).colorScheme;
  late final TextTheme _textTheme = Theme.of(context).textTheme;

  @override
  Color? get backgroundColor => _colors.surface;

  @override
  TextStyle? get unselectedLabelTextStyle {
    return _textTheme.labelMedium!.copyWith(color: _colors.onSurface);
  }

  @override
  TextStyle? get selectedLabelTextStyle {
    return _textTheme.labelMedium!.copyWith(color: _colors.onSurface);
  }

  @override
  IconThemeData? get unselectedIconTheme {
    return IconThemeData(
      size: 24.0,
      color: _colors.onSurfaceVariant,
    );
  }

  @override
  IconThemeData? get selectedIconTheme {
    return IconThemeData(
      size: 24.0,
      color: _colors.onSecondaryContainer,
    );
  }

  @override
  Color? get indicatorColor => _colors.secondaryContainer;

  @override
  ShapeBorder? get indicatorShape => const StadiumBorder();
}
