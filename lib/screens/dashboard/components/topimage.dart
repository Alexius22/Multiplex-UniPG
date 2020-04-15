// Copyright 2020 Amatucci & Strippoli. All rights reserved.

import 'package:flutter/material.dart';

class TopImage extends StatelessWidget {
  final String imagePath;
  final String imageText;
  final double imageHeight;

  TopImage({
    this.imagePath = 'images/avengers.jpg',
    this.imageText = "AVENGERS: ENDGAME",
    this.imageHeight = 180,
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
            width: MediaQuery.of(context).size.width,
            height: this.imageHeight + 1,
            decoration: BoxDecoration(
              color: Colors.white,
              gradient: LinearGradient(
                begin: FractionalOffset(0.0, 0.4),
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
            width: MediaQuery.of(context).size.width,
            height: this.imageHeight,
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.only(bottom: 15),
            child: Text(
              this.imageText,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
