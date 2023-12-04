class Product {
  final int id;
  final String name;
  final double quantity;
  final String unit;

  Product({
    required this.id,
    required this.name,
    required this.quantity,
    required int unitValue,
  }) : unit = _mapUnit(unitValue);

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      quantity: json['quantity'],
      unitValue: json['unit'],
    );
  }

  static String _mapUnit(int unitValue) {
    switch (unitValue) {
      case 1:
        return 'kg';
      case 2:
        return 'l';
      case 3:
        return 'g';
      default:
        return '';
    }
  }
}
