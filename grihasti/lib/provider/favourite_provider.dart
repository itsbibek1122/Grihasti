import 'package:flutter/material.dart';
import 'package:grihasti/screens/homescreen/components/favproduct.dart';

class FavoritesProvider extends ChangeNotifier {
  List<FavProduct> _favorites = [];

  List<FavProduct> get favorites => _favorites;

  void addToFavorites(FavProduct product) {
    _favorites.add(product);
    SnackBar(content: Text('Added to fav'));
    notifyListeners();
  }

  void removeFromFavorites(FavProduct product) {
    _favorites.remove(product);
    notifyListeners();
  }
}
