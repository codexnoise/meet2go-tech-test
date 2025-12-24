/// Model representing an event from the backend.
class EventModel {
  final String id;
  final String title;
  final String description;
  final double price;
  final int stock;

  EventModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.stock,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      stock: json['stock'],
    );
  }
}

/// Model representing the success response of a purchase.
class PurchaseResult {
  final String message;
  final String eventTitle;
  final int remainingStock;

  PurchaseResult({
    required this.message,
    required this.eventTitle,
    required this.remainingStock,
  });

  factory PurchaseResult.fromJson(Map<String, dynamic> json) {
    return PurchaseResult(
      message: json['message'],
      eventTitle: json['eventTitle'],
      remainingStock: json['remainingStock'],
    );
  }
}