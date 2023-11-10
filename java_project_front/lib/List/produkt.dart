class Produkt {
  final int id;
  final String name;
  final double quantity;
  final String unit;

  Produkt({required this.id, required this.name, required this.quantity, required this.unit});

  factory Produkt.fromJson(Map<String, dynamic> json) {
    return Produkt(
      id: json['id'],
      name: json['name'],
      quantity: json['quantity'],
      unit: json['unit'],
    );
  }
}
