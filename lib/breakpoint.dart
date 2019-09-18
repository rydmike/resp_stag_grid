import 'package:flutter/material.dart';

/// This breakpoint class is a slight modification and fix of Rody Davis
/// breakpoint package: https://pub.dev/packages/breakpoint
/// The custom version was made to be able to experiment with
/// different different breakpoints with higher granularity
///
/// Mike Rydstrom 18.9.2019 MIT License

/// The xxsmall and xxlarge are custom additions to the Material Design
/// Guidelines window sizes.
/// [https://material.io/design/layout/responsive-layout-grid.html#grid-behavior]
enum WindowSize { xxsmall, xsmall, small, medium, large, xlarge, xxlarge }

enum LayoutClass {
  smallHandset,
  mediumHandset,
  largeHandset,
  smallTablet,
  largeTablet,
  desktop,
}

class Breakpoint {
  /// xxsmall, xsmall, small, medium, large, xlarge, xxlarge
  final WindowSize window;

  /// smallHandset, mediumHandset, largeHandset, smallTablet, largeTablet, desktop
  final LayoutClass device;

  /// Number of columns for content
  final int columns;

  /// Spacing between columns
  final double gutters;

  final Orientation orientation;

  /// Following Material Design Guidelines
  /// [https://material.io/design/layout/responsive-layout-grid.html#grid-behavior]
  const Breakpoint({
    this.columns,
    this.device,
    this.gutters,
    this.window,
    this.orientation,
  });

  /// Following Material Design Guidelines
  /// [https://material.io/design/layout/responsive-layout-grid.html#grid-behavior]
  /// Use a layout builder to get [BoxConstraints]
  factory Breakpoint.fromConstraints(BoxConstraints constraints) {
    double _width = 359;

    Orientation orientation = Orientation.portrait;

    if (constraints.debugAssertIsValid()) {
      _width = constraints.normalize().maxWidth;
      orientation = constraints.maxHeight > constraints.maxWidth
          ? Orientation.portrait
          : Orientation.landscape;
    }

    return _calcBreakpoint(orientation, _width);
  }

  /// Following Material Design Guidelines
  /// [https://material.io/design/layout/responsive-layout-grid.html#grid-behavior]
  ///
  /// Uses [BuildContext] and [MediaQuery] to calculate the device breakpoint
  /// Use [Breakpoint.fromConstraints] when the widget does not take up the full screen
  factory Breakpoint.fromMediaQuery(BuildContext context) {
    final _media = MediaQuery.of(context);

    double _width = 359;

    Orientation orientation = Orientation.portrait;

    _width = _media.size.width;
    orientation = _media.orientation;

    return _calcBreakpoint(orientation, _width);
  }

  /// This breakpoint calculation does not strictly follow the Material Design
  /// Guidelines for breakpoints
  /// [https://material.io/design/layout/responsive-layout-grid.html#grid-behavior]
  /// it is modified to experiment with different values with more granularity
  /// and a bit tighter layout
  ///
  static Breakpoint _calcBreakpoint(Orientation orientation, double _width) {
    bool isPortrait = orientation == Orientation.portrait;

    if (_width >= 2880) {
      return Breakpoint(
        columns: 12,
        gutters: 16,
        device: LayoutClass.desktop,
        window: WindowSize.xxlarge,
        orientation: orientation,
      );
    }
    if (_width >= 1920) {
      return Breakpoint(
        columns: 12,
        gutters: 14,
        device: LayoutClass.desktop,
        window: WindowSize.xlarge,
        orientation: orientation,
      );
    }
    if (_width >= 1600) {
      return Breakpoint(
        columns: 12,
        gutters: 12,
        device: LayoutClass.desktop,
        window: WindowSize.large,
        orientation: orientation,
      );
    }
    if (_width >= 1440) {
      return Breakpoint(
        columns: 10,
        gutters: 12,
        device: LayoutClass.desktop,
        window: WindowSize.large,
        orientation: orientation,
      );
    }
    if (_width >= 1280) {
      return Breakpoint(
        columns: 10,
        gutters: 12,
        device: isPortrait ? LayoutClass.desktop : LayoutClass.largeTablet,
        window: WindowSize.medium,
        orientation: orientation,
      );
    }
    if (_width >= 1024) {
      return Breakpoint(
        columns: 8,
        gutters: 10,
        device: isPortrait ? LayoutClass.desktop : LayoutClass.largeTablet,
        window: WindowSize.medium,
        orientation: orientation,
      );
    }
    if (_width >= 960) {
      return Breakpoint(
        columns: 6,
        gutters: 8,
        device: isPortrait ? LayoutClass.largeTablet : LayoutClass.smallTablet,
        window: WindowSize.small,
        orientation: orientation,
      );
    }
    if (_width >= 840) {
      return Breakpoint(
        columns: 6,
        gutters: 8,
        device: isPortrait ? LayoutClass.largeTablet : LayoutClass.largeHandset,
        window: WindowSize.small,
        orientation: orientation,
      );
    }
    if (_width >= 720) {
      return Breakpoint(
        columns: 4,
        gutters: 8,
        device: isPortrait ? LayoutClass.largeTablet : LayoutClass.largeHandset,
        window: WindowSize.small,
        orientation: orientation,
      );
    }
    if (_width >= 600) {
      return Breakpoint(
        columns: 4,
        gutters: 8,
        device:
            isPortrait ? LayoutClass.smallTablet : LayoutClass.mediumHandset,
        window: WindowSize.small,
        orientation: orientation,
      );
    }
    if (_width >= 480) {
      return Breakpoint(
        columns: 4,
        gutters: 6,
        device:
            isPortrait ? LayoutClass.largeHandset : LayoutClass.smallHandset,
        window: WindowSize.xsmall,
        orientation: orientation,
      );
    }
    if (_width >= 400) {
      return Breakpoint(
        columns: 4,
        gutters: 6,
        device:
            isPortrait ? LayoutClass.largeHandset : LayoutClass.smallHandset,
        window: WindowSize.xsmall,
        orientation: orientation,
      );
    }
    if (_width >= 250) {
      return Breakpoint(
        columns: 2,
        gutters: 6,
        device:
            isPortrait ? LayoutClass.mediumHandset : LayoutClass.smallHandset,
        window: WindowSize.xsmall,
      );
    }
    return Breakpoint(
      columns: 1,
      gutters: 4,
      device: LayoutClass.smallHandset,
      window: WindowSize.xxsmall,
      orientation: orientation,
    );
  }

  @override
  String toString() {
    return '$columns $window $device $orientation';
  }
}

class BreakpointBuilder extends StatelessWidget {
  /// Wraps layout builder and returns a breakpoint
  BreakpointBuilder({
    this.context,
    @required this.builder,
  });
  final Widget Function(BuildContext, Breakpoint) builder;
  final BuildContext context;
  @override
  Widget build(BuildContext root) {
    final _context = context ?? root;
    return LayoutBuilder(
      builder: (_context, constraints) {
        return builder(_context, Breakpoint.fromConstraints(constraints));
      },
    );
  }
}
