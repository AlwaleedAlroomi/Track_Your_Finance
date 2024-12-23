import 'package:financial_tracker/config/routes.dart';
import 'package:financial_tracker/core/constants/colors.dart';
import 'package:financial_tracker/features/accounts/domain/models/account_model.dart';
import 'package:flutter/material.dart';

class AddEditAccount extends StatefulWidget {
  final Account? account;
  const AddEditAccount({super.key, this.account});

  @override
  State<AddEditAccount> createState() => _AddEditAccountState();
}

class _AddEditAccountState extends State<AddEditAccount> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _accountNameController;
  late TextEditingController _accountBalanceController;
  @override
  void initState() {
    super.initState();
    _accountNameController =
        TextEditingController(text: widget.account?.accountName);
    _accountBalanceController =
        TextEditingController(text: widget.account?.balance.toString());
  }

  @override
  void dispose() {
    _accountNameController.dispose();
    _accountBalanceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.close,
              size: 30,
            ),
          ),
          title: const Text(
            "Add New Account",
            style: const TextStyle(color: AppColors.textPrimary),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.addEditAccount);
              },
              icon: const Icon(Icons.edit),
            ),
          ],
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(20),
            child: SizedBox(height: 20),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _accountNameController,
                  keyboardType: TextInputType.name,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    helperText: "",
                    labelText: "Account Name",
                  ),
                ),
                TextFormField(
                  controller: _accountBalanceController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    helperText: "",
                    labelText: "Account Balance",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}