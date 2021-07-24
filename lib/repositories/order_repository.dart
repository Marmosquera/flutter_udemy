import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:udemy_course/models/order.dart';

class OrderRepository {
  static const ORDERS_COLLECTION = 'orders';

  saveOrderData(Order order) async => FirebaseFirestore.instance
      .collection(ORDERS_COLLECTION)
      .doc(order.id)
      .set(order.toJson());

  Future<List<Order>> getOrders(String userId) async =>
      await FirebaseFirestore.instance
          .collection(ORDERS_COLLECTION)
          .where('userId', isEqualTo: userId)
          .get()
          .then((ordersSnapshot) =>
              ordersSnapshot.docs.map((doc) => Order.fromJson(doc.data())))
          .then((value) => value.toList());
}
