import 'package:flutter/foundation.dart';
import 'package:udemy_course/models/favorite_item.dart';
import '/models/product.dart';

class FavoritesProvider with ChangeNotifier {
  Map<String, FavoriteItem> _favoriteItems = {};

  Map<String, FavoriteItem> get favoriteItems {
    return _favoriteItems;
  }

  bool containsItem(Product product) => _favoriteItems.containsKey(product.id);

  void addAndRemoveFromFavorites(Product product) {
    if (_favoriteItems.containsKey(product.id)) {
      _favoriteItems.remove(product.id);
    } else {
      _favoriteItems.putIfAbsent(
          product.id, () => FavoriteItem.fromProduct(product));
    }
    notifyListeners();
  }

  void removeItemById(String productId) {
    _favoriteItems.remove(productId);
    notifyListeners();
  }

  void clearFavorites() {
    _favoriteItems.clear();
    notifyListeners();
  }
}
