class TicketSnack {
  String name;
  String size;
  int quantity;

  TicketSnack(this.name, this.size, this.quantity);

  @override
  String toString() {
    if (size.trim().length > 0)
      return "$name ($size): $quantity";
    else
      return "$name: $quantity";
  }
}
