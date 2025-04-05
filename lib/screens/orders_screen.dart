import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/currency_utils.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Temporary sample orders data
    final sampleOrders = [
      {
        'id': 'ORD001',
        'date': '2024-01-15',
        'status': 'Delivered',
        'total': 1349.98,
        'items': [
          {'name': 'iPhone 14 Pro', 'quantity': 1},
          {'name': 'Sony WH-1000XM4', 'quantity': 1}
        ]
      },
      {
        'id': 'ORD002',
        'date': '2024-01-10',
        'status': 'Processing',
        'total': 2499.99,
        'items': [
          {'name': 'MacBook Pro 16"', 'quantity': 1}
        ]
      },
      {
        'id': 'ORD003',
        'date': '2024-01-05',
        'status': 'Delivered',
        'total': 949.98,
        'items': [
          {'name': 'iPad Air', 'quantity': 1},
          {'name': 'Nintendo Switch OLED', 'quantity': 1}
        ]
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).primaryColor.withOpacity(0.7),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 80,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              children: [
                FilterChip(
                  avatar: CircleAvatar(
                    child: SvgPicture.asset(
                      'assets/images/all_orders.svg',
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).primaryColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  label: const Text('All'),
                  selected: true,
                  onSelected: (_) {},
                  backgroundColor: Colors.white,
                  selectedColor: Theme.of(context).primaryColor.withOpacity(0.1),
                ),
                const SizedBox(width: 8),
                FilterChip(
                  avatar: CircleAvatar(
                    backgroundColor: Colors.green.shade50,
                    child: SvgPicture.asset(
                      'assets/images/delivered.svg',
                      colorFilter: ColorFilter.mode(
                        Colors.green.shade700,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  label: const Text('Delivered'),
                  onSelected: (_) {},
                  backgroundColor: Colors.white,
                ),
                const SizedBox(width: 8),
                FilterChip(
                  avatar: CircleAvatar(
                    backgroundColor: Colors.orange.shade50,
                    child: SvgPicture.asset(
                      'assets/images/processing.svg',
                      colorFilter: ColorFilter.mode(
                        Colors.orange.shade700,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  label: const Text('Processing'),
                  onSelected: (_) {},
                  backgroundColor: Colors.white,
                ),
                const SizedBox(width: 8),
                FilterChip(
                  avatar: CircleAvatar(
                    backgroundColor: Colors.red.shade50,
                    child: SvgPicture.asset(
                      'assets/images/cancelled.svg',
                      colorFilter: ColorFilter.mode(
                        Colors.red.shade700,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  label: const Text('Cancelled'),
                  onSelected: (_) {},
                  backgroundColor: Colors.white,
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Theme.of(context).primaryColor.withOpacity(0.05),
                            Colors.white,
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Opacity(
                      opacity: 0.05,
                      child: SvgPicture.asset(
                        'assets/images/order_bg.svg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: sampleOrders.length,
                    itemBuilder: (context, index) {
                      final order = sampleOrders[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 16),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.white,
                                Colors.blue.shade50,
                              ],
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Order ${order['id']}',
                                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: order['status'] == 'Delivered'
                                            ? Colors.green.shade100
                                            : Colors.orange.shade100,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        '${order['status']}',
                                        style: TextStyle(
                                          color: order['status'] == 'Delivered'
                                              ? Colors.green.shade700
                                              : Colors.orange.shade700,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  'Ordered on ${order['date']}',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                const SizedBox(height: 12),
                                const Divider(),
                                const SizedBox(height: 8),
                                ...(order['items'] as List).map((item) => Container(
                                  margin: const EdgeInsets.only(bottom: 8),
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.1),
                                        spreadRadius: 1,
                                        blurRadius: 2,
                                        offset: const Offset(0, 1),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 60,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              'https://picsum.photos/200?random=${item['name'].hashCode}',
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '${item['name']}',
                                              style: const TextStyle(fontSize: 15),
                                            ),
                                            Text(
                                              'x${item['quantity']}',
                                              style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )).toList(),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Total',
                                      style: Theme.of(context).textTheme.titleMedium,
                                    ),
                                    Text(
                                      CurrencyUtils.formatInrPrice(order['total'] as double),
                                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}