import 'package:flutter/material.dart';
import 'package:cinema_app/data/films.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

import './slide_route.dart';
import './buy_ticket.dart';

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
  final trailerHeight = 300.0;
  final buyHeight = 50.0;
  final buyPadding = 30.0;
  final mainTextColor = Colors.white;
  final secondaryTextColor = Colors.deepOrange[800];

  @override
  Widget build(BuildContext context) {
    void _onBuyPressed() {
      Navigator.push(context, SlideTopRoute(page: BuyTicket()));
    }

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
          Stack(
            children: <Widget>[
              // Gradiente
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: buyHeight + 20),
                  child: Container(
                    width: double.infinity,
                    height: buyPadding * 2.5,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.0),
                          Colors.black,
                        ],
                        stops: [0.0, 0.8],
                      ),
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Center(
                    child: Container(
                      height: buyHeight,
                      width: 200,
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        color: Colors.deepOrange[900],
                        splashColor: Colors.deepOrange[300],
                        textColor: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 22,
                            ),
                            Text(
                              "Acquista",
                              style: TextStyle(
                                fontSize: 20,
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                        onPressed: _onBuyPressed,
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 50)
                ],
              ),
            ],
          ),
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
                color: mainTextColor,
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
          // Splash animation
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
    // Build genre widgets
    List<Widget> _genres = [];
    for (var genre in film.genre) {
      _genres.add(_buildGenre(genre));
    }

    return Container(
      height: MediaQuery.of(context).size.height -
          trailerHeight -
          buyHeight -
          buyPadding / 1.5,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _genres,
            ),
            SizedBox(height: 10),
            Row(
              children: <Widget>[
                SizedBox(width: 25, height: 50),
                // Uscita
                Text(
                  "Uscita:",
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 15,
                    color: secondaryTextColor,
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  DateFormat('dd/MM/yyyy').format(film.releaseDate),
                  style: TextStyle(
                    fontSize: 17,
                    letterSpacing: 1,
                    color: mainTextColor,
                  ),
                ),
                SizedBox(width: 30),
                // Durata
                Text(
                  "Durata:",
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 15,
                    color: secondaryTextColor,
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  film.duration.inMinutes.toString() + "'",
                  style: TextStyle(
                    fontSize: 17,
                    letterSpacing: 1,
                    color: mainTextColor,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 25, right: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Trama:",
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 15,
                      color: secondaryTextColor,
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    film.plot,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 17,
                      color: mainTextColor,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, left: 25),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Regia:",
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 15,
                      color: secondaryTextColor,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 2, left: 25),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    film.direction,
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 17,
                      color: Colors.grey[300],
                    ),
                  ),
                  SizedBox(height: 3),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, left: 25, right: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Cast:",
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 15,
                      color: secondaryTextColor,
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    film.cast,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 17,
                      color: Colors.grey[300],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 18)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGenre(label) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: Colors.grey[500],
          width: 1.0,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
            color: Colors.grey[400],
          ),
        ),
      ),
    );
  }
}
