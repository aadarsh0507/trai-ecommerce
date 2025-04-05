import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import '../utils/currency_utils.dart';

class ProductSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final products = Provider.of<ProductProvider>(context)
        .items
        .where((product) => product.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (ctx, i) => ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(products[i].imageUrl),
        ),
        title: Text(products[i].name),
        subtitle: Text(CurrencyUtils.formatInrPrice(products[i].price)),
        onTap: () {
          close(context, products[i].id);
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final products = Provider.of<ProductProvider>(context)
        .items
        .where((product) => product.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (ctx, i) => ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(products[i].imageUrl),
        ),
        title: Text(products[i].name),
        onTap: () {
          query = products[i].name;
          showResults(context);
        },
      ),
    );
  }
}