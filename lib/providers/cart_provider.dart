import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:udemy_course/models/cart_item.dart';
import 'package:udemy_course/models/order.dart';
import 'package:udemy_course/models/order_item.dart';
import 'package:udemy_course/repositories/order_repository.dart';
import 'package:udemy_course/repositories/stripe_repository.dart';
import '/models/product.dart';

class CartProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final OrderRepository _orderRepository = OrderRepository();

  Map<String, CartItem> _cartItems = {};

  Map<String, CartItem> get cartItems {
    return _cartItems;
  }

  double get totalAmount {
    var total = 0.0;
    _cartItems.forEach((key, value) {
      total += value.price * value.quantity;
    });
    return total;
  }

  bool containsItem(Product product) => _cartItems.containsKey(product.id);

  void addProductToCart(Product product) {
    if (_cartItems.containsKey(product.id)) {
      _cartItems.update(
          product.id,
          (exitingCartItem) => CartItem(
              id: exitingCartItem.id,
              title: exitingCartItem.title,
              price: exitingCartItem.price,
              quantity: exitingCartItem.quantity + 1,
              imageUrl: exitingCartItem.imageUrl));
    } else {
      _cartItems.putIfAbsent(product.id, () => CartItem.fromProduct(product));
    }
    notifyListeners();
  }

  void reduceItemByOne(String productId) {
    if (_cartItems.containsKey(productId)) {
      _cartItems.update(
          productId,
          (exitingCartItem) => CartItem(
              id: exitingCartItem.id,
              title: exitingCartItem.title,
              price: exitingCartItem.price,
              quantity: exitingCartItem.quantity - 1,
              imageUrl: exitingCartItem.imageUrl));
    }
    notifyListeners();
  }

  void incrementItemByOne(String productId) {
    if (_cartItems.containsKey(productId)) {
      _cartItems.update(
          productId,
          (exitingCartItem) => CartItem(
              id: exitingCartItem.id,
              title: exitingCartItem.title,
              price: exitingCartItem.price,
              quantity: exitingCartItem.quantity + 1,
              imageUrl: exitingCartItem.imageUrl));
    }
    notifyListeners();
  }

  void removeItem(Product product) {
    _cartItems.remove(product.id);
    notifyListeners();
  }

  void removeItemById(String productId) {
    _cartItems.remove(productId);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  Future<bool> checkout() async {
    StripeRepository.init();

    final List<OrderItem> items =
        _cartItems.values.map((e) => OrderItem.fromCartItem(e)).toList();

    Order _order = Order(items: items);
    _order.userId = _auth.currentUser!.uid;

    await _orderRepository.saveOrderData(_order);

    double amountInCents = totalAmount * 1000;
    int intengerAmount = (amountInCents / 10).ceil();

    var response = await StripeRepository.payWithNewCard(
        currency: 'USD', amount: intengerAmount.toString());

    return response.success;
  }
}
