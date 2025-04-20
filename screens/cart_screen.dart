import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thebrandopedia_food_app/providers/cart_provider.dart';
import 'package:thebrandopedia_food_app/screens/loading screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Your Cart")),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          return cartProvider.cartItems.isEmpty
              ? const Center(child: Text("Your cart is empty"))
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListView.builder(
                        shrinkWrap: true, 
                        physics: const NeverScrollableScrollPhysics(), 
                        itemCount: cartProvider.cartItems.length,
                        itemBuilder: (context, index) {
                          final item = cartProvider.cartItems[index];
                          return Card(
                            child: ListTile(
                              leading: Image.asset(
                                item['imageUrl'],
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                              title: Text(item['name']),
                              subtitle: Text('₹${item['totalPrice']}'),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove),
                                    onPressed: () =>
                                        cartProvider.decreaseQuantity(index),
                                  ),
                                  Text(item['quantity'].toString()),
                                  IconButton(
                                    icon: const Icon(Icons.add),
                                    onPressed: () =>
                                        cartProvider.increaseQuantity(index),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Total: ₹${cartProvider.totalAmount}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            try {
                              final cartItems = cartProvider.cartItems;

                              if (cartItems.isNotEmpty) {
                                // Debug: Check if cartItems are properly initialized
                                print("Cart has items, proceeding to checkout.");

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoadingScreen(),
                                  ),
                                );

                                // Simulate a delay before navigating
                                await Future.delayed(const Duration(seconds: 2));

                                cartProvider.clearCart();
                                Navigator.pushReplacementNamed(
                                    context, '/checkout');
                              } else {
                                // Show a message if the cart is empty
                                print("Cart is empty, cannot proceed.");
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Your cart is empty.")),
                                );
                              }
                            } catch (e) {
                              print("Error navigating to checkout: $e");
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("An error occurred. Please try again.")),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            textStyle: const TextStyle(fontSize: 16),
                          ),
                          child: const Text('Order Now'),
                        ),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}

extension on CartProvider {
}
