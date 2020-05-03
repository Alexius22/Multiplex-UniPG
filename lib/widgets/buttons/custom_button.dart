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
    return Container(
      width: this.width,
      height: this.height,
      child: FlatButton(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        color: Colors.deepOrange[900],
        highlightColor: Colors.white24,
        splashColor: Colors.white38,
        textColor: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              this.text,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height / 40,
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
        onPressed: onTap,
      ),
    );
  }
}
