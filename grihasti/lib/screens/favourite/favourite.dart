import 'package:flutter/material.dart';
import 'package:grihasti/provider/favourite_provider.dart';
import 'package:grihasti/screens/homescreen/components/other_products.dart';
import 'package:provider/provider.dart';

import '../homescreen/components/favproduct.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    final List<FavProduct> favoriteProducts = favoritesProvider.favorites;

    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: ListView.builder(
        itemCount: favoriteProducts.length,
        itemBuilder: (context, index) {
          final product = favoriteProducts[index];

          return ListTile(
            leading: Container(
                width: 45, height: 45, child: Image.asset(product.imageUrl)),
            title: Text(product.title),
          );
        },
      ),
    );
  }
}

//Image.asset(product.imageUrl)
//Text(product.title),
