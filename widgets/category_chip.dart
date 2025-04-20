import 'package:flutter/material.dart';

class CategoryChip extends StatelessWidget {
  final String title;
  final bool isSelected;

  const CategoryChip({
    super.key,
    required this.title,
    required this.isSelected,
  });

  String _getEmoji(String category) {
    switch (category) {
      case 'All':
        return '🍽';
      case 'Food':
        return '🍕';
      case 'Beverages':
        return '🥤';
      case 'Favorites':
        return '❤️';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final emoji = _getEmoji(title);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.purple[100] : Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
        border: isSelected
            ? Border.all(color: Colors.purple, width: 2)
            : Border.all(color: Colors.transparent),
      ),
      child: Row(
        children: [
          Text(
            emoji,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(width: 6),
          Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.purple[800] : Colors.black,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
