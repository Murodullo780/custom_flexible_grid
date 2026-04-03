import 'package:flutter/material.dart';

/// A customizable flexible grid widget that supports vertical and horizontal layout,
/// item spacing, builder constructor and scroll customization.
class CustomFlexibleGrid extends StatelessWidget {
  /// Optional fixed height or width (based on axis).
  final double? size;

  /// Static list of children widgets.
  final List<Widget>? children;

  /// If using builder pattern.
  final int? itemCount;

  /// If using builder, required.
  final IndexedWidgetBuilder? itemBuilder;

  /// Layout config (count and spacing).
  final CustomFlexibleGridDelegate delegate;

  /// Axis of scroll (vertical or horizontal).
  final Axis axis;

  /// Scroll physics (default: Bouncing).
  final ScrollPhysics? physics;

  /// Optional scroll controller.
  final ScrollController? controller;

  /// Whether to shrink the scroll view.
  final bool shrinkWrap;

  /// Optional padding around the grid.
  final EdgeInsets? padding;

  /// MainAxisAlignment for Row/Column of columns/rows.
  final MainAxisAlignment? mainAxisAlignment;

  const CustomFlexibleGrid({
    super.key,
    this.size,
    required this.children,
    required this.delegate,
    this.axis = Axis.vertical,
    this.physics,
    this.controller,
    this.shrinkWrap = false,
    this.padding,
    this.mainAxisAlignment,
  })  : itemCount = null,
        itemBuilder = null;

  /// Builder constructor.
  const CustomFlexibleGrid.builder({
    super.key,
    this.size,
    required this.itemCount,
    required this.itemBuilder,
    required this.delegate,
    this.axis = Axis.vertical,
    this.physics,
    this.controller,
    this.shrinkWrap = false,
    this.padding,
    this.mainAxisAlignment,
  }) : children = null;

  @override
  Widget build(BuildContext context) {
    final isVertical = axis == Axis.vertical;
    final count = delegate.crossAxisCount;

    final List<List<Widget>> buckets = List.generate(count, (_) => []);

    final items = children ??
        List.generate(itemCount!, (index) => itemBuilder!(context, index));

    for (int i = 0; i < items.length; i++) {
      final index = i % count;
      buckets[index].add(items[i]);
    }

    final childrenList = List.generate(count, (index) {
      final items = _addSpacing(
        buckets[index],
        isVertical ? delegate.mainAxisSpacing : delegate.crossAxisSpacing,
        isVertical,
      );

      return Expanded(
        child: isVertical
            ? Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: items,
        )
            : Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: items,
        ),
      );
    }).insertSeparators(
      SizedBox(
        width: isVertical ? delegate.crossAxisSpacing : 0,
        height: isVertical ? 0 : delegate.mainAxisSpacing,
      ),
    );

    final layout = Padding(
      padding: padding ?? const EdgeInsets.all(12),
      child: isVertical
          ? Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
        children: childrenList,
      )
          : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
        children: childrenList,
      ),
    );

    final scrollView = SingleChildScrollView(
      scrollDirection: axis,
      physics: physics,
      controller: controller,
      padding: EdgeInsets.zero,
      child: layout,
    );

    return size != null
        ? SizedBox(
      height: isVertical ? size : null,
      width: isVertical ? null : size,
      child: scrollView,
    )
        : scrollView;
  }

  /// Insert spacing between children
  List<Widget> _addSpacing(List<Widget> widgets, double spacing, bool isVertical) {
    if (widgets.isEmpty) return [];
    final result = <Widget>[];
    for (int i = 0; i < widgets.length; i++) {
      result.add(widgets[i]);
      if (i != widgets.length - 1) {
        result.add(isVertical
            ? SizedBox(height: spacing)
            : SizedBox(width: spacing));
      }
    }
    return result;
  }
}

/// Layout configuration for CustomFlexibleGrid
@immutable
class CustomFlexibleGridDelegate {
  final int crossAxisCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;

  const CustomFlexibleGridDelegate({
    required this.crossAxisCount,
    this.mainAxisSpacing = 0,
    this.crossAxisSpacing = 0,
  }) : assert(crossAxisCount > 0);
}

/// Separator extension.
extension _InsertSeparators on List<Widget> {
  List<Widget> insertSeparators(Widget separator) {
    if (length <= 1) return this;
    final separated = <Widget>[];
    for (int i = 0; i < length; i++) {
      separated.add(this[i]);
      if (i != length - 1) separated.add(separator);
    }
    return separated;
  }
}