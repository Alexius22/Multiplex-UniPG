class Snack {
  final String name;
  final Map<String, double> priceList;

  Snack({
    this.name,
    this.priceList,
  });

  Snack.fromMap(String id, Map snapshot)
      : name = id,
        priceList = Map<String, double>.fromIterable(
          snapshot['priceList'].keys.toList()
            ..sort(
              (String k1, String k2) => (snapshot['priceList'][k1] as double)
                  .compareTo(snapshot['priceList'][k2] as double),
            ),
          key: (key) => key,
          value: (key) => snapshot['priceList'][key],
        );
}
