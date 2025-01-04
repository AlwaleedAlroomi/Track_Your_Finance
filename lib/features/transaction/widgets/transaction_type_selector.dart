import 'package:flutter/material.dart';
import '../../../core/themes/colors.dart';

class TransactionTypeSelector extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const TransactionTypeSelector({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        height: 54,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(),
          borderRadius: BorderRadius.circular(200),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(200),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildButton(
                label: "Income",
                icon: Icons.attach_money,
                index: 0,
              ),
              _buildButton(
                label: "Expense",
                icon: Icons.attach_money,
                index: 1,
              ),
              _buildButton(
                label: "Transfer",
                icon: Icons.attach_money,
                index: 2,
              ),
              _buildButton(
                label: "Wish",
                icon: Icons.attach_money,
                index: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton({
    required String label,
    required IconData icon,
    required int index,
  }) {
    final bool isSelected = index == selectedIndex;
    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            children: [
              Icon(
                icon,
                color: isSelected ? Colors.white : Colors.black,
              ),
              const SizedBox(width: 4),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
