// Copyright (c) 2018, Steve Rogers. All rights reserved. Use of this source code
// is governed by an Apache License 2.0 that can be found in the LICENSE file.
library stack_overlay;

import 'package:flutter/material.dart';

/// A widget that contains 2 layers (child widgets), the foreground and the background as well as an optional [wallpaper]
///
/// The [wallpaper] is optional and should be a [BoxDecoration] widget.
/// This is used to style the base layer and then (if your other layers are transparent) show as a background wallpaper.
///
/// For examples of implementing a wallpaper see example code included with the package. This shows a sample of what can be done using
///  - a Linear Gradient
///  - a Tiled Image
///  - a Background Image
///
/// But you should be able to use any valid [BoxDecoration]
///
/// This class displays 2 child widgets (foreground and background) the [foreground] being stacked
/// on top of the [background]. The foreground widget can be hidden or displayed by specifying
/// a boolean value for [showForeground]
///
/// The [foreground]  and [background] arguemenys must not be null.
///
/// [background] is the main widget that will be displayed. It can be covered up by the [foreground]
///
/// [foreground] a widget that can be hidden or revealed using [showForeground]
///
/// [showForeground] a boolean that determines if the [foreground] is shown. If not specified defaults to false.
class StackOverlay extends StatefulWidget {
  final Widget foreground;
  final Widget background;
  final BoxDecoration wallpaper;
  final bool showForeground;

  StackOverlay(
      {@required this.foreground,
      @required this.background,
      this.wallpaper,
      this.showForeground = false});

  @override
  _StackOverlayState createState() => _StackOverlayState();
}

class _StackOverlayState extends State<StackOverlay>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Container _wallpaper;
  final double _revealSpeed = 2.0;

  void _setForeground(bool show) {
    double vel = (show) ? _revealSpeed : -_revealSpeed;
    _controller.fling(velocity: vel);
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    if (widget.wallpaper == null) {
      _wallpaper = Container();
    } else {
      _wallpaper = Container(decoration: widget.wallpaper);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData info = MediaQuery.of(context);
    _setForeground(widget.showForeground);
    Animation<RelativeRect> layerAnimation = RelativeRectTween(
      begin: RelativeRect.fromLTRB(0.0, info.size.height, 0.0, 0.0),
      end: RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
    ).animate(_controller.view);

    return Stack(
      children: <Widget>[
        _wallpaper,
        widget.background,
        PositionedTransition(
            rect: layerAnimation,
            child: _OverlayForeground(
              size: info.size,
              child: widget.foreground,
            ))
      ],
    );
  }
}

///
/// This is a container used to hold the dismissible Foreground widget
///
class _OverlayForeground extends StatelessWidget {
  final Widget child;
  final Size size;

  _OverlayForeground({@required this.child, this.size});

  @override
  Widget build(BuildContext context) {
    return Container(height: size.height, width: size.width, child: child);
  }
}
