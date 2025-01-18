import 'package:financial_tracker/core/routes/routes_name.dart';
import 'package:financial_tracker/features/transaction/widgets/amount_input_field.dart';
import 'package:financial_tracker/features/transaction/widgets/transaction_type_selector.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/themes/colors.dart';

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

  @override
  void dispose() {
    _amountController.dispose();
    _amountFocusNode.dispose();
    _noteController.dispose();
    _noteFocusNode.dispose();
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
                RouteNames.home,
                (route) => false,
              );
            },
            icon: const Icon(Icons.close),
            iconSize: 35,
          ),
          title: Text(
            "New Transaction",
            style: Theme.of(context).textTheme.headlineMedium,
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
              TransactionTypeSelector(
                selectedIndex: selectedIndex,
                onItemTapped: (index) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
              ),
              const SizedBox(height: 50),
              AmountInputField(
                formKey: _formKey,
                controller: _amountController,
                focusNode: _amountFocusNode,
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

  Widget _buildTransactionFields() {
    switch (selectedIndex) {
      case 0:
      case 1:
        return _buildIncomeExpenseFields(); // Fields for Income and Expense
      case 2:
        return _buildTransferFields(); // Fields for Transfer
      case 3:
        return _buildWishFields(); // Fields for Wish
      default:
        return const SizedBox.shrink();
    }
  }

  // Builds fields for Income and Expense transactions
  Widget _buildIncomeExpenseFields() {
    return Column(
      children: [
        _transactionProperty(
          propertyName: 'Date',
          buttonText: formatter.format(now),
          onPressedFunc: () async {
            // Show a date picker and update the selected date
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
          propertyName: 'Category',
          buttonText: 'Choose',
          onPressedFunc: () {},
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
  }

  // Builds fields for Transfer transactions
  Widget _buildTransferFields() {
    return Column(
      children: [
        _transactionProperty(
          propertyName: 'Date',
          buttonText: formatter.format(now),
          onPressedFunc: () async {
            // Show a date picker and update the selected date
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
          buttonText: 'Choose',
          onPressedFunc: () {},
        ),
        Divider(color: Colors.grey.shade300, thickness: 1),
        _transactionProperty(
          propertyName: 'To',
          buttonText: 'Choose',
          onPressedFunc: () {},
        ),
        Divider(color: Colors.grey.shade300, thickness: 1),
      ],
    );
  }

  // Builds fields for Wish transactions
  Widget _buildWishFields() {
    return Column(
      children: [
        _transactionProperty(
          propertyName: 'Date',
          buttonText: formatter.format(now),
          onPressedFunc: () async {
            // Show a date picker and update the selected date
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
