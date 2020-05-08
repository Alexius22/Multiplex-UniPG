class Snack {
  final String name;
  final Map<String, double> priceList;

  Snack({
    this.name,
    this.priceList,
  });

  Snack.fromMap(String id, Map snapshot)
      : name = id,
        priceList = Map<String, double>.from(snapshot['priceList']);
}
