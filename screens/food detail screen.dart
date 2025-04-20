import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thebrandopedia_food_app/models/product model.dart';
import 'package:thebrandopedia_food_app/providers/cart_provider.dart';

class FoodDetailScreen extends StatefulWidget {
  final Product product;

  const FoodDetailScreen({super.key, required this.product});

  @override
  State<FoodDetailScreen> createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {
  int quantity = 1;
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.product.isFavorite;
  }

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Hero(
          tag: widget.product.name,
          child: Material(
            type: MaterialType.transparency,
            child: Text(widget.product.name),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.red,
            ),
            onPressed: toggleFavorite,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Hero(
              tag: widget.product.imageUrl,
              child: Image.asset(widget.product.imageUrl, height: 200),
            ),
            const SizedBox(height: 16),
            Text(
              widget.product.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              "₹${widget.product.price}",
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            if (widget.product.description.isNotEmpty)
              Text(
                widget.product.description,
                style: const TextStyle(fontSize: 16),
              ),
            const SizedBox(height: 16),
            if (widget.product.ingredients.isNotEmpty) ...[
              const Text("Ingredients:", style: TextStyle(fontSize: 18)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: widget.product.ingredients
                    .map((ingredient) => Chip(label: Text(ingredient)))
                    .toList(),
              ),
              const SizedBox(height: 16),
            ],
            if (widget.product.nutritionInfo.isNotEmpty) ...[
              const Text("Nutrition Information:", style: TextStyle(fontSize: 18)),
              const SizedBox(height: 8),
              ...widget.product.nutritionInfo.entries.map(
                (entry) => Text('${entry.key}: ${entry.value}'),
              ),
              const SizedBox(height: 16),
            ],
            if (widget.product.tags.isNotEmpty) ...[
              const Text("Tags:", style: TextStyle(fontSize: 18)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: widget.product.tags
                    .map((tag) => Chip(
                          label: Text(tag),
                          backgroundColor: Colors.blue[100],
                        ))
                    .toList(),
              ),
              const SizedBox(height: 16),
            ],
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Quantity:", style: TextStyle(fontSize: 18)),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        if (quantity > 1) {
                          setState(() {
                            quantity--;
                          });
                        }
                      },
                    ),
                    Text(quantity.toString(), style: const TextStyle(fontSize: 16)),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          quantity++;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                cartProvider.addToCart({
                  'name': widget.product.name,
                  'price': widget.product.price,
                  'imageUrl': widget.product.imageUrl,
                  'quantity': quantity,
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Added to cart")),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text("Add to Cart"),
            ),
          ],
        ),
      ),
    );
  }
}
