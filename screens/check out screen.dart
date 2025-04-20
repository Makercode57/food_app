import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thebrandopedia_food_app/providers/cart_provider.dart';
import 'package:thebrandopedia_food_app/screens/loading screen.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  final _promoController = TextEditingController();
  final _addressController = TextEditingController();

  double discount = 0.0;

  void _applyPromo(String code, double total) {
    setState(() {
      if (code.toLowerCase() == 'brand10') {
        discount = total * 0.10;
      } else {
        discount = 0.0;
      }
    });
  }

  Future<void> _selectAddress() async {
    final selectedAddress = await Navigator.pushNamed(context, '/address-picker');
    if (selectedAddress != null && selectedAddress is String) {
      setState(() {
        _addressController.text = selectedAddress;
      });
    }
  }

  Future<void> _placeOrder(double finalAmount) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoadingScreen()),
    );

    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    Provider.of<CartProvider>(context, listen: false).clearCart();
    Navigator.pushReplacementNamed(context, '/order-success');
  }

  @override
  void dispose() {
    _promoController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final total = cartProvider.totalAmount;
    final finalAmount = total - discount;

    return Scaffold(
      appBar: AppBar(title: const Text("Checkout")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text("Delivery Address", style: TextStyle(fontSize: 18)),
              const SizedBox(height: 8),
              TextFormField(
                controller: _addressController,
                validator: (value) => value!.isEmpty ? "Enter address" : null,
                decoration: const InputDecoration(
                  hintText: "123, Street, City",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: _selectAddress,
                child: const Text("Select Address"),
              ),
              const SizedBox(height: 16),
              const Text("Promo Code", style: TextStyle(fontSize: 18)),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _promoController,
                      decoration: const InputDecoration(
                        hintText: "Enter promo code",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      _applyPromo(_promoController.text, total);
                    },
                    child: const Text("Apply"),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text("Total: ₹$total", style: const TextStyle(fontSize: 16)),
              if (discount > 0)
                Text("Discount: -₹$discount", style: const TextStyle(color: Colors.green)),
              const Divider(height: 32),
              Text("Payable Amount: ₹${finalAmount.toStringAsFixed(2)}",
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _placeOrder(finalAmount);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text("Pay Now"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
