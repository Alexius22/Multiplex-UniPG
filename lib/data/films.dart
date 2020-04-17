/// Utility class that contains info about a single film.
class Film {
  final int id;
  final String title;
  final String imagePath;
  final String trailerURL;
  final DateTime releaseDate;
  final Duration duration;
  final String plot;
  final String direction;
  final String cast;

  Film({
    this.id,
    this.title,
    this.imagePath,
    this.trailerURL,
    this.releaseDate,
    this.duration,
    this.plot,
    this.direction,
    this.cast,
  });
}

/// Class that contains some example instances of films.
class FilmsData {
  final _films = [
    Film(
      id: 0,
      title: 'Avengers: End Game',
      imagePath: 'images/avengers.jpg',
      trailerURL: 'https://www.youtube.com/watch?v=TcMBFSGVi1c',
      releaseDate: DateTime(
        2019,
        04,
        22,
      ),
      duration: Duration(minutes: 181),
      plot:
          """In seguito alle azioni di Thanos nel precedente Avengers: Infinity War la popolazione dell'intero universo è stata dimezzata e tra i caduti c'è stato anche Nick Fury. Ma prima di morire questi è riuscito a lanciare un messaggio nello spazio alla potentissima Capitan Marvel, che tornata sulla Terra e di fronte a un gruppo di Avengers afflitto dalla sconfitta e dal lutto, vuole prendere le cose in mano. Quello che ha fatto Thanos però non si può risolvere con la semplice superforza e i colpi di energia...""",
      direction: "Anthony Russo, Joe Russo",
      cast: "Un po' di gente del cast...",
    ),
    Film(
      id: 1,
      title: 'Captain Marvel',
      imagePath: 'images/captainmarvel.jpg',
      trailerURL: '',
      releaseDate: DateTime(
        2020,
        04,
        16,
      ),
      duration: Duration(minutes: 120),
      plot: """Trama...""",
      direction: "Registi...",
      cast: "Un po' di gente del cast...",
    ),
    Film(
      id: 2,
      title: 'Captain America: Civil War',
      imagePath: 'images/civil.jpg',
      trailerURL: '',
      releaseDate: DateTime(
        2020,
        04,
        16,
      ),
      duration: Duration(minutes: 120),
      plot: """Trama...""",
      direction: "Registi...",
      cast: "Un po' di gente del cast...",
    ),
    Film(
      id: 3,
      title: 'Doctor Strange',
      imagePath: 'images/doctorStrange.jpg',
      trailerURL: '',
      releaseDate: DateTime(
        2020,
        04,
        16,
      ),
      duration: Duration(minutes: 120),
      plot: """Trama...""",
      direction: "Registi...",
      cast: "Un po' di gente del cast...",
    ),
    Film(
      id: 4,
      title: 'Guardiani della Galassia',
      imagePath: 'images/guardiani.jpg',
      trailerURL: '',
      releaseDate: DateTime(
        2020,
        04,
        16,
      ),
      duration: Duration(minutes: 120),
      plot: """Trama...""",
      direction: "Registi...",
      cast: "Un po' di gente del cast...",
    ),
    Film(
      id: 5,
      title: 'Iron Man 3',
      imagePath: 'images/ironman3.jpg',
      trailerURL: '',
      releaseDate: DateTime(
        2020,
        04,
        16,
      ),
      duration: Duration(minutes: 120),
      plot: """Trama...""",
      direction: "Registi...",
      cast: "Un po' di gente del cast...",
    ),
    Film(
      id: 6,
      title: 'The Amazing Spiderman',
      imagePath: 'images/amazingSpiderman.jpg',
      trailerURL: 'https://www.youtube.com/watch?v=__kA4B_ut0s',
      releaseDate: DateTime(
        2020,
        04,
        16,
      ),
      duration: Duration(minutes: 120),
      plot: """È la storia di Peter Parker (Garfield), un liceale emarginato che è stato abbandonato da piccolo dai genitori e affidato allo zio Ben (Sheen) e alla zia May (Field). Come la maggior parte degli adolescenti, Peter cerca di capire chi è e come è diventato la persona che è adesso. Peter cerca la sua strada insieme alla ragazza per cui si è preso una cotta, Gwen Stacy (Stone), e insieme i due affronteranno l’amore, l’impegno e tanti segreti. Quando Peter scopre una misteriosa valigetta che apparteneva a suo padre, inizia una ricerca per capire il perché della scomparsa dei genitori – e questo lo porta direttamente a Oscorp e al laboratorio del Dr. Curt Connors (Ifans), il vecchio socio del padre. Quando, nei panni di Spider-Man, entrerà in rotta di collisione con l’alter ego di Connors, Lizard, Peter sceglie di usare i suoi poteri e diventare un eroe, anche se questo cambierà radicalmente la sua vita.""",
      direction: "Registi...",
      cast: "Un po' di gente del cast...",
    ),
    Film(
      id: 7,
      title: 'Captain America: The Winter Soldier',
      imagePath: 'images/wintersoldier.jpg',
      trailerURL: '',
      releaseDate: DateTime(
        2020,
        04,
        16,
      ),
      duration: Duration(minutes: 120),
      plot: """Trama...""",
      direction: "Registi...",
      cast: "Un po' di gente del cast...",
    ),
  ];

  get getAll => _films;

  getFilm(int index) {
    return _films.elementAt(index);
  }
}
