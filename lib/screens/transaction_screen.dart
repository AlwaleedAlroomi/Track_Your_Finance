import 'package:financial_tracker/config/routes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  final _noteController = TextEditingController();
  final FocusNode _amountFocusNode = FocusNode();
  final FocusNode _noteFocusNode = FocusNode();
  DateTime now = DateTime.now();
  DateFormat formatter = DateFormat('dd-MMM-yyyy');

  String _formatNumber(String value) {
    // Remove any non-digit characters
    String cleanedValue = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (cleanedValue.isEmpty) return '';

    // Convert to an integer and format with commas
    int number = int.parse(cleanedValue);
    return NumberFormat('#,###').format(number);
  }

  @override
  void dispose() {
    _amountFocusNode.dispose();
    _noteController.dispose();
    super.dispose();
  }

  String _getTransactionType() {
    switch (selectedIndex) {
      case 0:
        return "Income";
      case 1:
        return "Expense";
      case 2:
        return "Transfer";
      case 3:
        return "Wish";
      default:
        return "Unknown";
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.home,
                (route) => false,
              );
            },
            icon: const Icon(Icons.close),
            iconSize: 35,
          ),
          title: const Text(
            "New Transaction",
            style: TextStyle(color: AppColors.textPrimary),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final enteredAmount =
                      _amountController.text.replaceAll(",", "");
                  _noteFocusNode.unfocus();
                  _amountFocusNode.unfocus();
                  // Parse the cleaned string to a double
                  double amount = double.parse(enteredAmount);
                  String transactionType = _getTransactionType();

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: const Duration(seconds: 3),
                      content: Text(
                          "Amount entered: \$$amount, ${formatter.format(now)}, $transactionType\n${_noteController.text}, "),
                    ),
                  );
                }
              },
              icon: const Icon(Icons.save_alt),
              iconSize: 35,
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
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
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(200),
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextFormField(
                              focusNode: _amountFocusNode,
                              controller: _amountController,
                              onChanged: (value) {
                                String formattedValue = _formatNumber(value);
                                // Update the controller with the formatted value
                                _amountController.value = TextEditingValue(
                                  text: formattedValue,
                                  selection: TextSelection.collapsed(
                                      offset: formattedValue.length),
                                );
                              },
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              decoration: const InputDecoration(
                                hintText: "Amount",
                                hintStyle: TextStyle(
                                  color: AppColors.textSecondary,
                                ),
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                helperText: "",
                                errorStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
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

                                final parsedValue =
                                    double.tryParse(value.replaceAll(",", ""));
                                if (parsedValue == null || parsedValue <= 0) {
                                  return "Please enter a valid positive number.";
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              _buildTransactionFields(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: double.infinity,
                  child: TextField(
                    controller: _noteController,
                    focusNode: _noteFocusNode,
                    expands: true,
                    maxLines: null,
                    minLines: null,
                    decoration: const InputDecoration(
                      hintText: "Notes",
                      focusedBorder: InputBorder.none,
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
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

  Widget _buildTransactionFields() {
    if (selectedIndex == 0 || selectedIndex == 1) {
      return Column(
        children: [
          _transactionProperty(
            propertyName: 'Category',
            buttonText: 'Choose',
            onPressedFunc: () {},
          ),
          Divider(color: Colors.grey.shade300, thickness: 1),
          _transactionProperty(
            propertyName: 'Date',
            buttonText: formatter.format(now),
            onPressedFunc: () async {
              DateTime? selectedDate = await showDatePicker(
                context: context,
                initialDate: now,
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
              );
              if (selectedDate != null) {
                setState(() {
                  now = selectedDate;
                });
              }
            },
          ),
          Divider(color: Colors.grey.shade300, thickness: 1),
          _transactionProperty(
            propertyName: 'Account',
            buttonText: 'Choose',
            onPressedFunc: () {},
          ),
          Divider(color: Colors.grey.shade300, thickness: 1),
        ],
      );
    } else if (selectedIndex == 2) {
      return Column(
        children: [
          _transactionProperty(
            propertyName: 'Date',
            buttonText: formatter.format(now),
            onPressedFunc: () async {
              DateTime? selectedDate = await showDatePicker(
                context: context,
                initialDate: now,
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
              );
              if (selectedDate != null) {
                setState(() {
                  now = selectedDate;
                });
              }
            },
          ),
          Divider(color: Colors.grey.shade300, thickness: 1),
          _transactionProperty(
            propertyName: 'From',
            buttonText: 'Choose Account',
            onPressedFunc: () {},
          ),
          Divider(color: Colors.grey.shade300, thickness: 1),
          _transactionProperty(
            propertyName: 'To',
            buttonText: 'Choose Account',
            onPressedFunc: () {},
          ),
          Divider(color: Colors.grey.shade300, thickness: 1),
        ],
      );
    } else if (selectedIndex == 3) {
      return Column(
        children: [
          _transactionProperty(
            propertyName: 'Date',
            buttonText: formatter.format(now),
            onPressedFunc: () async {
              DateTime? selectedDate = await showDatePicker(
                context: context,
                initialDate: now,
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
              );
              if (selectedDate != null) {
                setState(() {
                  now = selectedDate;
                });
              }
            },
          ),
          Divider(color: Colors.grey.shade300, thickness: 1),
          _transactionProperty(
            propertyName: 'Account',
            buttonText: 'Choose',
            onPressedFunc: () {},
          ),
          Divider(color: Colors.grey.shade300, thickness: 1),
          _transactionProperty(
            propertyName: 'Wish Item',
            buttonText: 'Choose',
            onPressedFunc: () {},
          ),
          Divider(color: Colors.grey.shade300, thickness: 1),
        ],
      );
    }
    return const SizedBox.shrink();
  }

  Widget _transactionProperty(
      {required String propertyName,
      required String buttonText,
      required VoidCallback onPressedFunc}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            propertyName,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          TextButton(
            style: const ButtonStyle(
              iconColor: WidgetStatePropertyAll(AppColors.primary),
            ),
            onPressed: onPressedFunc,
            child: Row(
              children: [
                Text(
                  buttonText,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(
                  Icons.arrow_forward,
                  size: 14,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
