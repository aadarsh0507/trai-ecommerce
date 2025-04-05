import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';
import '../utils/currency_utils.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: product.id,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                width: double.infinity,
                child: CachedNetworkImage(
                  imageUrl: product.imageUrl,
                  fit: BoxFit.contain,
                  placeholder: (context, url) => Container(
                    color: Colors.grey[200],
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey[200],
                    child: const Icon(
                      Icons.image_not_supported,
                      size: 50,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    CurrencyUtils.formatInrPrice(product.price),
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    product.description,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(Icons.inventory_2_outlined),
                      const SizedBox(width: 8),
                      Text(
                        'Stock: ${product.stockQuantity}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: product.categories
                        .map(
                          (category) => Chip(
                            label: Text(category),
                            backgroundColor:
                                Theme.of(context).colorScheme.primaryContainer,
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: product.stockQuantity > 0
                ? () {
                    cart.addItem(product);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Added item to cart!'),
                        duration: const Duration(seconds: 2),
                        action: SnackBarAction(
                          label: 'UNDO',
                          onPressed: () {
                            cart.removeItem(product.id);
                          },
                        ),
                      ),
                    );
                  }
                : null,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: Text(
              product.stockQuantity > 0 ? 'Add to Cart' : 'Out of Stock',
            ),
          ),
        ),
      ),
    );
  }
}