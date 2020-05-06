class Film {
  final String id;
  final String title;
  final String imageURL;
  final String trailerURL;
  final DateTime releaseDate;
  final int durationMins;
  final String plot;
  final List<String> direction;
  final List<String> cast;
  final List<dynamic> genres;

  Film({
    this.id,
    this.title,
    this.imageURL,
    this.trailerURL,
    this.releaseDate,
    this.durationMins,
    this.plot,
    this.direction,
    this.cast,
    this.genres,
  });

  Film.fromMap(String id, Map snapshot)
      : id = id ?? '',
        title = snapshot['title'] ?? '',
        imageURL = snapshot['image'] ?? '',
        trailerURL = snapshot['trailerURL'] ?? '',
        releaseDate = snapshot['releaseDate'].toDate() ?? DateTime(2020),
        durationMins = snapshot['durationMins'] ?? 0,
        plot = snapshot['plot'] ?? '',
        direction = List<String>.from(snapshot['direction']) ?? [],
        cast = List<String>.from(snapshot['cast']) ?? [],
        genres = snapshot['genres'] ?? [];

  toJson() => {
        "title": title,
        "image": imageURL,
        "trailerURL": trailerURL,
        "releaseDate": releaseDate,
        "durationMins": durationMins,
        "plot": plot,
        "direction": direction,
        "cast": cast,
        "genres": genres,
      };
}
