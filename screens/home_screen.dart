import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thebrandopedia_food_app/models/product model.dart'; 
import 'package:thebrandopedia_food_app/providers/cart_provider.dart';
import 'package:thebrandopedia_food_app/widgets/category_chip.dart';
import 'package:thebrandopedia_food_app/widgets/food_item_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  final List<String> categories = ['All', 'Food', 'Beverages', 'Favorites'];
  String selectedCategory = 'All';
  String searchQuery = '';

  final Set<Product> favoriteItems = {};
  final ScrollController scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();
  final GlobalKey searchBoxKey = GlobalKey();
  final FocusNode searchFocusNode = FocusNode();

  final List<Product> products = [
    Product(
      name: 'Margherita Pizza',
      price: 150,
      imageUrl: 'assets/images/pizza.png',
      category: 'Food',
      rating: 4.5,
      description: 'A cheesy pizza with fresh ingredients and a crispy crust.',
      ingredients: ['Cheese', 'Tomato', 'Olives', 'Basil'],
      tags: ['Cheesy', 'Vegetarian', 'Italian'],
    ),
    Product(
      name: 'Veg Burger',
      price: 99,
      imageUrl: 'assets/images/burger.png',
      category: 'Food',
      rating: 4.2,
      description: 'A tasty veggie burger with a delicious patty and fresh vegetables.',
      ingredients: ['Lettuce', 'Tomato', 'Veg Patty', 'Onion'],
      tags: ['Fast Food', 'Vegetarian', 'Snack'],
    ),
    Product(
      name: 'Coke',
      price: 40,
      imageUrl: 'assets/images/coke.png',
      category: 'Beverages',
      rating: 4.0,
      description: 'A refreshing carbonated drink.',
      ingredients: ['Carbonated Water', 'Sugar', 'Caffeine'],
      tags: ['Drink', 'Soda', 'Refreshment'],
    ),
    Product(
      name: 'Cold Coffee',
      price: 110,
      imageUrl: 'assets/images/coffee.png',
      category: 'Beverages',
      rating: 4.5,
      ingredients: ['Milk', 'Coffee', 'Sugar', 'Ice'],
      nutritionInfo: {'Calories': '180 kcal', 'Caffeine': '120mg', 'Sugar': '18g'},
      description: 'Chilled and creamy cold coffee blended with rich coffee flavor and ice.',
      tags: ['Beverage', 'Coffee', 'Iced', 'Caffeinated'],
    ),
    Product(
      name: 'French Fries',
      price: 90,
      imageUrl: 'assets/images/fries.png',
      category: 'Food',
      rating: 4.2,
      ingredients: ['Potatoes', 'Salt', 'Oil', 'Seasoning'],
      nutritionInfo: {'Calories': '300 kcal', 'Fat': '18g', 'Carbs': '35g'},
      description: 'Crispy and golden fries made from fresh potatoes, seasoned to perfection.',
      tags: ['Snacks', 'Vegetarian', 'Crispy', 'Finger Food'],
    ),
    Product(
      name: 'Pasta',
      price: 160,
      imageUrl: 'assets/images/pasta.png',
      category: 'Food',
      rating: 4.4,
      ingredients: ['Pasta', 'Cheese', 'Tomato Sauce', 'Herbs'],
      nutritionInfo: {'Calories': '400 kcal', 'Fat': '12g', 'Carbs': '55g'},
      description: 'Creamy pasta tossed in tomato sauce, cheese, and Italian herbs.',
      tags: ['Italian', 'Vegetarian', 'Comfort Food'],
    ),
    Product(
      name: 'Masala Dosa',
      price: 130,
      imageUrl: 'assets/images/dosa.png',
      category: 'Food',
      rating: 4.7,
      ingredients: ['Rice Batter', 'Potato Masala', 'Spices'],
      nutritionInfo: {'Calories': '350 kcal', 'Carbs': '50g', 'Protein': '8g'},
      description: 'South Indian crepe stuffed with spiced mashed potatoes, served with chutney & sambar.',
      tags: ['South Indian', 'Vegetarian', 'Traditional'],
    ),
    Product(
      name: 'Ice Cream',
      price: 80,
      imageUrl: 'assets/images/icecream.png',
      category: 'Dessert',
      rating: 4.6,
      ingredients: ['Milk', 'Sugar', 'Cream', 'Flavoring'],
      nutritionInfo: {'Calories': '210 kcal', 'Sugar': '22g', 'Fat': '12g'},
      description: 'Deliciously creamy ice cream available in a variety of classic flavors.',
      tags: ['Dessert', 'Frozen', 'Sweet', 'Chilled'],
    ),
    Product(
      name: 'Chole Bhature',
      price: 140,
      imageUrl: 'assets/images/chole.png',
      category: 'Food',
      rating: 4.8,
      ingredients: ['Chickpeas', 'Flour', 'Spices', 'Onion'],
      nutritionInfo: {'Calories': '500 kcal', 'Protein': '15g', 'Fat': '20g'},
      description: 'A popular North Indian combo of spicy chickpeas and fluffy deep-fried bhature.',
      tags: ['North Indian', 'Spicy', 'Traditional', 'Vegetarian'],
    ),
    Product(
      name: 'Paneer Wrap',
      price: 150,
      imageUrl: 'assets/images/wrap.png',
      category: 'Food',
      rating: 4.5,
      ingredients: ['Paneer', 'Tortilla', 'Onion', 'Capsicum', 'Spices'],
      nutritionInfo: {'Calories': '370 kcal', 'Protein': '18g', 'Carbs': '40g'},
      description: 'Soft wrap filled with spicy paneer, veggies, and flavorful sauces.',
      tags: ['Wrap', 'Vegetarian', 'Spicy', 'Fusion'],
    ),
  ];

  @override
  void dispose() {
    searchFocusNode.dispose();
    searchController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    final filteredProducts = (selectedCategory == 'Favorites'
            ? favoriteItems.toList()
            : selectedCategory == 'All'
                ? products
                : products.where((p) => p.category == selectedCategory).toList())
        .where((p) => p.name.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: SafeArea(
        child: ListView(
          controller: scrollController,
          padding: const EdgeInsets.all(16),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Chennai', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/profile'),
                  child: CircleAvatar(
                    backgroundColor: Colors.grey[200],
                    child: const Icon(Icons.person, color: Colors.black),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              key: searchBoxKey,
              child: TextField(
                controller: searchController,
                focusNode: searchFocusNode,
                decoration: InputDecoration(
                  hintText: 'Search for restaurants or dishes',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return GestureDetector(
                    onTap: () => setState(() {
                      selectedCategory = category;
                    }),
                    child: CategoryChip(
                      title: category,
                      isSelected: selectedCategory == category,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                color: Colors.orange[100],
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Image.asset('assets/images/burger.png', width: 60),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("30% OFF FOOD", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                            child: const Text("ORDER NOW"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                color: Colors.blue[100],
                padding: const EdgeInsets.all(16),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("30% OFF TRY IT NOW", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text("50% OFF USE 302406", style: TextStyle(color: Colors.blue)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text("Explore", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            if (filteredProducts.isNotEmpty)
              ...filteredProducts.map((product) {
                final isFav = favoriteItems.contains(product);
                return FoodItemTile(
                  imageUrl: product.imageUrl,
                  name: product.name,
                  price: product.price,
                  isFavorite: isFav,
                  onFavoriteToggle: () {
                    setState(() {
                      isFav ? favoriteItems.remove(product) : favoriteItems.add(product);
                    });
                  },
                  onAddToCart: () {
                    cartProvider.addToCart({
                      'name': product.name,
                      'price': product.price,
                      'imageUrl': product.imageUrl,
                    });
                  },
                  rating: product.rating,
                  description: product.description,
                  ingredients: product.ingredients,
                  tags: product.tags,
                );
              })
            else
              const Center(child: Text("No items found")),
          ],
        ),
      ),
bottomNavigationBar: BottomNavigationBar(
  currentIndex: currentIndex,
  onTap: (index) {
    setState(() {
      currentIndex = index;
    });
    if (index == 1) {
      Navigator.pushNamed(context, '/cart');
    } else if (index == 2) {
      Navigator.pushNamed(context, '/profile');
    } else if (index == 3) {
      Scrollable.ensureVisible(
        searchBoxKey.currentContext!,
        duration: const Duration(milliseconds: 500), 
        curve: Curves.easeInOut, 
      );
      searchFocusNode.requestFocus(); 
    } else if (index == 0) {
      Navigator.pushNamed(context, '/home');
    }
  },
  items: const [
    BottomNavigationBarItem(
      icon: Icon(Icons.home, color: Colors.black),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.shopping_cart, color: Colors.black),
      label: 'Cart',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person, color: Colors.black),
      label: 'Profile',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.search, color: Colors.black),
      label: 'Search',
    ),
  ],
),
    );
  }
}
