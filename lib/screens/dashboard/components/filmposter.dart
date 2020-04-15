// Copyright 2020 Amatucci & Strippoli. All rights reserved.

import 'package:flutter/material.dart';

class FilmPoster extends StatelessWidget {
  final String imagePath;
  final String imageText;
  final double imageHeight;
  final double imageWidth;

  FilmPoster({
    this.imagePath = 'images/spiderman.jpg',
    this.imageText = "The Amazing Spiderman",
    this.imageWidth = 150,
    this.imageHeight = 250,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("Locandina $imagePath");
      },
      child: Stack(
        children: <Widget>[
          // Image
          Container(
            width: this.imageWidth,
            height: this.imageHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            width: this.imageWidth,
            height: this.imageHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              gradient: LinearGradient(
                begin: FractionalOffset(0.0, 0.5),
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
            alignment: Alignment.bottomLeft,
            width: this.imageWidth,
            height: this.imageHeight,
            padding: EdgeInsets.only(left: 10, right: 10, bottom: 15),
            child: Text(
              this.imageText,
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
