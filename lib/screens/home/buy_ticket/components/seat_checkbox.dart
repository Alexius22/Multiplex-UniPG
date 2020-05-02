// Copyright 2020 Amatucci & Strippoli. All rights reserved.

import 'package:flutter/material.dart';

class SeatCheckBox extends StatefulWidget {
  final Key key;
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
  final bool checked;
  final bool disabled;
  final Function onCheckChange;

  SeatCheckBox({
    this.key,
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
    this.onCheckChange,
  }) : super(key: key);

  @override
  _SeatCheckBoxState createState() => _SeatCheckBoxState();
}

class _SeatCheckBoxState extends State<SeatCheckBox> {
  bool _disabled;
  bool _checked;
  Widget _currentWidget;
  Color _currentColor;
  Color _currentBorderColor;

  @override
  void initState() {
    _disabled = widget.disabled;
    _checked = widget.checked;
    _currentWidget = Text("", key: ValueKey<bool>(_checked));

    if (_disabled)
      _currentColor = widget.backgroundColorDisabled;
    else
      _currentColor = widget.backgroundColor;
    _currentBorderColor = widget.borderColor;
    super.initState();
  }

  void changeCheck(bool status) {
    setState(() {
      _checked = status;
      if (_checked) {
        _currentWidget = Icon(Icons.check,
            color: widget.backgroundColor, key: ValueKey<bool>(_checked));
        _currentColor = widget.backgroundColorChecked;
        _currentBorderColor = widget.borderColorChecked;
      } else {
        _currentWidget = Text("", key: ValueKey<bool>(_checked));
        _currentColor = widget.backgroundColor;
        _currentBorderColor = widget.borderColor;
      }
    });
  }

  void changeDisabled(status) {
    setState(() {
      _disabled = status;
      if (_disabled) {
        _currentColor = widget.backgroundColorDisabled;
      } else {
        _currentColor = widget.backgroundColorChecked;
      }
    });
  }

  void _onCheckBoxTap() {
    if (!_disabled) {
      changeCheck(!_checked);
      if (widget.onCheckChange != null) widget.onCheckChange(_checked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      width: widget.width,
      height: widget.height,
      decoration: new BoxDecoration(
        color: _currentColor,
        border:
            Border.all(width: widget.borderWidth, color: _currentBorderColor),
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
