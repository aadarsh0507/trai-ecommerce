import 'package:flutter/foundation.dart';
import '../models/product.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: '1',
      name: 'iPhone 14 Pro',
      description: 'Latest iPhone with Dynamic Island and 48MP camera system',
      price: 999.99,
      imageUrl: 'https://images.unsplash.com/photo-1678652197831-2d180705cd2c',
      stockQuantity: 50,
      categories: ['Electronics', 'Phones'],
    ),
    Product(
      id: '2',
      name: 'Sony WH-1000XM4',
      description: 'Industry-leading noise cancelling wireless headphones',
      price: 349.99,
      imageUrl: 'https://images.unsplash.com/photo-1618366712010-f4ae9c647dcb',
      stockQuantity: 100,
      categories: ['Electronics', 'Audio'],
    ),
    Product(
      id: '3',
      name: 'Apple Watch Series 8',
      description: 'Advanced health features and cellular connectivity',
      price: 399.99,
      imageUrl: 'https://images.unsplash.com/photo-1434493789847-2f02dc6ca35d',
      stockQuantity: 75,
      categories: ['Electronics', 'Wearables'],
    ),
    Product(
      id: '4',
      name: 'MacBook Pro 16"',
      description: 'Powerful laptop for professionals with M2 Pro chip',
      price: 2499.99,
      imageUrl: 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8',
      stockQuantity: 30,
      categories: ['Electronics', 'Computers'],
    ),
    Product(
      id: '5',
      name: 'iPad Air',
      description: 'Versatile tablet with M1 chip and stunning display',
      price: 599.99,
      imageUrl: 'https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0',
      stockQuantity: 60,
      categories: ['Electronics', 'Tablets'],
    ),
    Product(
      id: '6',
      name: 'Samsung QLED 4K TV',
      description: '65-inch Smart TV with quantum dot technology',
      price: 1299.99,
      imageUrl: 'https://images.unsplash.com/photo-1593359677879-a4bb92f829d1',
      stockQuantity: 25,
      categories: ['Electronics', 'TVs'],
    ),
    Product(
      id: '7',
      name: 'Nintendo Switch OLED',
      description: 'Enhanced gaming console with vibrant display',
      price: 349.99,
      imageUrl: 'https://images.unsplash.com/photo-1578303512597-81e6cc155b3e',
      stockQuantity: 45,
      categories: ['Electronics', 'Gaming'],
    ),
    Product(
      id: '8',
      name: 'DJI Mini 3 Pro',
      description: 'Compact drone with 4K camera and obstacle avoidance',
      price: 759.99,
      imageUrl: 'https://images.unsplash.com/photo-1473968512647-3e447244af8f',
      stockQuantity: 20,
      categories: ['Electronics', 'Drones'],
    ),
  ];

  List<Product> get items => [..._items];

  Product findById(String id) {
    return _items.firstWhere((product) => product.id == id);
  }

  List<Product> findByCategory(String category) {
    return _items.where((product) => 
      product.categories.contains(category)).toList();
  }

  List<String> get categories {
    Set<String> cats = {};
    for (var product in _items) {
      cats.addAll(product.categories);
    }
    return cats.toList();
  }

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }

  void updateProduct(String id, Product newProduct) {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      _items[prodIndex] = newProduct;
      notifyListeners();
    }
  }

  void deleteProduct(String id) {
    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }
}