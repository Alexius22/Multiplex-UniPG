// Copyright 2020 Amatucci & Strippoli. All rights reserved.

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
  final List<String> genre;
  final List<String> hours;

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
    this.genre,
    this.hours,
  });
}

/// Class that contains some example instances of films.
class FilmsData {
  final List<Film> _films = [
    Film(
      id: 0,
      title: 'Avengers: Endgame',
      imagePath: 'images/posters/avengers.jpg',
      trailerURL: 'https://www.youtube.com/watch?v=TcMBFSGVi1c',
      releaseDate: DateTime(
        2019,
        04,
        22,
      ),
      duration: Duration(minutes: 181),
      plot: "Alla deriva nello spazio senza cibo o acqua, Tony Stark vede la propria scorta di ossigeno diminuire di minuto in minuto. Nel frattempo, i restanti Vendicatori affrontano un epico scontro con Thanos.",
      direction: "Anthony Russo, Joe Russo",
      cast: "Robert Downey Jr., Chris Evans, Mark Ruffalo, Chris Hemsworth, Scarlett Johansson, Jeremy Renner, Don Cheadle, Paul Rudd, Brie Larson, Karen Gillan, Danai Gurira, Josh Brolin",
      genre: ["Azione", "Fantascienza", "Avventura"],
      hours: ["16:30", "18:00", "20:45", "21:30", "23:00"],
    ),
    Film(
      id: 1,
      title: 'Captain Marvel',
      imagePath: 'images/posters/captainmarvel.jpg',
      trailerURL: 'https://www.youtube.com/watch?v=RPqT-lFQZHY',
      releaseDate: DateTime(
        2019,
        03,
        08,
      ),
      duration: Duration(minutes: 124),
      plot: "Captain Marvel è una guerriera extraterrestre originaria di Kree, che si ritrova coinvolta in una battaglia intergalattica tra il proprio popolo e quello degli Skrull. Giunta a vivere sulla Terra nel 1995 nei panni della pilota statunitense Carol Danvers, continua ad avere ricordi ricorrenti della sua vita precedente. Con l'aiuto di Nick Fury, la donna cerca di scoprire i segreti del proprio passato sfruttando i suoi speciali superpoteri per porre fine alla guerra con i malvagi Skrulls.",
      direction: "Anna Boden, Ryan Fleck",
      cast: "Brie Larson, Samuel L. Jackson, Ben Mendelsohn, Djimon Hounsou, Lee Pace, Lashana Lynch, Gemma Chan, Annette Bening, Clark Gregg, Jude Law",
      genre: ["Azione", "Fantascienza", "Avventura"],
      hours: ["16:15", "17:30", "20:15", "21:45", "22:30"],
    ),
    Film(
      id: 2,
      title: 'Captain America: Civil War',
      imagePath: 'images/posters/civil.jpg',
      trailerURL: 'https://www.youtube.com/watch?v=NneB0jFJh78',
      releaseDate: DateTime(
        2016,
        05,
        06,
      ),
      duration: Duration(minutes: 147),
      plot: "Le pressioni politiche sugli Avengers da parte del governo degli Stati Uniti creano crescenti dissapori tra Captain America e Iron Man. Quando la Terra si trova in pericolo, la Vedova Nera e Occhio di Falco devono scegliere da che parte stare.",
      direction: "Anthony e Joe Russo",
      cast: "Chris Evans, Robert Downey Jr., Scarlett Johansson, Sebastian Stan, Anthony Mackie, Don Cheadle, Jeremy Renner, Chadwick Boseman, Paul Bettany, Elizabeth Olsen, Paul Rudd, Emily VanCamp, Tom Holland, Frank Grillo, William Hurt, Daniel Brühl",
      genre: ["Azione", "Fantascienza"],
      hours: ["16:45", "17:30", "19:45", "21:00", "22:15"],
    ),
    Film(
      id: 3,
      title: 'Doctor Strange',
      imagePath: 'images/posters/doctorStrange.jpg',
      trailerURL: 'https://www.youtube.com/watch?v=p8plN5PVIzc',
      releaseDate: DateTime(
        2016,
        10,
        26,
      ),
      duration: Duration(minutes: 115),
      plot: "Un medico resta vittima di un tragico incidente, ma viene aiutato da uno stregone che lo inizia alle arti magiche, grazie alle quali egli riesce a redimersi e a combattere le forze oscure che minacciano l'umanità.",
      direction: "Scott Derrickson",
      cast: "Benedict Cumberbatch, Chiwetel Ejiofor, Rachel McAdams, Benedict Wong, Michael Stuhlbarg, Benjamin Bratt, Scott Adkins, Mads Mikkelsen, Tilda Swinton",
      genre: ["Azione", "Fantastico", "Avventura"],
      hours: ["15:45", "17:00", "18:15", "20:45", "22:30"],
    ),
    Film(
      id: 4,
      title: 'Guardiani della Galassia',
      imagePath: 'images/posters/guardiani.jpg',
      trailerURL: 'https://www.youtube.com/watch?v=VHS1Q2rNVjI',
      releaseDate: DateTime(
        2014,
        10,
        22,
      ),
      duration: Duration(minutes: 121),
      plot: "Un avventuriero spaziale, Brash Peter Quill, diventa preda di alcuni cacciatori di taglie dopo aver rubato una sfera ambita dal potente Ronan. Per sfuggire alla morte, l'uomo si allea con quattro improbabili compagni di avventura.",
      direction: "James Gunn",
      cast: "Chris Pratt, Zoe Saldana, Dave Bautista, Lee Pace, Michael Rooker, Karen Gillan, Djimon Hounsou, John C. Reilly, Glenn Close, Benicio del Toro",
      genre: ["Azione", "Fantascienza", "Avventura"],
      hours: ["16:00", "17:30", "19:00", "20.30", "22.45"],
    ),
    Film(
      id: 5,
      title: 'Iron Man 3',
      imagePath: 'images/posters/ironman3.jpg',
      trailerURL: 'https://www.youtube.com/watch?v=wTAlWE4PAwc',
      releaseDate: DateTime(
        2013,
        04,
        24,
      ),
      duration: Duration(minutes: 130),
      plot: "Dopo aver salvato New York dalla distruzione ed essere rimasto da allora insonne e preoccupato, Tony Stark rimasto senza armatura deve lottare contro le sue paure interiori per sconfiggere il suo nuovo nemico, il Mandarino.",
      direction: "Shane Black",
      cast: "Robert Downey Jr., Gwyneth Paltrow, Don Cheadle, Guy Pearce, Rebecca Hall, Ty Simpkins, Stephanie Szostak, James Badge Dale, Jon Favreau, Ben Kingsley",
      genre: ["Azione", "Fantascienza"],
      hours: ["16:15", "17:30", "19:45", "21:15", "22:45"],
    ),
    Film(
      id: 6,
      title: 'Spider-Man: Homecoming',
      imagePath: 'images/posters/spiderman.jpg',
      trailerURL: 'https://www.youtube.com/watch?v=39udgGPyYMg',
      releaseDate: DateTime(
        2017,
        07,
        06,
      ),
      duration: Duration(minutes: 133),
      plot: "L'Uomo Ragno decide di chiedere aiuto al proprio mentore: il miliardario Tony Stark, alias Iron Man. La situazione si complica quando il criminale noto come Avvoltoio comincia a seminare il panico in città.",
      direction: "Jon Watts",
      cast: "Tom Holland, Michael Keaton, Jon Favreau, Zendaya: Michelle, Donald Glover, Tyne Daly, Marisa Tomei, Robert Downey Jr.",
      genre: ["Azione", "Avventura", "Fantascienza"],
      hours: ["17:15", "18:30", "20:15", "21:45", "23:00"],
    ),
    Film(
      id: 7,
      title: 'Captain America: The Winter Soldier',
      imagePath: 'images/posters/wintersoldier.jpg',
      trailerURL: 'https://www.youtube.com/watch?v=7SlILk2WMTI',
      releaseDate: DateTime(
        2014,
        03,
        26,
      ),
      duration: Duration(minutes: 136),
      plot: "Capitan America, Vedova Nera e un nuovo alleato, Falcon, affrontano un nemico inaspettato mentre lottano per far emergere alla luce del sole un complotto che mette a rischio il mondo intero.",
      direction: "Anthony e Joe Russo",
      cast: "Chris Evans, Scarlett Johansson, Sebastian Stan, Anthony Mackie, Cobie Smulders, Frank Grillo, Emily VanCamp, Hayley Atwell, Robert Redford, Samuel L. Jackson",
      genre: ["Azione", "Fantascienza"],
      hours: ["16:00", "17:30", "19:15", "20:45", "22:30"],
    ),
    Film(
      id: 8,
      title: 'Thor: Ragnarok',
      imagePath: 'images/posters/ragnarok.jpg',
      trailerURL: 'https://www.youtube.com/watch?v=D7UpZmPmwSo',
      releaseDate: DateTime(
        2017,
        10,
        25,
      ),
      duration: Duration(minutes: 130),
      plot: "Thor viene imprigionato e, privato del proprio martello, si ritrova a dover combattere contro Hulk ed Hela. Inoltre deve riuscire a raggiungere Asgard e fermare Ragnarok, la distruzione del suo proprio mondo.",
      direction: "Taika Waititi",
      cast: "Chris Hemsworth, Tom Hiddleston, Cate Blanchett, Idris Elba, Jeff Goldblum, Tessa Thompson, Karl Urban, Mark Ruffalo, Anthony Hopkins",
      genre: ["Azione", "Fantastico", "Avventura", "Fantascienza"],
      hours: ["17:15", "18:00", "20:00", "21:45", "23:30"],
    ),
    Film(
      id: 9,
      title: 'Black Panther',
      imagePath: 'images/posters/blackpanther.jpg',
      trailerURL: 'https://www.youtube.com/watch?v=WL_7EsTsQ08',
      releaseDate: DateTime(
        2018,
        01,
        29,
      ),
      duration: Duration(minutes: 134),
      plot: "Il giovane principe T'Challa ritorna a casa, nella nazione tecnologicamente avanzata del Wakanda. Ben presto però è costretto a richiedere l'aiuto dell'agente della CIA Everett K. Ross per difendere il trono ed evitare una guerra civile.",
      direction: "Ryan Coogler",
      cast: "Chadwick Boseman, Michael B. Jordan, Lupita Nyong'o, Danai Gurira, Martin Freeman, Daniel Kaluuya, Letitia Wright, Winston Duke, Angela Bassett, Forest Whitaker, Andy Serkis",
      genre: ["Azione", "Fantascienza", "Avventura"],
      hours: ["16:30", "18:30", "20:45", "22:00", "23:45"],
    ),
  ];

  List<Film> get getAll => _films;

  getFilm(int index) {
    return _films.elementAt(index);
  }
}
