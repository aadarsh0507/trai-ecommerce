import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './home_screen.dart';
import './orders_screen.dart';
import './profile_screen.dart';
import './cart_screen.dart';
import '../providers/cart_provider.dart';
import '../widgets/cart_badge.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const CartScreen(),
    const OrdersScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        elevation: 8,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        iconSize: 28,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Consumer<CartProvider>(
              builder: (ctx, cart, ch) => CartBadge(
                value: cart.itemCount.toString(),
                child: const Icon(Icons.shopping_cart),
              ),
            ),
            label: 'Cart',
            activeIcon: Consumer<CartProvider>(
              builder: (ctx, cart, ch) => CartBadge(
                value: cart.itemCount.toString(),
                color: Colors.deepPurple,
                child: const Icon(Icons.shopping_cart, color: Colors.deepPurple),
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.shopping_bag),
            label: 'Orders',
            activeIcon: const Icon(Icons.shopping_bag, color: Colors.deepPurple),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}