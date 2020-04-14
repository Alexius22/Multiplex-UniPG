// Copyright 2020 Amatucci & Strippoli. All rights reserved.

import 'package:flutter/material.dart';

class TopImage extends StatelessWidget {
  final String imagePath;
  final String imageText;
  final double imageHeight;

  TopImage({
    this.imagePath = 'images/avengers.jpg',
    this.imageText = "AVENGERS: ENDGAME",
    this.imageHeight = 200,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("Container clicked (TODO)");
      },
      child: Stack(
        children: <Widget>[
          // Image
          Container(
            width: MediaQuery.of(context).size.width,
            height: this.imageHeight,
            child: Image.asset(
              this.imagePath,
              fit: BoxFit.fitWidth,
            ),
          ),
          Container(
            height: this.imageHeight,
            decoration: BoxDecoration(
              color: Colors.white,
              gradient: LinearGradient(
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(0.0, 1.0),
                colors: [
                  Colors.black.withOpacity(0.0),
                  Colors.black,
                ],
                stops: [0.0, 1.0],
              ),
            ),
          ),
          // Text
          Container(
            padding: EdgeInsets.only(top: this.imageHeight - 64),
            child: Center(
              child: Text(
                this.imageText,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
