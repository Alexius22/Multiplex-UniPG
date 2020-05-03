/// Utility class that contains info about a single city.
class City {
  final int id;
  final String name;

  City({
    this.id,
    this.name,
  });
}

/// Class that contains some example instances of cities.
class CitiesData {
  final _cities = [
    City(
      id: 0,
      name: "Perugia",
    ),
    City(
      id: 1,
      name: "Ascoli Piceno",
    ),
    City(
      id: 2,
      name: "Fabriano",
    ),
    City(
      id: 3,
      name: "Taranto",
    ),
  ];

  get getAll => _cities;

  List<String> getAllStrings() {
    List<String> _citiesString = [];
    _cities.forEach((City city) {
      _citiesString.add(city.name);
    });
    return _citiesString;
  }

  City getCity(int index) {
    return _cities.elementAt(index);
  }
}
