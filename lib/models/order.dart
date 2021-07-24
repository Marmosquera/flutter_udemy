import 'dart:convert';

import 'package:udemy_course/models/order_item.dart';
import 'package:uuid/uuid.dart';

class Order {
  late String id;
  String userId = '';
  DateTime createdAt = DateTime.now();
  List<OrderItem> items = [];

  Order({required this.items}) {
    id = Uuid().v4();
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'createdAt': createdAt.toUtc().millisecondsSinceEpoch,
        'items': jsonEncode(items.map((e) => e.toJson()).toList())
      };

  Order.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['userId'],
        createdAt = json['createdAt'],
        items = jsonDecode(json[
            'items']) /*List<OrderItem>.from( (json['items'] as List).map((Map e) => OrderItem.fromJson(e))*/;
}
