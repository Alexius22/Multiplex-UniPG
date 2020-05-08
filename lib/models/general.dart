class GeneralInfo {
  final Map<String, num> discounts;
  final Map<String, Map<String, num>> ticketPrices;

  GeneralInfo({
    this.discounts,
    this.ticketPrices,
  });

  GeneralInfo.fromMap(Map snapshot)
      : discounts = Map<String, num>.from(snapshot['discounts']),
        ticketPrices = Map<String, Map<String, num>>.fromIterable(
          snapshot['ticketPrices'].keys,
          key: (key) => key,
          value: (key) => Map<String, num>.from(
            snapshot['ticketPrices'][key],
          ),
        );
}
