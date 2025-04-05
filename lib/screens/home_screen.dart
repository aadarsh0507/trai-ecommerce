import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../providers/product_provider.dart';
import '../providers/cart_provider.dart';
import '../widgets/product_grid.dart';
import '../widgets/cart_badge.dart';
import '../screens/cart_screen.dart';
import '../search/product_search_delegate.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black54),
            onPressed: () {
              showSearch(
                context: context,
                delegate: ProductSearchDelegate(),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(16, 48, 16, 12),
            height: MediaQuery.of(context).size.height * 0.25,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: SvgPicture.asset(
                'assets/images/home_banner.svg',
                fit: BoxFit.contain,
                width: double.infinity,
              ),
            ),
          ),
          Consumer<ProductProvider>(
            builder: (context, productData, child) => Container(
              height: 50,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  FilterChip(
                    avatar: SvgPicture.asset(
                      'assets/images/all_categories.svg',
                      width: 20,
                      height: 20,
                      colorFilter: ColorFilter.mode(
                        selectedCategory == null ? Colors.white : Theme.of(context).iconTheme.color!,
                        BlendMode.srcIn,
                      ),
                    ),
                    label: const Text('All'),
                    selected: selectedCategory == null,
                    onSelected: (selected) {
                      setState(() {
                        selectedCategory = null;
                      });
                    },
                  ),
                  const SizedBox(width: 8),
                  ...productData.categories.map((category) {
                    String iconPath = 'assets/images/${category.toLowerCase()}.svg';
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: FilterChip(
                        avatar: SvgPicture.asset(
                          iconPath,
                          width: 20,
                          height: 20,
                          colorFilter: ColorFilter.mode(
                            selectedCategory == category ? Colors.white : Theme.of(context).iconTheme.color!,
                            BlendMode.srcIn,
                          ),
                        ),
                        label: Text(category),
                        selected: selectedCategory == category,
                        onSelected: (selected) {
                          setState(() {
                            selectedCategory = selected ? category : null;
                          });
                        },
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
          Expanded(
            child: ProductGrid(selectedCategory: selectedCategory),
          ),
        ],
      ),
    );
  }
}