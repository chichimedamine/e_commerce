
class Cart {
  final int? id;
  final int? userId;
  final int? productId;
  final int? quantity;

  Cart({
    this.id,
    this.userId,
    this.productId,
    this.quantity,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      id: json['id'] as int?,
      userId: json['userId'] as int?,
      productId: json['productId'] as int?,
      quantity: json['quantity'] as int?,
    );
  }
}