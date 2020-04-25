// Copyright 2020 Amatucci & Strippoli. All rights reserved.

import 'package:flutter/material.dart';

class SeatCheckBox extends StatefulWidget {
  final double width;
  final double height;
  final double borderWidth;
  final double borderRadius;
  final Color backgroundColor;
  final Color backgroundColorChecked;
  final Color backgroundColorDisabled;
  final Color borderColor;
  final Color borderColorChecked;
  final Color highlightColor;
  final Color splashColor;
  bool checked;
  bool disabled;

  SeatCheckBox({
    this.width = 30,
    this.height = 30,
    this.borderWidth = 1.5,
    this.borderRadius = 5.0,
    this.backgroundColor = Colors.black,
    this.backgroundColorChecked = Colors.green,
    this.backgroundColorDisabled = Colors.grey,
    this.borderColor = Colors.grey,
    this.borderColorChecked = Colors.greenAccent,
    this.highlightColor: Colors.white24,
    this.splashColor: Colors.white38,
    this.checked = false,
    this.disabled = false,
  });

  @override
  _SeatCheckBoxState createState() => _SeatCheckBoxState();
}

class _SeatCheckBoxState extends State<SeatCheckBox> {
  bool _disabled;
  bool _checked;
  Widget _currentWidget;
  Color _color;
  Color _borderColor;

  @override
  void initState() {
    _disabled = widget.disabled;
    _checked = widget.checked;
    _currentWidget = Text("", key: ValueKey<bool>(_checked));
    
    if(_disabled)
      _color = widget.backgroundColorDisabled;
    else
      _color = widget.backgroundColor;
    _borderColor = widget.borderColor;
    super.initState();
  }

  void _onCheckBoxTap() {
    setState(() {
      if (!_disabled) {
        _checked = !_checked;
        if (_checked) {
          _currentWidget = Icon(Icons.check, color: widget.backgroundColor, key: ValueKey<bool>(_checked));
          _color = widget.backgroundColorChecked;
          _borderColor = widget.borderColorChecked;
        } else {
          _currentWidget = Text("", key: ValueKey<bool>(_checked));
          _color = widget.backgroundColor;
          _borderColor = widget.borderColor;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      width: widget.width,
      height: widget.height,
      decoration: new BoxDecoration(
        color: _color,
        border: Border.all(width: widget.borderWidth, color: _borderColor),
        borderRadius:
            new BorderRadius.all(Radius.circular(widget.borderRadius)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          highlightColor: widget.highlightColor,
          splashColor: widget.splashColor,
          onTap: _onCheckBoxTap,
          child: Center(
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 200),
              child: _currentWidget,
              transitionBuilder: (Widget child, Animation<double> animation) {
                return ScaleTransition(child: child, scale: animation);
              },
            ),
          ),
        ),
      ),
    );
  }
}
