import 'package:flutter/material.dart';
import 'package:cinema_app/data/films.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class FilmDetails extends StatefulWidget {
  final Film film;

  FilmDetails({
    this.film,
  });

  @override
  _State createState() => new _State(
        film: this.film,
      );
}

class _State extends State<FilmDetails> {
  final Film film;

  _State({
    this.film,
  });

  // Configuration
  final trailerHeight = 250.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              // Build trailer, title
              Stack(
                children: <Widget>[
                  _buildBackButton(context),
                  _buildHead(),
                ],
              ),
              _buildInfo(),
            ],
          ),
          _buildBackButton(context),
        ],
      ),
    );
  }

  Widget _buildBackButton(context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(left: 10, top: 10),
        child: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 25,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  Widget _buildHead() {
    void _trailerOpen() async {
      String url = this.film.trailerURL;
      if (await canLaunch(url)) await launch(url);
    }

    return Container(
      width: double.infinity,
      height: this.trailerHeight,
      child: Stack(
        children: <Widget>[
          // Image with gradient
          Hero(
            tag: "film-image" + film.id.toString(),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  alignment: Alignment.topCenter,
                  image: AssetImage(film.imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Shadow
          Hero(
            tag: "film-shadow" + film.id.toString(),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.0),
                    Colors.black,
                  ],
                  stops: [0.4, 1.0],
                ),
              ),
            ),
          ),
          // Film Title
          Hero(
            tag: "film-title" + film.id.toString(),
            child: Material(
              type: MaterialType.transparency,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    film.title.toUpperCase(),
                    style: TextStyle(
                      fontFamily: 'Oswald',
                      fontSize: 30,
                      letterSpacing: 3,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Play button
          Container(
            width: double.infinity,
            height: trailerHeight,
            child: Align(
              alignment: Alignment.center,
              child: Icon(
                Icons.play_circle_filled,
                size: 50,
                color: Colors.white70,
              ),
            ),
          ),
          // Bleah
          Material(
            type: MaterialType.transparency,
            child: InkWell(
              highlightColor: Colors.black26,
              splashColor: Colors.black38,
              onTap: _trailerOpen,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfo() {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            SizedBox(width: 20, height: 50),
            // Uscita
            Text(
              "Uscita:",
              style: TextStyle(fontFamily: 'OpenSans'),
            ),
            SizedBox(width: 8),
            Text(
              DateFormat('dd/MM/yyyy').format(film.releaseDate),
              style: TextStyle(
                fontSize: 15,
                letterSpacing: 1,
                color: Colors.deepOrange[800],
              ),
            ),
            SizedBox(width: 30),
            // Durata
            // Uscita
            Text(
              "Durata:",
              style: TextStyle(fontFamily: 'OpenSans'),
            ),
            SizedBox(width: 8),
            Text(
              film.duration.inMinutes.toString(),
              style: TextStyle(
                fontSize: 15,
                letterSpacing: 1,
                color: Colors.deepOrange[800],
              ),
            ),
          ],
        ),
        Text("caaasdsadsad"),
      ],
    );
  }
}
