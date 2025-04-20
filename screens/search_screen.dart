import 'package:flutter/material.dart';
final List<Map<String, dynamic>> foodItems = [
  {'name': 'Margherita Pizza', 'price': 150, 'category': 'Food', 'imageUrl': 'assets/images/pizza.png'},
  {'name': 'Veg Burger', 'price': 99, 'category': 'Food', 'imageUrl': 'assets/images/burger.png'},
  {'name': 'Coca Cola', 'price': 50, 'category': 'Beverages', 'imageUrl': 'assets/images/coke.png'},
  {'name': 'Pepsi', 'price': 50, 'category': 'Beverages', 'imageUrl': 'assets/images/pepsi.png'},
  {'name': 'French Fries', 'price': 100, 'category': 'Food', 'imageUrl': 'assets/images/fries.png'},
  {'name': 'Ice Cream', 'price': 120, 'category': 'Offers', 'imageUrl': 'assets/images/ice_cream.png'},
];

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  List<Map<String, dynamic>> displayedItems = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    displayedItems = foodItems;
  }

  void _onSearchChanged(String query) {
    setState(() {
      searchQuery = query;
      displayedItems = foodItems
          .where((item) => item['name'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Search Food')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: 'Search for dishes...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: displayedItems.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Image.asset(displayedItems[index]['imageUrl'], width: 50),
                    title: Text(displayedItems[index]['name']),
                    subtitle: Text('₹${displayedItems[index]['price']}'),
                    onTap: () {
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
