import 'dart:core';
import 'package:flutter/material.dart';
import 'rotation_3d.dart';
import 'clipped_view.dart';
import 'navbar_item_data.dart';

// Handle the transition between selected and de-deselected, by animating it's own width,
// and modifying the color/visibility of some child widgets
class NavbarButton extends StatefulWidget {
  final NavBarItemData data;
  final bool isSelected;
  final VoidCallback onTap;

  const NavbarButton(this.data, this.isSelected, {@required this.onTap});

  @override
  _NavbarButtonState createState() => _NavbarButtonState();
}

class _NavbarButtonState extends State<NavbarButton>
    with SingleTickerProviderStateMixin {
  AnimationController _iconAnimController;
  bool _wasSelected;
  double _animScale = 1.0;

  @override
  void initState() {
    //Create a tween + controller which will drive the icon rotation
    int duration = (700 / _animScale).round();
    _iconAnimController = AnimationController(
      duration: Duration(milliseconds: duration),
      vsync: this,
    );
    Tween<double>(begin: 0, end: 1).animate(_iconAnimController)
      //Listen for tween updates, and rebuild the widget tree on each tick
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _startAnimIfSelectedChanged(widget.isSelected);
    //Create our main button, a Row, with an icon and some text
    //Inject the data from our widget.data property
    var content = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        //Rotate the icon using the current animation value
        Rotation3d(
          rotationY: 180 * _iconAnimController.value,
          child: Icon(
            widget.data.icon,
            size: MediaQuery.of(context).size.height / 34,
            color: widget.isSelected
                ? Theme.of(context).textTheme.button.color
                : Theme.of(context).textTheme.button.backgroundColor,
          ),
        ),
        //Add some hz spacing
        SizedBox(width: MediaQuery.of(context).size.width / 55),
        //Label
        Text(
          widget.data.title,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.height / 44,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.button.color,
          ),
        ),
      ],
    );

    //Wrap btn in GestureDetector so we can listen to taps
    return GestureDetector(
      onTap: () => widget.onTap(),
      //Wrap in a bit of extra padding to make it easier to tap
      child: Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 80, bottom: MediaQuery.of(context).size.height / 80),
        //Wrap in an animated container, so changes to width & color automatically animate into place
        child: AnimatedContainer(
          alignment: Alignment.center,
          //Determine target width, selected item is wider
          width: widget.isSelected ? widget.data.width : MediaQuery.of(context).size.width / 7.5,
          curve: Curves.easeOutCubic,
          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 36, right: MediaQuery.of(context).size.width / 36),
          duration: Duration(milliseconds: (600 / _animScale).round()),
          //Use BoxDecoration top create a rounded container
          decoration: BoxDecoration(
            color: widget.isSelected
                ? Theme.of(context).buttonColor
                : Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(24)),
          ),
          //Wrap the row in a ClippedView to suppress any overflow errors if we momentarily exceed the screen size
          child: ClippedView(
            child: content,
          ),
        ),
      ),
    );
  }

  void _startAnimIfSelectedChanged(bool isSelected) {
    if (_wasSelected != widget.isSelected) {
      //Go forward or reverse, depending on the isSelected state
      widget.isSelected
          ? _iconAnimController.forward()
          : _iconAnimController.reverse();
    }
    _wasSelected = widget.isSelected;
  }
}
