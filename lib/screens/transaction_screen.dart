import 'package:flutter/material.dart';

import '../core/constants/colors.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => TransactionScreenState();
}

class TransactionScreenState extends State<TransactionScreen> {
  int selectedIndex = 0;
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 100,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7.5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close),
                      iconSize: 40,
                    ),
                    const Expanded(
                      child: Center(
                        child: Text(
                          "New Transaction",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final enteredAmount =
                              double.parse(_amountController.text);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              duration: const Duration(seconds: 3),
                              content: Text(
                                  "Amount entered: \$${enteredAmount.toStringAsFixed(2)}"),
                            ),
                          );
                        }
                      },
                      icon: const Icon(Icons.save_alt),
                      iconSize: 40,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                height: 54,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(200),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
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
                        label: "Wish",
                        icon: Icons.attach_money,
                        index: 2,
                      ),
                      _buildButton(
                        label: "Transfer",
                        icon: Icons.attach_money,
                        index: 3,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Form(
                  key: _formKey,
                  child: Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * .5,
                      child: TextFormField(
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          hintText: "Amount",
                          hintStyle: TextStyle(
                            color: AppColors.textSecondary,
                          ),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                        style: const TextStyle(
                          fontSize: 25,
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter an amount.";
                          }
                          final parsedValue = double.tryParse(value);
                          if (parsedValue == null || parsedValue <= 0) {
                            return "Please enter a valid positive number.";
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10)
          ],
        ),
      ),
    );
  }

  Widget _buildButton(
      {required String label, required IconData icon, required int index}) {
    final bool isSelected = index == selectedIndex;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.primary
                : Colors.transparent, // Background for selected button
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            children: [
              Icon(
                icon,
                color: isSelected
                    ? Colors.white
                    : Colors.black, // Icon color changes if selected
              ),
              const SizedBox(width: 4),
              Text(
                label,
                style: TextStyle(
                  color: isSelected
                      ? Colors.white
                      : Colors.black, // Text color changes if selected
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
