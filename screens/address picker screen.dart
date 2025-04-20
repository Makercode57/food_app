import 'package:flutter/material.dart';

class AddressPickerScreen extends StatelessWidget {
  const AddressPickerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> addresses = [
      "123, Street, City",
      "456, Avenue, City",
      "789, Road, City"
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Select Address")),
      body: ListView.builder(
        itemCount: addresses.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(addresses[index]),
            onTap: () {
              Navigator.pop(context, addresses[index]); 
            },
          );
        },
      ),
    );
  }
}
