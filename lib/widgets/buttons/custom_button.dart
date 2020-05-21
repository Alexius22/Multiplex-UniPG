import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double width;
  final double height;
  final String text;
  final IconData icon;
  final Function onTap;

  CustomButton({
    this.width,
    this.height = 50,
    this.text,
    this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      color: Colors.deepOrange[900],
      highlightColor: Colors.white24,
      splashColor: Colors.white38,
      textColor: Colors.white,
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width / 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
          children: [
            TextSpan(text: this.text),
            if (icon != null)
              WidgetSpan(
                child: Icon(
                  this.icon,
                  size: MediaQuery.of(context).size.width / 18,
                ),
              ),
          ],
        ),
      ),
      /*
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            this.text,
            style: TextStyle(
              fontSize: width / 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
          if (icon != null)
            Icon(
              this.icon,
              size: 22,
            ),
        ],
      ),
      */
      onPressed: onTap,
    );
  }
}
