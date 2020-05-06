class Snack {
  final String name;
  final Map<String, int> priceList;

  Snack({
    this.name,
    this.priceList,
  });

  Snack.fromMap(String id, Map snapshot)
      : name = id,
        priceList = snapshot['priceList'];
}
