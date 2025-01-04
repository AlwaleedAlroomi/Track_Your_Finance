import 'package:financial_tracker/core/routes/routes_name.dart';
import 'package:financial_tracker/features/accounts/domain/models/account_model.dart';
import 'package:flutter/material.dart';
import '../../../core/themes/colors.dart';

class AccountScreen extends StatefulWidget {
  final Account account;

  const AccountScreen({super.key, required this.account});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
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
          title: Text(
            widget.account.accountName,
            style: const TextStyle(color: AppColors.textPrimary),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, RouteNames.addEditAccount,
                    arguments: widget.account);
              },
              icon: const Icon(Icons.edit),
            ),
          ],
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(20),
            child: SizedBox(height: 20),
          ),
        ),
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("Net Worth"),
              const SizedBox(height: 20),
              Text(
                "${widget.account.balance}",
                style: const TextStyle(
                    fontSize: 40,
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const Text("Transaction"),
            ],
          ),
        ),
      ),
    );
  }
}
